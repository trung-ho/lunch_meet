class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  def home
  end
end
