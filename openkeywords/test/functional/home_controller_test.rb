require 'test_helper'
require 'factory_girl'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    @user = FactoryGirl.create(:user)
    sign_in @user
    get :index
    assert_response :success
    @user.delete
  end

end
