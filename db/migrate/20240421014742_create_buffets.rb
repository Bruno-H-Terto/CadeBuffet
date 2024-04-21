class CreateBuffets < ActiveRecord::Migration[7.1]
  def change
    create_table :buffets do |t|
      t.references :owner, null: false, foreign_key: true
      t.string :brand_name
      t.string :corporate_name
      t.integer :register_number
      t.string :phone_number
      t.string :address
      t.string :district
      t.string :state
      t.string :city
      t.string :zip_code
      t.text :description
      t.string :payment_methods

      t.timestamps
    end
  end
end
