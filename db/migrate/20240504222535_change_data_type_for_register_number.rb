class ChangeDataTypeForRegisterNumber < ActiveRecord::Migration[7.1]
  def change
    change_column :buffets, :register_number, :string
  end
end
