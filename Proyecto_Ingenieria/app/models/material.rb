class Material < ApplicationRecord
  has_many :orders_materials
  has_many :orders, :through => :orders_materials
  has_and_belongs_to_many :warehouses 

  validates :nombre, presence: true, uniqueness: true, length:  { :in => 3..100 }
  validates :bodega, presence: true, length:  { :in => 3..20 }
  validates :precio, presence: true, length: { :in => 1..40}
  validates :stock, presence: true

end
