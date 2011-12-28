require 'test_helper'
require 'factory_girl'

class HomeControllerTest < ActionController::TestCase
	
	def setup
		@user = FactoryGirl.create(:user)
	end
	
	def teardown
		@user.delete
	end	
	
	
  test "should get index" do
		@user.access_token = [ { 'token' => 12, 'secret' => 'segredo porra'  }  ]
    sign_in @user
    get :index
    assert_response :success
  end

	test "should redirect to authorize page when user has no analytics setup" do
	    sign_in @user
	    get :index
			assert_redirected_to "/access_token/new"
	end

end
