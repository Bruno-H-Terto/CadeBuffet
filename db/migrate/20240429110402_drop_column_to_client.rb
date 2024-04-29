class DropColumnToClient < ActiveRecord::Migration[7.1]
  def change
    remove_column :clients, :first_name
    remove_column :clients, :last_name
  end
end
