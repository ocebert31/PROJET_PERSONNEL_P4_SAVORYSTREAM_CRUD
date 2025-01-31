require 'rails_helper'

RSpec.describe SaucesController, type: :controller do
  let(:valid_params) { { sauce: attributes_for(:sauce) } }
  let(:invalid_params) { {sauce: attributes_for(:sauce_with_empty_fields)} }

  def expect_status(expected_status)
    expect(response).to have_http_status(expected_status)
  end

  def expect_sauce_list_attributes(json_response)
    expected_keys = ["id", "nom", "description", "ingredients", "caracteristique", "quantite", "prix"]
    expect(json_response.first.keys).to include(*expected_keys)
  end

  def expect_sauce_object_attributes(json_response)
    expected_keys = ["id", "nom", "description", "ingredients", "caracteristique", "quantite", "prix"]
    expect(json_response.keys).to include(*expected_keys)
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new sauce' do
        expect { post :create, params: valid_params }.to change(Sauce, :count).by(1)
      end

      it 'returns a 201 status' do
        post :create, params: valid_params
        expect_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new sauce' do
        expect { post :create, params: invalid_params }.not_to change(Sauce, :count)
      end

      it 'returns a 422 status' do
        post :create, params: invalid_params
        expect_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
  let!(:sauce) { create(:sauce)}
    context "when the sauce exists" do
      it "destroys the sauce and returns ok status" do
        expect { delete :destroy, params: { id: sauce.id } }.to change(Sauce, :count).by(-1)
        expect_status(:ok)
      end
    end

    context "when the sauce doesn't exist" do
      it "returns an error message with unprocessable entity status" do
        expect { delete :destroy, params: { id: 999999 } }.not_to change(Sauce, :count)
        expect_status(:not_found)
      end
    end
  end

  describe "GET #index" do
    context "when sauces exist" do
      before do
        create_list(:sauce, 3)
      end

      it "returns a successful response" do
        get :index
        expect_status(:ok)
      end

      it "returns all sauces in JSON format" do
        get :index
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq(3)
      end

      it "returns the correct attributes" do
        get :index
        json_response = JSON.parse(response.body)
        expect_sauce_list_attributes(json_response)
      end
    end

    context "when no sauces exist" do
      it "returns an empty array with a status" do
        get :index
        json_response = JSON.parse(response.body)
        expect(json_response["sauces"]).to eq([])
        expect_status(:ok)
      end
    end
  end

  describe "GET #show" do
  let!(:sauce) { create(:sauce)}
    context "when the sauce exists" do
      it "returns the sauce in JSON format with a 200 status" do
        get :show, params: { id: sauce.id }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect_sauce_object_attributes(json_response)
      end
    end

    context "when the sauce does not exist" do
      it "returns a 404 error" do
        get :show, params: { id: 9999 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end