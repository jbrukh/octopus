class Api::TaggingsController < ApplicationController
  before_filter :authenticate_user!
  before_action :load_recording

  def create
    authorize! :update, @recording

    @tagging = @recording.taggings.build(tagging_params)
    @tagging.user = current_user
    @tagging.save!

    render json: @tagging, :status => :created
  end

private
  def load_recording
    @recording = Recording.find(params[:recording_id])
  end

  def tagging_params
    params.require(:tagging).permit(:name, :from_ms, :to_ms)
  end
end
