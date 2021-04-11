class AddColumnsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :city, :string
    add_column :orders, :postalCode, :string
    add_column :orders, :status, :string
    add_column :orders, :payment_id, :string
    add_column :orders, :gst_total, :integer
    add_column :orders, :pst_total, :integer
    add_column :orders, :hst_toal, :integer
  end
end
