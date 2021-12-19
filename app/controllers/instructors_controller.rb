class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid


    def index 
        instructors = Instructor.all 
        render json: instructors 
    end

    def show 
        instructor = Instructor.find(params[:id])
        render json: instructor 
    end 

    def create 
        instructor = Instructor.create!(create_params)
        render json: instructor, status: :created 
    end

    def update 
        instructor = Instructor.find(params[:id])
        instructor.update!(create_params)
        render json: instructor, status: :ok
    end 

    def destroy 
        instructor = Instructor.find(params[:id])
        instructor.destroy 

        head :no_content
    end

private 

    def record_not_found(exception)
        render json: { error: "#{exception.model} not found" }, status: :not_found
    end 

    def record_invalid(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def create_params 
        params.permit(:name)
    end 

end
