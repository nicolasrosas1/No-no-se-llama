class Material < ApplicationRecord
  has_and_belongs_to_many :materials
  has_and_belongs_to_many :warehouses
  attr_accessor :bodega2
  validates :nombre, presence: true, uniqueness: true, length:  { :in => 3..100 }
  validates :bodega, presence: true
  validates :precio, presence: true, length: { :in => 1..40}
  validates :stock, presence: true

end
