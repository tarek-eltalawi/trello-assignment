class Project < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :stories, dependent: :destroy
	self.per_page = 4
	validates :name, :description, :image_url, presence: true
	validates :name, uniqueness: true
	validates :image_url, allow_blank: true, format: {
		with:
		%r{\.(gif|jpg|png|jpeg)\Z}i,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}
	
end
