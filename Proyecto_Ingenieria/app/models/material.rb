class Material < ApplicationRecord
  has_many :orders_materials
  has_many :orders, :through => :orders_materials
end
