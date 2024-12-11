class Api::V1::StudentsController < Api::V1::BaseController
  before_action :set_student, only: [:show, :update, :destroy, :add_section, :remove_section, :schedule_pdf]

  # GET /api/v1/students
  def index
    @students = Student.all
    render json: @students
  end

  # GET /api/v1/students/:id
  def show
    render json: @student
  end

  # POST /api/v1/students
  def create
    @student = Student.new(student_params)
    if @student.save
      render json: @student, status: :created
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/students/:id
  def update
    if @student.update(student_params)
      render json: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/students/:id
  def destroy
    @student.destroy
    head :no_content
  end

  # POST /api/v1/students/:id/add_section/:section_id
  def add_section
    section = Section.find(params[:section_id])
    if @student.add_section(section)
      render json: @student.sections, status: :ok
    else
      render json: { error: 'Section conflicts with existing schedule' }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/students/:id/remove_section/:section_id
  def remove_section
    section = Section.find(params[:section_id])
    if @student.sections.delete(section)
      render json: @student.sections, status: :ok
    else
      render json: { error: 'Failed to remove section' }, status: :unprocessable_entity
    end
  end

  # GET /api/v1/students/:id/schedule
  def schedule_pdf
    pdf = generate_schedule_pdf(@student)
    send_data pdf.render, filename: "schedule_#{@student.id}.pdf", type: 'application/pdf', disposition: 'inline'
  end

  private

  def set_student
    @student = Student.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Student not found' }, status: :not_found
  end

  def student_params
    params.require(:student).permit(:name, :email)
  end

  def generate_schedule_pdf(student)
    Prawn::Document.new do
      text "Schedule for #{student.name}", size: 20, style: :bold
      move_down 10
      student.sections.each do |section|
        text "Subject: #{section.subject.name}"
        text "Teacher: #{section.teacher.name}"
        text "Classroom: #{section.classroom.name}"
        text "Days: #{section.days}"
        text "Time: #{section.start_time.strftime('%H:%M')} - #{section.end_time.strftime('%H:%M')}"
        move_down 10
      end
    end
  end
end