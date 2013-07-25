class FeaturesController < ApplicationController
  KNOWN_FEATURES = %w(tagging)

  before_action :not_found, :only => :show, :unless => :valid_feature

  def show
    feature = params[:id]
    render :action => feature
  end

protected

  def valid_feature
    KNOWN_FEATURES.include?(params[:id])
  end
end
