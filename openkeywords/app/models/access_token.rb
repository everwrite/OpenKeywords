class AccessToken
  include Mongoid::Document
  field :t,  :type => String,  :as => :token
  field :s,  :type => String,  :as => :secret
  embedded_in :user	
end
