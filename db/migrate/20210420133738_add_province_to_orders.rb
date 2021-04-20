class AddProvinceToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :province, :string
  end
end
