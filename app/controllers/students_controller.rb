class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index 
        students = Student.all 
        render json: students
    end 

    def show 
        student = Student.find(params[:id])
        render json: student 
    end 

    def create 
        student = Student.create!(create_params)
        render json: student, status: :created
    end

    def update 
        student = Student.find(params[:id])
        Student.update
        render json: student, status: :accepted
    end 

    def destroy 
        student = Student.find(params[:id])
        student.destroy
        
        head :no_content
    end 

private 

    def create_params
        params.permit(:instructor_id, :name, :major, :age)
    end

    def record_invalid(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def record_not_found(exception)
        render json: { error: "#{exception.method} not found" }, status: :not_found
    end


end
