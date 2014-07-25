class Project < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :stories
	self.per_page = 4
end
