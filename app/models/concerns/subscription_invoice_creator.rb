module SubscriptionInvoiceCreator
  extend ActiveSupport::Concern

  included do
    after_create :generate_billing_cycle
  end

  def generate_billing_cycle
    ActiveRecord::Base.transaction do
      initial_billing_date = created_at.next_month.beginning_of_month.change(day: created_at.day)

      12.times do |i|
        due_date = initial_billing_date + i.months
        invoice = create_invoice_for_month(due_date)
        generate_bills_for_invoice(invoice, due_date)
        invoice.update!(price: invoice.bills.sum(:price))
      end

      create_payment_book
    end
  end

  private

  def create_invoice_for_month(due_date)
    invoices.create!(creation_date: Date.current, due_date: due_date, price: 0)
  end

  def generate_bills_for_invoice(invoice, due_date)
    add_plan_or_package_bill(invoice, due_date)
    add_additional_services_bills(invoice, due_date)
  end

  def add_plan_or_package_bill(invoice, due_date)
    if plan.present?
      create_bill(invoice, plan.price, "Plano #{plan.name}", due_date)
    elsif package.present?
      create_bill(invoice, package.price, "Pacote #{package.name}", due_date)
    end
  end

  def add_additional_services_bills(invoice, due_date)
    additional_services.each do |service|
      create_bill(invoice, service.price, "Serviço adicional: #{service.name}", due_date)
    end
  end

  def create_bill(invoice, price, description, due_date)
    invoice.bills.create!(creation_date: Date.current, due_date: due_date, price: price, description: description, signature: self)
  end

  def create_payment_book
    total_payment_book_value = invoices.sum(:price)
    create_payment_book!(creation_date: Date.current, price: total_payment_book_value)
  end
end
