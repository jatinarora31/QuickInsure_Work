class BooksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def book_params
        params.require(:book).permit(:title, :isbn, :edition, :copies, :category_id, :publisher_id, author_ids: [])
    end

    def index
        if params[:category_id]
            books = Book.includes(:authors).where(category_id: params[:category_id])
        else
            books = Book.includes(:authors)
        end

        render json: books, include: :authors
    end

    def create
        book = Book.new(book_params)
        if book.save
            render json: book, include: :authors
        else
            render json: { errors: book.errors.full_messages }, status: 422
        end
    end

    def show
        book = Book.find_by(id: params[:id])
        if book
            render json: book, include: :authors
        else
            render json: { message: "Book not found" }
        end
    end
end


