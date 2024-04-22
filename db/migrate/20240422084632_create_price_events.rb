class CreatePriceEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :price_events do |t|
      t.integer :min_price_working_day
      t.integer :additional_price_for_person_working_day
      t.integer :extra_hour_working_day
      t.integer :min_price_weekend
      t.integer :additional_price_for_person_weekend
      t.integer :extra_hour_weekend

      t.timestamps
    end
  end
end
