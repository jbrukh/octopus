class Api::VideosController < ApplicationController
  before_filter :authenticate_user!

  def index
    @videos = Video.all
    render json: @videos
  end

  def show
    @video = Video.find(params[:id])
    render json: @video
  end

  def create
    @video = Video.new(video_params)
    @video.user = current_user
    @video.save!
    render json: @video, :status => :created
  end

  def destroy
    @video = Video.find(params[:id])
    render json: @video.trash!
  end

private
  def video_params
    params.require(:video).permit(:name, :description, :data)
  end
end