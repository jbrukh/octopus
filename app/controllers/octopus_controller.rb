class OctopusController < ApplicationController
  before_action :authenticate_user!

  def index
    render layout: 'octopus'
  end
end