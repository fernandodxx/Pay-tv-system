class PackagesController < ApplicationController
  before_action :set_package, only: %i[ show edit update destroy ]
  before_action :set_plans, :set_services, only: %i[ update create new edit ]

  # GET /packages or /packages.json
  def index
    @packages = Package.includes(:plan, :additional_services)
  end

  # GET /packages/1 or /packages/1.json
  def show
  end

  # GET /packages/new
  def new
    @package = Package.new
  end

  # GET /packages/1/edit
  def edit
  end

  # POST /packages or /packages.json
  def create
    @package = Package.new(package_params)
    if @package.save
      redirect_to @package, notice: "Package was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /packages/1 or /packages/1.json
  def update
    if @package.update(package_params)
      redirect_to @package, notice: "Package was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /packages/1 or /packages/1.json
  def destroy
    @package.destroy!
    redirect_to packages_path, status: :see_other, notice: "Package was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params.expect(:id))
    end

    def set_plans
      @plans = Plan.all
    end

    def set_services
      @services = AdditionalService.all
    end

    # Only allow a list of trusted parameters through.
    def package_params
      params.expect(package: [ :name, :price, :plan_id, additional_service_ids: [] ])
    end
end
