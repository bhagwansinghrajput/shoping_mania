class Category < ActiveRecord::Base
  scope :list_category_name, -> (term){where "name ilike ? ", "%#{term}%"}
  validates :name, presence: true

  has_many :category_products
  has_many :products, through: :category_products
end
