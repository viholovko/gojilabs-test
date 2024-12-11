class Api::V1::ClassroomsController < Api::V1::BaseController
  before_action :set_classroom, only: [:show, :update, :destroy]

  # GET /api/v1/classrooms
  def index
    @classrooms = Classroom.all
    render json: @classrooms
  end

  # GET /api/v1/classrooms/:id
  def show
    render json: @classroom
  end

  # POST /api/v1/classrooms
  def create
    @classroom = Classroom.new(classroom_params)
    if @classroom.save
      render json: @classroom, status: :created
    else
      render json: @classroom.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/classrooms/:id
  def update
    if @classroom.update(classroom_params)
      render json: @classroom
    else
      render json: @classroom.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/classrooms/:id
  def destroy
    @classroom.destroy
    head :no_content
  end

  private

  def set_classroom
    @classroom = Classroom.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Classroom not found' }, status: :not_found
  end

  def classroom_params
    params.require(:classroom).permit(:name)
  end
end
