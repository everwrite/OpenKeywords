class HomeController < ApplicationController
  def index
		if current_user.access_token.empty?
			redirect_to "/access_token/new"
		end
  end

end
