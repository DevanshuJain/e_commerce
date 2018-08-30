class AddRateToCart < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :rate, :integer
  end
end
