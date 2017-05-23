class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :role, :password, :password_confirmation, :current_password) }
  end
  
  def upgrade_to_premium
    current_user.update_attributes(:role => "premium")
  end
  
end
