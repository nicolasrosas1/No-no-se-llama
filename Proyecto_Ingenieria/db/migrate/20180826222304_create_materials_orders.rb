class CreateMaterialsOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :materials_orders do |t|
      t.references :order, foreign_key: true
      t.references :material, foreign_key: true

      t.timestamps
    end
  end
end
