class ShipAddy < ActiveRecord::Base

	attr_accessible :address1, :address2, :city, :state, :zip, :country
	
	belongs_to :rental

	validates :description, presence: true
	validates :address1, presence: true
	validates :address2, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zip, presence: true
	validates :country, presence: true

end