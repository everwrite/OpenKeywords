class HomeController < ApplicationController
 
  def index
	  if current_user
		  if current_user.access_token.empty?
			  redirect_to "/access_token/new"
		  end
	  end
  end

  def search
    q = params[:q]
    @keywords = KeywordDay.where( :t => /#{q}/i).order_by([[:v, :desc]]).page(params[:page]).per(20)
  end

end
