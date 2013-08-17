class Api::ResultsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_filter :authenticate_user!
  before_filter :find_recording

  def show
    @recording
    render json: @recording, serializer: ResultSerializer
  end

  def update
    @recording.upload(result_params)
    render json: @recording, :status => :created
    ProcessResultWorker.perform_async(@recording.id)
  end

private
  def find_recording
    @recording = Recording.viewable_by(current_user).find(params[:id])
  end

  def result_params
    params.require(:result).permit(:data)
  end
end
