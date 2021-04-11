class RemoveProvinceFromCustomer < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :province, :string
  end
end
