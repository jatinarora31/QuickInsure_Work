class AuthorsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def author_params
        params.require(:author).permit(:author_name, :nationality, :birth_year)
    end

    def index
        authors = Author.all
        render json: authors
    end

    def show
        author = Author.find_by(id: params[:id])
        if author
            render json: author
        else
            render json: { error: "Author not found"}, status: 404
        end
    end

    def create
        author = Author.new(author_params)
        if author.save
            render json: author
        else
            render json: author.errors
        end
    end
end
