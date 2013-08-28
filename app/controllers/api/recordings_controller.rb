class Api::RecordingsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_participant, :only => :index, :if => :has_participant_id
  before_action :load_recording, :only => [:show, :update, :destroy]

  def index
    @recordings = if params[:participant_id]
      @participant.recordings
    else
      Recording.viewable_by(current_user).order('created_at desc')
    end

    @recordings = @recordings.page(params[:page])

    render json: @recordings, meta: {
      page:         @recordings.current_page,
      total_count:  @recordings.total_count,
      total_pages:  @recordings.total_pages
    }
  end

  def show
    authorize! :read, @recording
    render json: @recording
  end

  def create
    @recording = Recording.new(recording_params)
    @recording.user = current_user

    if params[:recording][:participant_id]
      @recording.participant_id = params[:recording][:participant_id]
    end

    @recording.save!
    render json: @recording, :status => :created
  end

  def update
    authorize! :update, @recording
    @recording.update_attributes!(recording_params)
    render json: @recording
  end

  def destroy
    authorize! :destroy, @recording
    render json: @recording.trash!
  end

private

  def recording_params
    params.require(:recording).permit(:name, :description, :duration_ms)
  end

  def load_recording
    @recording = Recording.includes(:user).find(params[:id])
  end

  def load_participant
    @participant = Participant.find(params[:participant_id])
    authorize! :read, @participant
  end

  def has_participant_id
    !params[:participant_id].blank?
  end
end
