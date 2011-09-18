require 'keyword_report'

class Importer

  def initialize token,secret
    auth token,secret
    get_profiles
    mega_updater_pro
  end

  def auth token,secret
	   consumer = OAuth::Consumer.new('myeverwrite.com', 'uHvDjXZpKGs4FmK8QOSvX9zF', {
		  :site => 'https://www.google.com',
		  :request_token_path => '/accounts/OAuthGetRequestToken',
		  :access_token_path => '/accounts/OAuthGetAccessToken',
		  :authorize_path => '/accounts/OAuthAuthorizeToken'
		 })	   
     access_token = OAuth::AccessToken.new(consumer, token, secret)	   
     Garb::Session.access_token = access_token
  end

  def get_profiles
    @profiles = Garb::Profile.all()
  end

  def mega_updater_pro
    @profiles.each do | profile |
      get_profile_keywords profile
    end
  end

  def get_profile_keywords(profile,start_date = 1.day.ago.midnight)
      results = KeywordReport.results profile, :start_date => start_date, :limit => 1000
	    pages = results.total_results / 1000 + 1
	    for page in 1..pages do
	      puts page
	      results.each do | result |
	        save_result result
	      end
	      results = KeywordReport.results profile, :start_date => start_date, :offset => page*1000, :limit => 1000
	    end
  end

  def save_result(result)
    KeywordDay.collection.update({:t => result.keyword,:ca => 1.day.ago.utc.midnight }, 
      {'$inc' => {'v' => result.visits.to_i }},
      {:upsert =>  true})
    
    KeywordWeek.collection.update({:t => result.keyword,:ca => Time.now.utc.beginning_of_week }, 
      {'$inc' => {'v' => result.visits.to_i }},
      {:upsert =>  true})
    
    KeywordMonth.collection.update({:t => result.keyword,:ca => Time.now.utc.beginning_of_month },
    {'$inc' => {'v' => result.visits }}, {:upsert =>  true})
    
    KeywordYear.collection.update({:t => result.keyword,:ca => Time.now.utc.beginning_of_year}, 
      {'$inc' => {'v' => result.visits.to_i }},
      {:upsert =>  true})
    
    KeywordAll.collection.update({:t => result.keyword}, 
      {'$inc' => {'v' => result.visits.to_i }},
      {:upsert =>  true})
  end
end
