class ExporterJob
	
	def self.perform
		system 'mongoexport  -h localhost -d openkeywords_development -c keyword_alls   --csv -f t,c,v > public/tmp/all.csv'
	  system 'mongoexport  -h localhost -d openkeywords_development -c keyword_days   --csv -f t,c,v > public/tmp/days.csv'
	  system 'mongoexport  -h localhost -d openkeywords_development -c keyword_weeks  --csv -f t,c,v > public/tmp/weeks.csv'
	  system 'mongoexport  -h localhost -d openkeywords_development -c keyword_months --csv -f t,c,v > public/tmp/months.csv'
	  system 'mongoexport  -h localhost -d openkeywords_development -c keyword_years  --csv -f t,c,v > public/tmp/years.csv'
	end	
	
end	