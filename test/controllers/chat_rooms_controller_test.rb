require 'test_helper'

class ChatRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chat_rooms_index_url
    assert_response :success
  end

  test "should get rooms" do
    get chat_rooms_rooms_url
    assert_response :success
  end

end
