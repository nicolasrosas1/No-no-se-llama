class MaterialsWarehouse < ApplicationRecord
  belongs_to :warehouse
  belongs_to :material
end
