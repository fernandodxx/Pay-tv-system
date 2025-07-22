class Plan < ApplicationRecord
  has_many :packages, dependent: :destroy
  has_many :signatures

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
