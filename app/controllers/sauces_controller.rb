class SaucesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    def create
      @sauce = Sauce.new(sauce_params)
      if @sauce.save
        render json: { sauce: @sauce }, status: :created
      else
        render json: @sauce.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def sauce_params
      params.require(:sauce).permit(:nom, :description, :ingredients, :caracteristique, :quantite, :prix)
    end
  end
  