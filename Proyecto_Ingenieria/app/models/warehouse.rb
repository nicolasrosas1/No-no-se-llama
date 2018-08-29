class Warehouse < ApplicationRecord
  has_and_belongs_to_many :materials
  validates :nombre, presence: true, length:  { :in => 3..50 }
  validates :direccion, presence: true, length:  { :in => 3..100 }
end
