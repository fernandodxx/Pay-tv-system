class Bill < ApplicationRecord
  belongs_to :signature
  has_and_belongs_to_many :invoices

  validates :created_at, :due_date, :amount, presence: true
end
