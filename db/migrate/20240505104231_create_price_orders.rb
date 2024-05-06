class CreatePriceOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :price_orders do |t|
      t.integer :initial_price
      t.integer :rate
      t.text :description_rate
      t.integer :final_price
      t.string :payment_methods
      t.date :deadline
      t.references :owner, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
