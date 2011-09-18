require 'importer'

class ImporterJob
	def self.perform user
		Importer.new user.access_token.first.t, user.access_token.first.s
	end
end