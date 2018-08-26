class DropOrdersMaterial < ActiveRecord::Migration[5.2]
  def change
    drop_table :orders_material
  end
end
