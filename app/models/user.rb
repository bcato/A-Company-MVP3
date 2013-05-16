class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 def fullname
  self.fullname = self.first_name + "" + self.last_name
end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :fullname, :avatar
  attr_accessible :title, :body

  
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates_attachment :avatar,
              content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
              size: { less_than: 5.megabytes }

  has_attached_file :avatar, 
                    #:styles => { :small => '30x30#', :large => '100x100#' },
                    :default_url => '/assets/images/missing.png'

  has_many :instruments
  has_many :renters 
                      conditions: { rentships: {state: 'accepted'} }

  has_many :pending_rentships, class_name: 'Rentships',
                                 foreign_key: :user_id,
                                 conditions: { rentships: { state: 'pending' } }

  has_many :pending_renters, through: :pending_rentships, source: :renter

  
end
