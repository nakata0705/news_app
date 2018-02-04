require 'test_helper'

class SourceControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get source_view_url
    assert_response :success
  end

end
