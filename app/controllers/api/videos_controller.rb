class Api::VideosController < ApplicationController
  def index
    @videos = Video.all
    render json: @videos
  end

  def show
    @video = Video.find(params[:id])
    render json: @video
  end

  def create
    @video = Video.create!(video_params)
    redirect_to api_video_url(@video)
  end

  private
    def video_params
      params.require(:video).permit(:name)
    end
end