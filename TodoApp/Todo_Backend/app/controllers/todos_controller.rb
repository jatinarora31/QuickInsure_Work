class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_todo, only: %i[ show edit update destroy update_status ]

  def index
    todos = Todo.all
    render json: todos
  end

  def show
    render json: @todo
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.is_completed = false

    if @todo.save
      render json: @todo, status: :created
    else
      render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo, status: :ok
    else
      render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_status
    if @todo.update(update_status_param)
      render json: @todo, status: :ok
    else
      render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity  
    end
  end

  def destroy
    @todo.destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_todo
      @todo = Todo.find(params[:id])
    end

    def todo_params
      params.permit(:title, :description)
    end

    def update_status_param
      params.permit(:is_completed)
    end

end
