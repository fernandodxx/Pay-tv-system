class PaymentBook < ApplicationRecord
  belongs_to :signature

  validates :creation_date, :price, presence: true

  def invoices
    signature.invoices.order(:due_date)
  end
end
