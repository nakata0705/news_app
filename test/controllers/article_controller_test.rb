require 'test_helper'

class ArticleControllerTest < ActionDispatch::IntegrationTest
  test "should get read" do
    get article_read_url
    assert_response :success
  end

end
