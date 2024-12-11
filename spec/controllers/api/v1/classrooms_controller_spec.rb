require 'rails_helper'

RSpec.describe Api::V1::ClassroomsController, type: :controller do
  let!(:classroom) { create(:classroom) }
  let(:valid_attributes) { { name: 'Room 101' } }
  let(:invalid_attributes) { { name: '' } }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: classroom.to_param }
      expect(response).to be_successful
    end

    it "returns not found for invalid id" do
      get :show, params: { id: 'invalid' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Classroom" do
        expect {
          post :create, params: { classroom: valid_attributes }
        }.to change(Classroom, :count).by(1)
      end

      it "renders a JSON response with the new classroom" do
        post :create, params: { classroom: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        post :create, params: { classroom: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: 'Room 102' } }

      it "updates the requested classroom" do
        put :update, params: { id: classroom.to_param, classroom: new_attributes }
        classroom.reload
        expect(classroom.name).to eq('Room 102')
      end

      it "renders a JSON response with the classroom" do
        put :update, params: { id: classroom.to_param, classroom: valid_attributes }
        expect(response).to be_successful
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        put :update, params: { id: classroom.to_param, classroom: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested classroom" do
      expect {
        delete :destroy, params: { id: classroom.to_param }
      }.to change(Classroom, :count).by(-1)
    end

    it "renders a JSON response with no content" do
      delete :destroy, params: { id: classroom.to_param }
      expect(response).to have_http_status(:no_content)
    end
  end
end 