require 'rails_helper'

RSpec.describe SaucesController, type: :controller do
  let(:valid_params) do { sauce: {nom: 'Sauce tomate', quantite: 500, prix: 3.99, description: 'Delicious tomato sauce', ingredients: 'Tomatoes, salt', caracteristique: 'Spicy'} } end
  let(:invalid_params) do { sauce: {nom: '', description: '', ingredients: '', caracteristique: '', quantite: nil, prix: nil}} end

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
end
