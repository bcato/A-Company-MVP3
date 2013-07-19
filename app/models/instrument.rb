class Instrument < ActiveRecord::Base
  attr_accessible :description, :image, :name, :category, :user_id, :user, :price

  validates :description, presence: true
  validates :name, presence: true
  validates :price, presence: true
  validates :category, presence: true
  validates :user_id, presence: true
  #validates_attachment :image, presence: true,
  						#content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
  						#size: { less_than: 5.megabytes }

  belongs_to :user
            
  has_many :rentals

  has_attached_file :image

end
