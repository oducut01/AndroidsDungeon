class RenameHstColumnInOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :hst_toal, :hst_total
  end
end
