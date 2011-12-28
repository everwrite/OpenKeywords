class AccessTokenController < ApplicationController
	before_filter :authenticate_user!
	
  def new
	   consumer = OAuth::Consumer.new('myeverwrite.com', 'uHvDjXZpKGs4FmK8QOSvX9zF', {
		  :site => 'https://www.google.com',
		  :request_token_path => '/accounts/OAuthGetRequestToken',
		  :access_token_path => '/accounts/OAuthGetAccessToken',
		  :authorize_path => '/accounts/OAuthAuthorizeToken'
		})
		request_token = consumer.get_request_token({:oauth_callback => 'http://localhost:3000/access_token/create'}, {:scope => 'https://www.google.com/analytics/feeds'})
		session[:oauth_secret] = request_token.secret	
		@authorize_url = request_token.authorize_url
  end

  def create
	  user = current_user
	  consumer = OAuth::Consumer.new('myeverwrite.com', 'uHvDjXZpKGs4FmK8QOSvX9zF', {
		  :site => 'https://www.google.com',
		  :request_token_path => '/accounts/OAuthGetRequestToken',
		  :access_token_path => '/accounts/OAuthGetAccessToken',
		  :authorize_path => '/accounts/OAuthAuthorizeToken'
		}) 	
    request_token = OAuth::RequestToken.new(consumer, params[:oauth_token], session[:oauth_secret])
    @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier] )
    user.access_token.create( :token => @access_token.token, :secret => @access_token.secret)	
		flash[:notice] = "Your account data was successfuly connected! Welcome aboard." 
		redirect_to "/"
  end

end
