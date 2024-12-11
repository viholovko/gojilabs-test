class Api::V1::SectionsController < Api::V1::BaseController
  before_action :set_section, only: [:show, :update, :destroy]

  # GET /api/v1/sections
  def index
    @sections = Section.all
    render json: @sections
  end

  # GET /api/v1/sections/:id
  def show
    render json: @section
  end

  # POST /api/v1/sections
  def create
    @section = Section.new(section_params)
    if @section.save
      render json: @section, status: :created
    else
      render json: @section.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/sections/:id
  def update
    if @section.update(section_params)
      render json: @section
    else
      render json: @section.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/sections/:id
  def destroy
    @section.destroy
    head :no_content
  end

  private

  def set_section
    @section = Section.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Section not found' }, status: :not_found
  end

  def section_params
    params.require(:section).permit(:teacher_id, :subject_id, :classroom_id, :start_time, :end_time, :days)
  end
end
