class Signature < ApplicationRecord
  belongs_to :customer
  belongs_to :plan, optional: true
  belongs_to :package, optional: true
  has_and_belongs_to_many :additional_services

  validate :must_have_one_type_only
  validate :no_duplicate_additional_services
  validate :no_package_service_repetitions

  private

  def must_have_one_type_only
    if plan.present? && package.present?
      errors.add(:base, "Não pode ter plano e pacote ao mesmo tempo")
    elsif plan.blank? && package.blank?
      errors.add(:base, "Deve ter um plano ou pacote")
    end
  end

  def no_duplicate_additional_services
    if additional_services.uniq.size != additional_services.size
      errors.add(:additional_services, "não podem ser duplicados")
    end
  end

  def no_package_service_repetitions
    return unless package

    conflicts = additional_services.where(id: package.additional_services.pluck(:id))
    if conflicts.any?
      errors.add(:additional_services, "já estão no pacote")
    end
  end
end
