class Rental < ActiveRecord::Base

	belongs_to :user
	belongs_to :instrument
	has_one :ship_addy

	attr_accessible :user, :user_id, :instrument_id, :instrument, :start_on, :end_on

	#code to make sure start and end dates are correct and not duplicative
	validates :start_on, presence: true
	validates :end_on, presence: true
	validate :start_on_must_be_before_end_on
	validate :availability

	validates :instrument, presence: true
	validates :user, presence: true

	def availability
		if Rental
			.where(instrument_id: instrument_id)
			.where("start_on < ? AND end_on > ?", end_on, start_on)
			.all.reject { |rental| rental == self }.present?
			errors.add(:base, "Time frame overlaps other rentals")
		end

		# num_overlapping_start_on =
		#     Rental.where("id != ?", id).where(instrument_id: instrument_id).where(
		# 	    "start_on <= ? AND end_on >= ?",
		# 	    start_on, start_on
  #   		).count
  #   	puts num_overlapping_start_on
		# if num_overlapping_start_on > 0
		# 	errors.add(:start_on, "overlaps another request.")
		# end
		# num_overlapping_end_on =
		#     Rental.where("id != ?", id).where(instrument_id: instrument_id).where(
		# 	    "start_on <= ? AND end_on >= ?",
		# 	    end_on, end_on
  #   		).count
  #   	puts num_overlapping_end_on
		# if num_overlapping_end_on > 0
		# 	errors.add(:end_on, "overlaps another request.")
		# end
	end

	#scope :overlaps, ->(start_on, end_on) do
	#	where "((julianday(Date(start_on)) - julianday(?))) * ((julianday(Date(?)) - julianday(end_on))) >= 0", end_on, start_on
	#end

	#def overlaps?
	#	overlaps.exists?
	#end

	#def overlaps
	#	siblings.overlaps start_on, end_on
	#end

	#def not_overlap
	#	errors.add(:base, 'message') if overlaps?
	#end

	#def siblings
	#	user.rentals.where('id != ?', id || -1)
	#end

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
		errors.add(:start_on, "must be before end time") unless start_on < end_on
	end
end
