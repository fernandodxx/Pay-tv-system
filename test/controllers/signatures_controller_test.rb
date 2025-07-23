require "test_helper"

class SignaturesControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get signatures_url
    assert_response :success
  end

  test "should get new" do
    get new_signature_url
    assert_response :success
  end
end
