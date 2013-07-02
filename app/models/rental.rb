class Rental < ActiveRecord::Base
  # attr_accessible :title, :body

	belongs_to :user
	belongs_to :instrument

	attr_accessible :user, :user_id, :instrument_id
end
