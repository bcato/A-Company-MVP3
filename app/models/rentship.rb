class Rentship < ActiveRecord::Base
  # attr_accessible :title, :body

belongs_to :user
belongs_to :renter, class_name: 'User', foreign_key: 'renter_id'
           

attr_accessible :user, :renter, :user_id, :renter_id, :state


end
