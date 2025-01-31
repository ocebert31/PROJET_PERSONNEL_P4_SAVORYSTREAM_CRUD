class SaucesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy, :show, :update]
  before_action :set_sauce, only: %i[destroy show update]

  def index
    @sauces = Sauce.all
    if @sauces.empty?
      render json: { sauces: [], message: "Aucune sauce trouvée" }, status: :ok
    else
      render json: @sauces, status: :ok
    end
  end

  def show
    render json: @sauce, status: :ok
  end

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
      render json: { message: "Sauce successfully deleted" }, status: :ok
    else
      render json: { error: "Failed to delete sauce" }, status: :unprocessable_entity
    end
  end

  def update
    if @sauce.update(sauce_params)
      render json: { sauce: @sauce }, status: :ok
    else
      render json: @sauce.errors, status: :unprocessable_entity
    end
  end

  private

  def set_sauce
    @sauce = Sauce.find_by(id: params[:id])
    render json: { error: 'Sauce not found' }, status: :not_found unless @sauce
  end

  def sauce_params
    params.require(:sauce).permit(:nom, :description, :ingredients, :caracteristique, :quantite, :prix)
  end
end
