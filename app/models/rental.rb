class Rental < ActiveRecord::Base

	belongs_to :user
	belongs_to :instrument
	has_one :ship_addy

	attr_accessible :user, :user_id, :instrument_id, :instrument, :start_on, :end_on

	#code to make sure start and end dates are correct and not duplicative
	validates :start_on, :presence => { :message => "Please enter a valid start date" } 
	validates :end_on, :presence => { :message => "Please enter a valid end date" } 	
	validate :start_on_must_be_before_end_on
	validate :start_on_must_be_after_today
	validate :availability?

	validates :instrument, presence: true
	validates :user, presence: true

	def availability?
		if Rental
			.where(instrument_id: instrument_id)
			.where("start_on < ? AND end_on > ?", end_on, start_on)
			.all.reject { |rental| rental == self }.present?
			errors.add(:base, "Oops, it seems that this instrument is unavailable in the time range that you've selected. Please choose alternate dates.")
		end
	end

	after_create :send_request_email

	#state machine code
	state_machine :state, :initial => :requested do
	    event :accept do
	        transition :requested => :accepted
	    end

	    event :reject do
	        transition [:accepted, :requested] => :rejected
	    end

	    event :cancel do
	        transition :accepted => :cancelled
	    end

	    event :handover do
	    	transition :accepted => :rented
	    end

	    event :returned do
	    	transition :rented => :returned
	    end

	    #before_transition :requested => :accepted do |order|
	      # process payment ...
	     # !order.invalid_payment
	    #end

	   	after_transition :requested => :accepted do |rental|
	    	rental.send_request_accepted_email
	    end
	    
	    after_transition [:accepted, :requested] => :rejected do |rental|
	    	rental.send_request_rejected_email
	    end

	    after_transition :accepted => :cancelled do |rental|
	    	rental.send_request_canceled_email
	    end
 	end

	  def send_request_accepted_email
	    UserNotifier.instrument_request_accepted(id).deliver
	  end

	  def send_request_email
	    UserNotifier.instrument_requested(id).deliver
	  end

	  def send_request_canceled_email
	    UserNotifier.instrument_request_canceled(id).deliver
	  end

	  def send_request_rejected_email
	    UserNotifier.instrument_request_rejected(id).deliver
	  end

	private

	def start_on_must_be_before_end_on
		return unless start_on and end_on
		errors.add(:base, "Sorry, but you must choose a end date that occurs after your desired start date") unless
			start_on < end_on
	end

	def start_on_must_be_after_today
		errors.add(:base, "Sorry, but you must choose a start date that occurs at least 3 days after today") if
			!start_on.blank? and start_on < Date.today + 3
	end

end
