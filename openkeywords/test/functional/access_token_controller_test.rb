require 'test_helper'

class AccessTokenControllerTest < ActionController::TestCase
  
	def setup
		@user = FactoryGirl.create(:user)
	end
	
	def teardown
		@user.delete
	end
	
	test "should get new" do
		sign_in @user
 		get :new
    assert_response :success
  end

end
