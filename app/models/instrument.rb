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
  belongs_to :renter, class_name: 'User', foreign_key: 'renter_id'
            
  has_many :rentals

  has_attached_file :image


  state_machine :state, :initial => :available do
    
    event :request do
      transition :available => :requested
    end

    event :accept do
      transition :requested => :open
    end

    event :cancel do
      transition :open => :available
    end

    event :reject do
      transition :requested => :available
    end

    event :rent_ship do
      transition :open => :rented
    end

    event :return do
      transition :rented => :open
    end

    event :return_ship do
      transition :open => :avialable
    end

    event :make_unavailable do
      transition :available => :unavailable
    end

    event :make_available do
      transition :unavailable => :available
    end

    before_transition :available => :open do |order|
      # process payment ...
      !order.invalid_payment
    end

    after_transition :on => :request, do: :send_request_email
    after_transition :on => :accept, do: :send_request_accepted_email
    after_transition :on => :cancel, do: :send_request_canceled_email
    after_transition :on => :reject, do: :send_request_rejected_email
  end

  def send_request_email
    UserNotifier.instrument_requested(id).deliver
  end

  def send_request_accepted_email
    UserNotifier.instrument_request_accepted(id).deliver
  end

  def send_request_canceled_email
    UserNotifier.instrument_request_canceled(id).deliver
  end

  def send_request_rejected_email
    UserNotifier.instrument_request_rejected(id).deliver
  end

end
