class Api::SlideshowsController < ApplicationController
  def index
    @slideshows = Slideshow.all
    render json: @slideshows
  end

  def show
    @slideshow = Slideshow.find(params[:id])
    render json: @slideshow
  end

  def create
    @slideshow = Slideshow.create!(slideshow_params)
    redirect_to api_slideshow_url(@slideshow)
  end

  private
    def slideshow_params
      params.require(:slideshow).permit(:name)
    end
end
