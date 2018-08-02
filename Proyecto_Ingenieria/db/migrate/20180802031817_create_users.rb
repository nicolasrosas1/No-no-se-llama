class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nombre
      t.string :correo
      t.string :pass
      t.string :cargo
      t.string :salt

      t.timestamps
    end
  end
end
