class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :cart_items, through: :cart
  has_one :cart
  has_many :products
  has_many :orders
  
  ROLE = {"admin" => 0, "user" => 1, "buyer" => 2} 
  
  def is_admin?
    self.role == ROLE["admin"]
  end
  
  def is_user?
    self.role == ROLE["user"]
  end
  
  def is_buyer?
    self.role == ROLE["buyer"]
  end
  
end
