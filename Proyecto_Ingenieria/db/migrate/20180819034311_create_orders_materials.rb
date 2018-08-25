class CreateOrdersMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :orders_materials do |t|
      t.belongs_to :orders, index: true
      t.belongs_to :materials, index: true
      t.integer :cant_material
      t.timestamps
    end
  end
end
