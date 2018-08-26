class AddCantToMaterialsOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :materials_orders, :cant, :integer
  end
end
