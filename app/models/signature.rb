class Signature < ApplicationRecord
  belongs_to :customer
  belongs_to :plan, optional: true
  belongs_to :package, optional: true
  has_and_belongs_to_many :additional_services
  has_many :bills, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_one :payment_book, dependent: :destroy

  validate :must_have_one_type_only
  validate :no_duplicate_additional_services
  validate :no_package_service_repetitions

  after_create :generate_billing_cycle

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

  def generate_billing_cycle
    start_date = Date.current

    12.times do |i|
      due_date = start_date + i.months

      # Criar a fatura (invoice)
      invoice = invoices.create!(
        creation_date: Date.current,
        due_date: due_date,
        price: 0 # Será calculado baseado nas bills
      )

      total_invoice_value = 0

      # Conta do plano ou pacote
      if plan.present?
        bill = bills.create!(
          creation_date: Date.current,
          due_date: due_date,
          price: plan.price,
          description: "Plano #{plan.name}"
        )
        invoice.bills << bill
        total_invoice_value += plan.price
      elsif package.present?
        bill = bills.create!(
          creation_date: Date.current,
          due_date: due_date,
          price: package.price,
          description: "Pacote #{package.name}"
        )
        invoice.bills << bill
        total_invoice_value += package.price
      end

      # Contas dos serviços adicionais
      additional_services.each do |service|
        bill = bills.create!(
          creation_date: Date.current,
          due_date: due_date,
          price: service.price,
          description: "Serviço adicional: #{service.name}"
        )
        invoice.bills << bill
        total_invoice_value += service.price
      end

      # Atualizar o valor total da invoice
      invoice.update!(price: total_invoice_value)
    end

    # Criar o carnê (payment_book)
    total_payment_book_value = invoices.sum(:price)
    create_payment_book!(
      creation_date: Date.current,
      price: total_payment_book_value
    )
  end
end
