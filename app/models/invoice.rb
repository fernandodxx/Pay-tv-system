class Invoice < ApplicationRecord
  belongs_to :signature
  belongs_to :payment_book, optional: true
  has_and_belongs_to_many :bills

  validates :created_at, :due_date, :amount, presence: true
end
