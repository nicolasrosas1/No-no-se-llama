class AddBodegaToMaterials < ActiveRecord::Migration[5.2]
  def change
    add_column :materials, :bodega, :string
  end
end
