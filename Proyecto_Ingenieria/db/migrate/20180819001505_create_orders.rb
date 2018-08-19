class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :fecha_entrega
      t.string :direccion
      t.string :estado

      t.timestamps
    end
  end
end
