class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
    octopus_index_url()
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def authenticate_admin_user!
    not_found unless current_user.try(:admin?)
  end
end
