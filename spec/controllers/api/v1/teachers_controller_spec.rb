require 'rails_helper'

RSpec.describe Api::V1::TeachersController, type: :controller do
  let!(:teacher) { create(:teacher) }
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
      get :show, params: { id: teacher.to_param }
      expect(response).to be_successful
    end

    it "returns not found for invalid id" do
      get :show, params: { id: 'invalid' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Teacher" do
        expect {
          post :create, params: { teacher: valid_attributes }
        }.to change(Teacher, :count).by(1)
      end

      it "renders a JSON response with the new teacher" do
        post :create, params: { teacher: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        post :create, params: { teacher: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: 'Jane Doe' } }

      it "updates the requested teacher" do
        put :update, params: { id: teacher.to_param, teacher: new_attributes }
        teacher.reload
        expect(teacher.name).to eq('Jane Doe')
      end

      it "renders a JSON response with the teacher" do
        put :update, params: { id: teacher.to_param, teacher: valid_attributes }
        expect(response).to be_successful
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        put :update, params: { id: teacher.to_param, teacher: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested teacher" do
      expect {
        delete :destroy, params: { id: teacher.to_param }
      }.to change(Teacher, :count).by(-1)
    end

    it "renders a JSON response with no content" do
      delete :destroy, params: { id: teacher.to_param }
      expect(response).to have_http_status(:no_content)
    end
  end
end 