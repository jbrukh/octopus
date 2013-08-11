class Api::ResultsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_filter :authenticate_user!
  before_filter :find_recording

  def show
    respond_to do |format|
      format.csv { send_data @recording.to_csv, :filename => "octopus_#{@recording.id}.csv" }
    end
  end

  def create
    @recording.upload(result_params)
    render json: @recording, :status => :created
    ProcessResultWorker.perform_async(@recording.id)
  end

private
  def find_recording
    @recording = Recording.find(params[:recording_id])
  end

  def result_params
    params.require(:result).permit(:data)
  end
end
