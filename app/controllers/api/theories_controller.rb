class Api::TheoriesController < ApplicationController
  #before_filter :authenticate_user!

  def index
    @theories = Theory.all
    render json: @theories
  end

  def show
    @theory = Theory.find(params[:id])
    render json: @theory
  end

  def create
    @theory = Theory.new(theory_params)
    @theory.media = Media.find(params[:theory][:media_id])
    @theory.save!
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