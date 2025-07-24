class Bill < ApplicationRecord
  belongs_to :signature
  has_and_belongs_to_many :invoices

  validates :creation_date, :due_date, :price, presence: true
end
