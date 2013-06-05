class Api::SlideshowsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @slideshows = Slideshow.all
    render json: @slideshows
  end

  def show
    @slideshow = Slideshow.find(params[:id])
    render json: @slideshow
  end

  def create
    @slideshow = Slideshow.new(slideshow_params)
    @slideshow.user = current_user
    @slideshow.save!
    render json: @slideshow, :status => :created
  end

  def destroy
    @slideshow = Slideshow.find(params[:id])
    render json: @slideshow.trash!
  end

private
  def slideshow_params
    params.require(:slideshow).permit(:name)
  end
end
