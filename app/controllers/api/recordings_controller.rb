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
    @recording.save!
    render json: @recording, :status => :created
  end
end
