class CreateMaterialsWarehouses < ActiveRecord::Migration[5.2]
  def change
    create_table :materials_warehouses do |t|
      t.references :warehouse, foreign_key: true
      t.references :material, foreign_key: true

      t.timestamps
    end
  end
end
