class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_buyer, only: [:destroy]
  before_filter :authenticate_admin, only: [:index, :destroy]

  def index
    @buyers = User.all_buyers
  end 

  def destroy
    if current_user.is_admin?
      @buyer.destroy
      flash[:success] = "Buyer deleted."
      redirect_to buyers_path
    else
      flash[:error] = "You can not delete buyer."
      redirect_to buyers_path
    end
  end

  def authenticate_admin
    unless current_user.is_admin?
      flash[:error] = "You are not admin please sign in correctlly"
      return
    end
  end

  private

  def find_buyer
    @buyer = User.where("id = ?", params[:id].to_i).first
    if @buyer.blank?
      flash[:error] = "Buyer not valid."
      redirect_to buyers_path and return
    end
  end

end
