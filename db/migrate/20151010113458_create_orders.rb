class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer   :user_id
      t.float    :shipping_charge, default: nil
      t.float    :tax_amount
      t.float    :discount_on_promocode, default: 0
      t.float    :net_amount
      t.string   :status, default: false
      t.date     :shipping_date
      t.timestamps null: false
    end
  end
end
