class Api::ResultsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_recording

  def create

  end

  private
    def find_recording
      @recording = Recording.find(params[:recording_id])
    end

end
