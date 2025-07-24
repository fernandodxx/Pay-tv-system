class SignaturesController < ApplicationController
  before_action :set_signature, only: %i[ show destroy bills invoices payment_book ]
  before_action :set_form_collections, only: %i[ new create ]

  def index
    @signatures = Signature.includes(:customer, :plan, :package, :additional_services).all
  end

  def show
  end

  def new
    @signature = Signature.new
  end

  def create
    @signature = Signature.new(signature_params)

    if @signature.save
      @signature.send(:generate_billing_cycle)
      redirect_to @signature, notice: "Assinatura criada e faturamento gerado com sucesso."
    else
      set_form_collections
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @signature.destroy
    redirect_to signatures_path, notice: "Assinatura removida com sucesso."
  end

  def payment_book
    @payment_book = @signature.payment_book

    if @payment_book.nil?
      redirect_to @signature, alert: "Carnê de pagamento não encontrado."
    end
  end

  def invoices
    @invoices = @signature.invoices.includes(:bills).order(:due_date)
  end

  def bills
    @bills = @signature.bills.order(:due_date)
  end

  private

  def set_form_collections
    @customers = Customer.all.order(:name)
    @plans = Plan.all.order(:name)
    @services = AdditionalService.all.order(:name)
    @packages = Package.includes(:additional_services).all.order(:name)
  end

  def set_signature
    @signature = Signature.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to signatures_path, alert: "Assinatura não encontrada."
  end

  def signature_params
    params.require(:signature).permit(:customer_id, :plan_id, :package_id, additional_service_ids: [])
  end
end
