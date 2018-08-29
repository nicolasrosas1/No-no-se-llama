class AddBodegaToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :bodega, :integer
  end
end
