require 'rails_helper'

RSpec.describe Api::V1::SubjectsController, type: :controller do
  let!(:subject) { create(:subject) }
  let(:valid_attributes) { { name: 'Mathematics' } }
  let(:invalid_attributes) { { name: '' } }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: subject.to_param }
      expect(response).to be_successful
    end

    it "returns not found for invalid id" do
      get :show, params: { id: 'invalid' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Subject" do
        expect {
          post :create, params: { subject: valid_attributes }
        }.to change(Subject, :count).by(1)
      end

      it "renders a JSON response with the new subject" do
        post :create, params: { subject: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        post :create, params: { subject: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: 'Physics' } }

      it "updates the requested subject" do
        put :update, params: { id: subject.to_param, subject: new_attributes }
        subject.reload
        expect(subject.name).to eq('Physics')
      end

      it "renders a JSON response with the subject" do
        put :update, params: { id: subject.to_param, subject: valid_attributes }
        expect(response).to be_successful
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        put :update, params: { id: subject.to_param, subject: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested subject" do
      expect {
        delete :destroy, params: { id: subject.to_param }
      }.to change(Subject, :count).by(-1)
    end

    it "renders a JSON response with no content" do
      delete :destroy, params: { id: subject.to_param }
      expect(response).to have_http_status(:no_content)
    end
  end
end 