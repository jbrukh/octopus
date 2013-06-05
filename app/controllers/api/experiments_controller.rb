class Api::ExperimentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @experiments = Experiment.all
    render json: @experiments
  end

  def show
    @experiment = Experiment.find(params[:id])
    authorize! :read, @experiment
    render json: @experiment
  end

  def create
    @experiment = Experiment.new(experiment_params)
    @experiment.media = Media.find(params[:experiment][:media_id])
    @experiment.user = current_user
    @experiment.save!
    render json: @experiment, :status => :created
  end

  def destroy
    @experiment = Experiment.find(params[:id])
    render json: @experiment.destroy()
  end

private
  def experiment_params
    params.require(:experiment).permit(:name, :description)
  end
end