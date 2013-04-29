class Api::TheoriesController < ApplicationController
  def index
    @theories = Theory.all
    render :json => @theories
  end
end