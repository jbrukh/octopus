class Api::ResultsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_filter :authenticate_user!
  before_filter :find_recording

  def show
    authorize! :read, @recording
    render json: @recording, serializer: ResultSerializer
  end

  def update
    authorize! :update, @recording
    if @recording.upload(result_params)
      render json: @recording, :status => :created
    else
      render :text => 'recording data has already been uploaded', :status => :bad_request
    end
  end

private
  def find_recording
    @recording = Recording.find(params[:id])
  end

  def result_params
    params.require(:result).permit(:data, :data_file_name, :data_file_size, :data_content_type, :duration_ms)
  end
end
