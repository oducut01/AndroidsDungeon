class RenameColumnInOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :statusLstring, :status
  end
end
