class EventsController < ApplicationController
	#before_filter :authenticate_user!
	before_filter :require_rental
	#before_filter :ensure_owner

    def create
    	begin
	  	    @rental.fire_state_event(params[:event])
	  	    @rental.save!
  		rescue IndexError
  			flash[:error] = "No such event."
  		end
  	    redirect_to :back
    end

    private 

	def require_rental
	 	@rental = Rental.find(params[:rental_id])
	rescue
		flash[:alert] = "Unable to find rental."
		redirect_to :back
	end

	def ensure_owner
		if (@rental.instrument.user != current_user)
			flash[:error] = "You can't do that"
			redirect_to :back
		end
	end
end
