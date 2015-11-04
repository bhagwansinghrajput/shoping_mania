class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string   :name
      t.integer  :quantity
      t.integer  :user_id
      t.string   :image
      t.float    :price
      t.integer  :sold_quantity, default: 0
      t.integer  :shipping_charge
      t.timestamps null: false
    end
  end
end
