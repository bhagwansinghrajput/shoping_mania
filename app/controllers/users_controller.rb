class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if current_user.is_admin?
      @users = User.where(role: User::ROLE["user"])
    else
      home_index_path     
    end
  end 
end
