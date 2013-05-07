class Api::RecordingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @recordings = Recording.all
    render json: @recordings
  end
end
