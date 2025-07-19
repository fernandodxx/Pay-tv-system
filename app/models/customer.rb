class Customer < ApplicationRecord
  validates :nome, presence: true
  validates :idade, presence: true, numericality: { greater_than_or_equal_to: 18 }
end
