class UserInfo < ActiveRecord::Base

	attr_accessible :liner, :fav_I, :fav_band, :cur_learn, :other
	
	belongs_to :user, :inverse_of => :user_info, :foreign_key => 'user_id'

end