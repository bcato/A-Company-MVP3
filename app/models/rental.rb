class Rental < ActiveRecord::Base

	belongs_to :user
	belongs_to :instrument

	attr_accessible :user, :user_id, :instrument_id, :instrument, :start_on, :end_on

	validates :start_on, presence: true
	#validates :end_on, presence: true

	validate :start_on_must_be_before_end_on

	state_machine :state, :initial => :requested do
	    event :accept do
	        transition :requested => :accepted
	    end

	    event :reject do
	        transition [:accepted, :requested] => :available
	    end

	    event :cancel do
	        transition :accepted => :available
	    end

	    event :handover do
	    	transition :accepted => :rented
	    end

	    event :returned do
	    	transition :rented => :available
	    end

	    event :make_unavailable do
	      transition :available => :unavailable
	    end

	    event :make_available do
	      transition :unavailable => :available
	    end

	    before_transition :available => :accepted do |order|
	      # process payment ...
	      !order.invalid_payment
	    end

	    #after_transition :on => :request, do: :send_request_email
	    #after_transition :on => :accept, do: :send_request_accepted_email
	    #after_transition :on => :reject, do: :send_request_rejected_email
	    #after_transition :on => :cancel, do: :send_request_canceled_email
 	end



	private

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

	def start_on_must_be_before_end_on
		return unless start_on and end_on
		errors.add(:start_on, "must be before end time") unless start_on < end_on
	end
end
