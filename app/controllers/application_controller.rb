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
    if resource.is_a?(AdminUser)
      stored_location_for(resource)
    else
      if current_user.preferences.empty? || current_user.preferences.size < 4
        select_preferences_users_path
      else
        stored_location_for(resource) || groups_path
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :first_name, :last_name, :avatar, :phone_number, :address])
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end
  end
end
