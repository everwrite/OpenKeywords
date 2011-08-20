class KeywordAll
  include Mongoid::Document

  field :t,  :type => String,  :as => :term 
  field :c,  :type => String,  :as => :country
  field :r,  :type => String,  :as => :region
  field :ct, :type => String,  :as => :city
  field :v,  :type => Integer, :as => :visits
  field :ca, :type => Time,    :as => :created_at
  field :k,  :type => Array ,  :as => :keywords
  

end
