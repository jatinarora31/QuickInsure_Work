class MarksController < ApplicationController
  before_action :set_mark, only: %i[ show ]

  def index
    render json: Mark.all()
  end

  def show
    render json: @mark
  end

  def create
    mark = Mark.new(makrs_param)
    if mark.save
      render json: mark
    else
      render json: mark.errors
    end
  end

  private

  def makrs_param()
    param = params.permit(:maths,:physics,:chemistry,:english,:optional)
  end

  def set_mark
    @mark = Mark.find_by(id: params[:id])
    if @mark.nil?
      render json: { error: "Marks not found" }, status: :not_found
    end
  end

end
