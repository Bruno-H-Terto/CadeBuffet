class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.integer :min_quantity_people
      t.integer :max_quantity_people
      t.integer :duration_in_minutes
      t.text :menu
      t.boolean :alcoholic_drink
      t.boolean :self_decoration
      t.boolean :parking
      t.boolean :valet
      t.boolean :fixed_location
      t.references :owner, null: false, foreign_key: true
      t.references :buffet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
