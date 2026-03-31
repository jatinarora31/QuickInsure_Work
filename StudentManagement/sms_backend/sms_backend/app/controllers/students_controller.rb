class StudentsController < ApplicationController

  def index
    render json: Student.all()
  end

  def create
    student = Student.new(student_param)
    if student.save
      render json: student
    else
      render json: student.errors
    end
  end

  def student_param
    param = params.permit(:admission_no,:rollno,:name,:standard,:dob,:mark_id)
  end

end
