class AdminController < ApplicationController
  before_action :authenticate_user!
  before_filter :authenticate_admin, only: [:permit_for_add_items]
  before_filter :find_user, only: [:permit_for_add_items]


  def index
    
  end

  
  def authenticate_admin
    unless current_user.is_admin?
      flash[:error] = "You are not admin please sign in correctlly"
      return
    end
  end

  private

  def find_user
    @user = User.where("id = ?", params[:id].to_i).first
    if @user.blank?
      flash[:error] = "User not valid."
      redirect_to users_path and return
    end
  end
end
