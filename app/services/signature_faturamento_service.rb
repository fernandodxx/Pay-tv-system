class SignatureFaturamentoService
  def initialize(signature)
    @signature = signature
    @customer = signature.customer
    @day = signature.created_at.day
    @start_date = signature.created_at.next_month.beginning_of_month.change(day: @day)
  end

  def generate_billing_cycle
    12.times do |i|
      due_date = @start_date + i.months

      invoice = @signature.invoices.create!(
        creation_date: Date.current,
        due_date: due_date,
        price: 0 # Será calculado baseado nas bills
      )

      total_invoice_value = 0

      # Criar bill para plano ou pacote
      if @signature.plan.present?
        bill = @signature.bills.create!(
          creation_date: Date.current,
          due_date: due_date,
          price: @signature.plan.price,
          description: "Plano #{@signature.plan.name}"
        )
        invoice.bills << bill
        total_invoice_value += @signature.plan.price
      elsif @signature.package.present?
        bill = @signature.bills.create!(
          creation_date: Date.current,
          due_date: due_date,
          price: @signature.package.price,
          description: "Pacote #{@signature.package.name}"
        )
        invoice.bills << bill
        total_invoice_value += @signature.package.price
      end

      # Criar bills para serviços adicionais
      @signature.additional_services.each do |service|
        bill = @signature.bills.create!(
          creation_date: Date.current,
          due_date: due_date,
          price: service.price,
          description: "Serviço adicional: #{service.name}"
        )
        invoice.bills << bill
        total_invoice_value += service.price
      end

      # Atualizar preço total da invoice
      invoice.update!(price: total_invoice_value)
    end

    # Criar payment book com valor total
    total_payment_book_value = @signature.invoices.sum(:price)
    @signature.create_payment_book!(
      creation_date: Date.current,
      price: total_payment_book_value
    )
  end
end
