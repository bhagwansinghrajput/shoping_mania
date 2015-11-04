class Product < ActiveRecord::Base
  
  attr_accessor :uploaded_image, :image_name, :image_type, :image
  
  mount_uploader :image, ImageUploader
  validates :name, :quantity, :price, presence: true
  
  has_many :category_products
  has_many :categories, through: :category_products
  belongs_to :users
  has_many  :cart_items
  has_many :order_details
  
  before_create :check_zero
  accepts_nested_attributes_for :categories, :allow_destroy => true
  
  
  def self.search(search)
    if search
      self.where("name like ? ", "%#{search}%")
    else
      self.all
    end
  end
  
  def available_quantity
    available_quantity = self.quantity.to_i - self.sold_quantity.to_i
    if available_quantity < 0
      available_quantity = 0
    else
      available_quantity
    end
  end

  private

  def check_zero
    if self.quantity == 0 or nil
      self.quantity = 1
    end
  end 
 
end
