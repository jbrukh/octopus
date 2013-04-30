class Api::TheoriesController < ApplicationController
  def index
    @theories = Theory.all
    render json: @theories
  end

  def show
    @theory = Theory.find(params[:id])
    render json: @theory
  end

  def create
    @theory = Theory.create!(theory_params)
    redirect_to api_theory_url(@theory)
  end

  def destroy
    @theory = Theory.find(params[:id])
    render json: @theory.destroy()
  end

  private
    def theory_params
      params.require(:theory).permit(:name, :description)
    end
end