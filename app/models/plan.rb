class Plan < ApplicationRecord
  validates :nome, presence: true
  validates :valor, presence: true, numericality: { greater_than: 0 }
end
