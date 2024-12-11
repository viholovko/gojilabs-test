require 'rails_helper'

RSpec.describe Api::V1::SectionsController, type: :controller do
  let!(:teacher) { create(:teacher) }
  let!(:subject) { create(:subject) }
  let!(:classroom) { create(:classroom) }
  let!(:section) { create(:section, teacher: teacher, subject: subject, classroom: classroom) }
  let(:valid_attributes) { { teacher_id: teacher.id, subject_id: subject.id, classroom_id: classroom.id, start_time: '09:00', end_time: '09:50', days: 'MWF' } }
  let(:invalid_attributes) { { start_time: '', end_time: '', days: '' } }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: section.to_param }
      expect(response).to be_successful
    end

    it "returns not found for invalid id" do
      get :show, params: { id: 'invalid' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Section" do
        expect {
          post :create, params: { section: valid_attributes }
        }.to change(Section, :count).by(1)
      end

      it "renders a JSON response with the new section" do
        post :create, params: { section: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        post :create, params: { section: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { start_time: '10:00', end_time: '10:50' } }

      it "updates the requested section" do
        put :update, params: { id: section.to_param, section: new_attributes }
        section.reload
        expect(section.start_time.strftime('%H:%M')).to eq('10:00')
      end

      it "renders a JSON response with the section" do
        put :update, params: { id: section.to_param, section: valid_attributes }
        expect(response).to be_successful
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        put :update, params: { id: section.to_param, section: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested section" do
      expect {
        delete :destroy, params: { id: section.to_param }
      }.to change(Section, :count).by(-1)
    end

    it "renders a JSON response with no content" do
      delete :destroy, params: { id: section.to_param }
      expect(response).to have_http_status(:no_content)
    end
  end
end 