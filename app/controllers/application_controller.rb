class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception 
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :create_cart 
  
   

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :contact_no , :address, :city, :state, :country, :zipcode, :email, :password,:password_confirmation,:role) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :contact_no, :address, :city, :state, :country, :zipcode, :current_password,:password,:password_confirmation  )}
  end

  def create_cart
    if current_user.present?
      current_user.build_cart.save if current_user.cart.blank?
    end
  end

end
