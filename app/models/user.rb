class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :avatar
  # attr_accessible :title, :body

  validates_attachment :avatar, presence: true,
              content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
              size: { less_than: 5.megabytes }

  has_many :instruments
  has_attached_file :avatar, 
                    :styles => { :small => '30x30#', :large => '100x100#' },
                    :default_url => "/images/missing.png"
end
