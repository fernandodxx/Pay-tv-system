class SignaturesController < ApplicationController
  before_action :set_signature, only: %i[ show ]
  before_action :set_form_collections, only: %i[ create new ]
  def index
    @signatures = Signature.includes(:customer).all
  end

  def show
  end

  def new
    @signature = Signature.new
  end

  def create
    @signature = Signature.new(signature_params)
    if @signature.save
      redirect_to @signature, notice: "Signature created and invoiced successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_form_collections
    @customers = Customer.all
    @plans = Plan.all
    @services = AdditionalService.all
    @packages = Package.all
  end

  def set_signature
    @signature = Signature.find(params[:id])
  end

  def signature_params
    params.require(:signature).permit(:customer_id, :plan_id, :package_id)
  end
end
