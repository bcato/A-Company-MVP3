class Rental < ActiveRecord::Base
  # attr_accessible :title, :body

	belongs_to :user
	belongs_to :instrument

	attr_accessible :user, :user_id, :instrument_id, :start_on, :end_on

	validates :start_on, presence: true
	#validates :end_on, presence: true
end
