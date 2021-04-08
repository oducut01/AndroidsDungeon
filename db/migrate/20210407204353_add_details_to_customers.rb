class AddDetailsToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :name, :string
    add_column :customers, :phone, :string
    add_column :customers, :address, :string
    add_column :customers, :city, :string
    add_column :customers, :province, :string
    add_column :customers, :postalCode, :string
  end
end
