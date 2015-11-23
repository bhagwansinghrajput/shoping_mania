class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer  :cart_id
      t.integer  :product_id
      t.integer  :quantity
      t.float    :price
      t.string   :name
      t.timestamps null: false
    end
  end
end
