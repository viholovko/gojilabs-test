class Api::V1::TeachersController < Api::V1::BaseController
  before_action :set_teacher, only: [:show, :update, :destroy]

  # GET /api/v1/teachers
  def index
    @teachers = Teacher.all
    render json: @teachers
  end

  # GET /api/v1/teachers/:id
  def show
    render json: @teacher
  end

  # POST /api/v1/teachers
  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      render json: @teacher, status: :created
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/teachers/:id
  def update
    if @teacher.update(teacher_params)
      render json: @teacher
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/teachers/:id
  def destroy
    @teacher.destroy
    head :no_content
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Teacher not found' }, status: :not_found
  end

  def teacher_params
    params.require(:teacher).permit(:name, :email)
  end
end
