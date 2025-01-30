class SaucesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :destroy]
    before_action :set_sauce, only: %i[destroy]

    def create
      @sauce = Sauce.new(sauce_params)
      if @sauce.save
        render json: { sauce: @sauce }, status: :created
      else
        render json: @sauce.errors, status: :unprocessable_entity
      end
    end

    def destroy
        if @sauce.destroy
            head :no_content
        else
            render json: { error: "Failed to delete sauce" }, status: :unprocessable_entity
        end
    end
  
    private

    def set_sauce
        @sauce = Sauce.find_by(id: params[:id])
        unless @sauce
          render json: { error: 'Sauce not found' }, status: :unprocessable_entity
        end
    end
      
  
    def sauce_params
      params.require(:sauce).permit(:nom, :description, :ingredients, :caracteristique, :quantite, :prix)
    end
  end
  