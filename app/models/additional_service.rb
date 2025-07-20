class AdditionalService < ApplicationRecord
  has_and_belongs_to_many :packages
  
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
