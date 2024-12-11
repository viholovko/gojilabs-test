require 'rails_helper'

RSpec.describe Api::V1::StudentsController, type: :controller do
  let!(:student) { create(:student) }
  let!(:section) { create(:section) }
  let(:valid_attributes) { { name: 'John Doe', email: 'john.doe@example.com' } }
  let(:invalid_attributes) { { name: '', email: 'invalid' } }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: student.to_param }
      expect(response).to be_successful
    end

    it "returns not found for invalid id" do
      get :show, params: { id: 'invalid' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Student" do
        expect {
          post :create, params: { student: valid_attributes }
        }.to change(Student, :count).by(1)
      end

      it "renders a JSON response with the new student" do
        post :create, params: { student: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        post :create, params: { student: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: 'Jane Doe' } }

      it "updates the requested student" do
        put :update, params: { id: student.to_param, student: new_attributes }
        student.reload
        expect(student.name).to eq('Jane Doe')
      end

      it "renders a JSON response with the student" do
        put :update, params: { id: student.to_param, student: valid_attributes }
        expect(response).to be_successful
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        put :update, params: { id: student.to_param, student: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested student" do
      expect {
        delete :destroy, params: { id: student.to_param }
      }.to change(Student, :count).by(-1)
    end

    it "renders a JSON response with no content" do
      delete :destroy, params: { id: student.to_param }
      expect(response).to have_http_status(:no_content)
    end
  end

  describe "POST #add_section" do
    it "adds a section to the student's schedule" do
      post :add_section, params: { id: student.id, section_id: section.id }
      expect(response).to have_http_status(:ok)
      expect(student.sections).to include(section)
    end

    it "returns an error if the section conflicts with the student's schedule" do
      allow_any_instance_of(Student).to receive(:add_section).and_return(false)
      post :add_section, params: { id: student.id, section_id: section.id }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('Section conflicts with existing schedule')
    end
  end

  describe "DELETE #remove_section" do
    before do
      student.sections << section
    end

    it "removes a section from the student's schedule" do
      delete :remove_section, params: { id: student.id, section_id: section.id }
      expect(response).to have_http_status(:ok)
      expect(student.sections).not_to include(section)
    end
  end

  describe "GET #schedule_pdf" do
    it "generates a PDF of the student's schedule" do
      get :schedule_pdf, params: { id: student.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/pdf')
    end
  end
end