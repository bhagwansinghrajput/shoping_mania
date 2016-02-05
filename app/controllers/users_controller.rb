class UsersController < ApplicationController
  before_action :authenticate_user!
<<<<<<< HEAD
  before_filter :find_user, only: [:destroy, :permit_for_add_items]
  before_filter :authenticate_admin, only: [:index, :destroy]
  def index
    @users = User.all_users
  end

  def destroy
    if current_user.is_admin?
      @user.destroy
      flash[:success] = "User deleted."
      redirect_to users_path
    else
      flash[:error] = "You can not delete User."
      redirect_to users_path
    end
  end

  def permit_for_add_items
    @user.toggle!(:permission)
    @users = User.where(role: User::ROLE["user"]) if current_user.is_admin?
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


  

=======
  
  def index
    if current_user.is_admin?
      @users = User.where(role: User::ROLE["user"])
    else
      home_index_path     
    end
  end 
>>>>>>> master
end
