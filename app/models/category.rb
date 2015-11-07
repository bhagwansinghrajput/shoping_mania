class Category < ActiveRecord::Base
  scope :autocomplete_category_name, -> (term){where "name ilike ? ", "%#{term}%"}

  has_many :category_products
  has_many :products, through: :category_products
end
