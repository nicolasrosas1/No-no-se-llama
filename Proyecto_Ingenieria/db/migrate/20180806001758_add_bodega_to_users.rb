class AddBodegaToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bodega, :integer
  end
end
