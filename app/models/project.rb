class Project < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :stories, dependent: :destroy
	self.per_page = 4
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	validates :avatar, :name, :description, presence: true
	
	
end
