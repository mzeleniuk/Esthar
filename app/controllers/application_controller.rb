require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :json

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :permitted_params, if: :devise_controller?

  def angular
    render 'layouts/application'
  end

  protected

  def permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
