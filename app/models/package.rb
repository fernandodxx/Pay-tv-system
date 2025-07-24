class Package < ApplicationRecord
  belongs_to :plan
  has_and_belongs_to_many :additional_services
  has_many :signatures

  validates :name, :plan, presence: true
  validates :price, numericality: { greater_than: 0 }, allow_nil: true
  validate  :at_least_one_additional_service

  def price_all
    price || (plan.price + additional_services.sum(:price))
  end

  private

    def at_least_one_additional_service
      errors.add(:additional_services, "é obrigatório pelo menos um") unless additional_services.any?
    end
end
