class Product < ApplicationRecord
  belongs_to :category
  validates_inclusion_of :of_type, in: ['dish', 'cutlery']

  scope :dishes, -> { where(of_type: 'dish')}
  scope :cutlery, -> { where(of_type: 'cutlery')}
end
