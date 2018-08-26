class Order < ApplicationRecord
  has_and_belongs_to_many :materials
  @@cantidad =1
end
