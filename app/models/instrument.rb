class Instrument < ActiveRecord::Base
  attr_accessible :description, :image, :name, :category

  validates :description, presence: true
  validates :name, presence: true
  validates :category, presence: true
  validates :user_id, presence: true
  validates_attachment :image, presence: true,
  						content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
  						size: { less_than: 5.megabytes }

  belongs_to :user
  has_attached_file :image

  searchable do
    text :description, :name, :category
  end
end
