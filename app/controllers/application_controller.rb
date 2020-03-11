class ApplicationController < ActionController::Base
  before_action :banned?
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :user_activity

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :banned)}
    # devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
  end

  private

  def user_activity
    current_user.try(:touch)
  end

  def banned?
    if current_user.present? && current_user.banned?
      sign_out current_user
      flash[:alert] = 'Your account has been banned'
    end
  end
end
