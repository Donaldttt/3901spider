require 'test_helper'

class CseClassControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cse_class_index_url
    assert_response :success
  end

end
