class Invoice < ApplicationRecord
  belongs_to :signature
  has_and_belongs_to_many :bills

  validates :creation_date, :due_date, :price, presence: true

  def total_value
    bills.sum(:price)
  end
end
