class Api::V1::SubjectsController < Api::V1::BaseController
  before_action :set_subject, only: [:show, :update, :destroy]

  # GET /api/v1/subjects
  def index
    @subjects = Subject.all
    render json: @subjects
  end

  # GET /api/v1/subjects/:id
  def show
    render json: @subject
  end

  # POST /api/v1/subjects
  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      render json: @subject, status: :created
    else
      render json: @subject.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/subjects/:id
  def update
    if @subject.update(subject_params)
      render json: @subject
    else
      render json: @subject.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/subjects/:id
  def destroy
    @subject.destroy
    head :no_content
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Subject not found' }, status: :not_found
  end

  def subject_params
    params.require(:subject).permit(:name)
  end
end
