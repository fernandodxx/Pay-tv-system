require "test_helper"

class PackagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @package = packages(:one)
    @additional_services = [ additional_services(:one).id, additional_services(:two).id ]
  end

  test "should get index" do
    get packages_url
    assert_response :success
  end

  test "should get new" do
    get new_package_url
    assert_response :success
  end

  test "should create package" do
    assert_difference("Package.count") do
      post packages_url, params: { package: { name: @package.name, plan_id: @package.plan_id, price: @package.price, additional_service_ids: @additional_services } }
    end

    assert_redirected_to package_url(Package.last)
  end

  test "should show package" do
    get package_url(@package)
    assert_response :success
  end

  test "should get edit" do
    get edit_package_url(@package)
    assert_response :success
  end

  test "should update package" do
    patch package_url(@package), params: { package: { name: @package.name, plan_id: @package.plan_id, price: @package.price, additional_service_ids: @additional_services } }
    assert_redirected_to package_url(@package)
  end
end
