class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer  :discount
      t.date     :start_date
      t.date     :end_date
      t.string   :promocode
      t.timestamps null: false
    end
  end
end
