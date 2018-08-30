class AddTotalQuantityToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :total_quantity, :integer
    add_column :orders, :total_ammount, :integer
    add_column :orders, :status, :boolean, :default => false
  end
end
