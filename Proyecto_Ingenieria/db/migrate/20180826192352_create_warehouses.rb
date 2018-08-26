class CreateWarehouses < ActiveRecord::Migration[5.2]
  def change
    create_table :warehouses do |t|
      t.string :nombre
      t.string :direccion

      t.timestamps
    end
  end
end
