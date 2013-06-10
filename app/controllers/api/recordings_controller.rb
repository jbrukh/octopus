class Api::RecordingsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_participant, :only => :index, :if => :has_participant_id

  def index
    @recordings = if params[:participant_id]
      @participant.recordings
    else
      Recording.all.order('created_at desc')
    end
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

  def load_participant
    @participant = Participant.find(params[:participant_id])
  end

  def has_participant_id
    !params[:participant_id].blank?
  end
end
