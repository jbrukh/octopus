class Api::RecordingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @recordings = Recording.all.order('created_at desc')
    render json: @recordings
  end

  def show
    @recording = Recording.find(params[:id])
    render json: @recording
  end

  def create
    @recording = Recording.new
    @recording.user = current_user

    if params[:recording][:participant_id]
      @recording.participant_id = params[:recording][:participant_id]
    end

    @recording.save!
    render json: @recording, :status => :created
  end

  def update
    @recording = Recording.find(params[:id])
    @recording.update_attributes!(recording_params)
    render json: @recording
  end

  def destroy
    @recording = Recording.find(params[:id])
    render json: @recording.trash!
  end

private
  def recording_params
    params.require(:recording).permit(:name, :description)
  end
end
