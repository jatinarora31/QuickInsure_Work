class CategoriesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def category_param
        params.require(:category).permit(:name, :description)
    end

    def index
        categories = Category.all
        render json: categories
    end

    def show
        category = Category.find_by(id: params[:id])
        if category
            render json: category
        else
            render json: { error: "No category found" }
        end
    end

    def create
        category = Category.new(category_param)
        if category.save
            render json: { message: "Category Created", data: category }
        else
            render json: { message: "Something went wrong", data: category.errors }
        end
    end
end

