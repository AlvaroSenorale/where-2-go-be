# Base controller for the mobile api
class Api::BaseController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # Disable cookies (no set-cookies header in response).
  before_action :destroy_session

  private

  def destroy_session
    request.session_options[:skip] = true
  end
end