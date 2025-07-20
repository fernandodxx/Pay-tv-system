class Package < ApplicationRecord
  belongs_to :plan

  validates :name, :plan, presence: true
  validates :price, numericality: { greater_than: 0 }, allow_nil: true
end
