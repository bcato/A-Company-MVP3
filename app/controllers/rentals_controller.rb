class RentalsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :require_instrument

	def index
	end

	def accept
		@rental = current_user.rentals.find(params[:id])
		if @rental.accept!
			flash[:success] = "You are now rental with #{@rental.renter.name}"
		else
			flash[:error] = "That rental could not be accepted."
		end
		redirect_to rentals_path
	end

	# GET /instruments/:instrument_id/rentals/new
	def new
		rental_params = params[:rental] || {}
		rental_params[:instrument_id] = @instrument.id
		rental_params[:user_id] = current_user.id
		@rental = Rental.new(rental_params)
	end


	def create
		@rental = current_user.rentals.build(params[:rental])
		if @rental.save
			flash[:success] = "Rental requested for #{@rental.instrument.name}"
			redirect_to new_instrument_rental_path(@rental.instrument,:rental => params[:rental])
		else 
			raise params.inspect
			flash[:error] = @rental.errors.full_messages.join("\n")
			redirect_to new_instrument_rental_path(@rental.instrument,:rental => params[:rental])
		end
	end

	def destroy
		@user = Rental.find(params[:id])
		#current_user.unrent!(@user)
		#redirect_to @user
	end


	private 

	def require_instrument
	 	@instrument = Instrument.find(params[:instrument_id])
	rescue
		flash[:alert] = "Unable to find instrument."
		redirect_to :back
	end

  #def request
   # @instrument = current_user.instruments.find(params[:id]).request!
    #@instrument.state = "rented"
    #@instrument.save!

    #redirect_to instruments_path, notice: "Instrument was requested!"
  #end
end
