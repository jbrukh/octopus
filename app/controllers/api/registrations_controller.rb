class Api::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource
    logger.debug "email: " + params[:user][:email]
    logger.debug "email: " + params[:user][:password]
    logger.debug "email: " + params[:user][:password_confirmation]
    if resource.save
      logger.debug 'what'
      head status: 200
    else
      render :json => resource.errors, :status => :unprocessable_entity
    end
  end
end