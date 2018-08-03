class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :nombre
      t.integer :precio
      t.integer :stock

      t.timestamps
    end
  end
end
