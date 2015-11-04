class BuyersController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.is_admin?
      @buyers = User.where(role: User::ROLE["buyer"])
    else
    
    end
  end 
end
