class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.is_admin?
      @users = User.where(role: User::ROLE["user"])
    else
      home_index_path     
    end
  end 

  def permit_for_add_items
    if params[:id].present?
      @user = User.where("id = ?", params[:id]).first
      if @user.permission == false
        @user.update_attributes(:permission => true)
      elsif @user.permission == true
        @user.update_attributes(:permission => false)
      end
    else
      users_path
    end
    @users = User.where(role: User::ROLE["user"]) if current_user.is_admin?
  end  
end
