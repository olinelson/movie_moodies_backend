require 'test_helper'

class Api::V1::VideosControllerTest < ActionDispatch::IntegrationTest
  test "should get Controller" do
    get api_v1_videos_Controller_url
    assert_response :success
  end

end
