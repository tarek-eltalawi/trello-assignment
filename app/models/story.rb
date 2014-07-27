class Story < ActiveRecord::Base
  belongs_to :project
  has_and_belongs_to_many :users
  has_many :tasks
  validates :name, :description, presence: true
  validates :name, uniqueness: true
end
