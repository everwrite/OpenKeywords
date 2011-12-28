require 'importer'
require 'importer_job'

class DailySyncJob
	def self.perform
	  User.all.each do |user|
		  Resque.enqueue ImporterJob,user
		end
	end	
end	