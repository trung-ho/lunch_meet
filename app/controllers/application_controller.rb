class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit
  protect_from_forgery

  def home
    if user_signed_in?
      redirect_to groups_path
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_users_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :first_name, :last_name, :avatar, :phone_number, :address])
  end
end
