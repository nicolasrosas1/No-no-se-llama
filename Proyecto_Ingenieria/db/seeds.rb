# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Warehouse.create(:nombre => "Bodega 1", :direccion => "Direccion 123")
Warehouse.create(:nombre => "Bodega 2", :direccion => "Direccion 456")
Warehouse.create(:nombre => "Bodega 3", :direccion => "Direccion 789")
