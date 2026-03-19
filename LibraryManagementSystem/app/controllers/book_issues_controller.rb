class BookIssuesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_book_issue, only: %i[ show update destroy book_return ]

  def index
    render json: BookIssue.all
  end

  def show
    render json: @book_issue
  end

  def create
    @book_issue = BookIssue.new(book_issue_params)

    if @book_issue.save
      book = @book_issue.book
      authors = book.authors
      publisher = book.publisher
      category = book.category

      render json: {
        message: "You issued this book for 7 days. Please return on #{@book_issue.due_date}",
        data: {
          book_issue_id: @book_issue.id,
          book_title: book.title,
          isbn: book.isbn,
          edition: book.edition,
          category: category.name,
          publisher: publisher.publisher_name,

          authors: authors.map do |author|
            {
              name: author.author_name,
              birth_year: author.birth_year
            }
          end,
          
          issue_date: @book_issue.issue_date,
          due_date: @book_issue.due_date
        }
      } , status: :created

    else
      render json: @book_issue.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book_issue.update(book_issue_params)
      render :show, status: :ok, location: @book_issue
    else
      render json: @book_issue.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book_issue.destroy!
  end

  def book_return
    book_issue = BookIssue.find_by(id: params[:id])

    if book_issue.nil?
      render json: { error: "BookIssue not found" }, status: 404
      return
    end

    if book_issue.return_date.present?
      render json: { message: "Book already returned" }, status: 422
      return 
    end

    book_issue.update(return_date: Date.today)
    render json:  { message: "Book returned successfully", data: book_issue }

  end


  private

    def set_book_issue
      @book_issue = BookIssue.find_by(id: params[:id])
      
      unless @book_issue
        render json: { error: "Book Issue not found" }, status:404
        return
      end
    end

    def book_issue_params
      params.require(:book_issue).permit(:book_id, :user_id, :return_date)
    end
end
