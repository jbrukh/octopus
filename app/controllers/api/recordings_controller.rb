class Api::RecordingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @recordings = Recording.all
    render json: @recordings
  end

  def create
    @recording = Recording.new(recording_params)
    @recording.state = 'waiting_for_data'
    @recording.user = current_user
    @recording.save!
    redirect_to api_recordings_url(@recording)
  end

  private
    def recording_params
      params.require(:recording).permit(:name)
    end
end
