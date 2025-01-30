require 'rails_helper'

RSpec.describe SaucesController, type: :controller do
  let(:valid_params) { { sauce: attributes_for(:sauce) } }
  let(:invalid_params) { {sauce: attributes_for(:sauce_with_empty_fields)} }
  let!(:sauce) { create(:sauce) }

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new sauce' do
        expect { post :create, params: valid_params }.to change(Sauce, :count).by(1)
      end

      it 'returns a 201 status' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new sauce' do
        expect { post :create, params: invalid_params }.not_to change(Sauce, :count)
      end

      it 'returns a 422 status' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when the sauce exists" do
      it "destroys the sauce and returns no content status" do
        expect { delete :destroy, params: { id: sauce.id } }.to change(Sauce, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the sauce doesn't exist" do
      it "returns an error message with unprocessable entity status" do
        expect { delete :destroy, params: { id: 999999 } }.not_to change(Sauce, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
end
end
