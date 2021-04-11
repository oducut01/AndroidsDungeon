class ChangeColumnsInOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :address, :string
  end
end
