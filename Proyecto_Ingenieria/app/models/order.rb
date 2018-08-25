class Order < ApplicationRecord
  has_many :orders_materials
  has_many :materials, :through => :orders_materials
end
