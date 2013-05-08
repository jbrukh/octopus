class Api::ResultsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_recording

  def create
    @result = @recording.build_result(result_params)
    @recording.save!
    redirect_to api_recording_result_url(@recording, @result)
  end

  private
    def find_recording
      @recording = Recording.find(params[:recording_id])
    end

    def result_params
      params.require(:result).permit(:duration)
    end
end