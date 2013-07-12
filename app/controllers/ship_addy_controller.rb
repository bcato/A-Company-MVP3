class ShipAddyController < ApplicationController
	before_filter :authenticate_user!
	before_filter :require_rental

	def show
		@ship_addy = Ship_Addy.find(params[:id])
	end

	def create
		@ship_addy = Ship_Addy.create(params[:rental])
	end

  # GET /instruments/:instrument_id/rentals/:rental_id/new
	def new
		ship_addy_params = params[:ship_addy] || {}
		ship_addy_params[:rental_id] = @rental.id
		ship_addy_params[:instrument_id] = @instrument.id
		ship_addy_params[:user_id] = current_user.id
		@ship_addy = Ship_Addy.new(ship_addy_params)
	end


	
	private

	def require_rental
		@rental = Rental.find(params[:rental_id])
	rescue
		flash[:alert] = "Unable to find instrument."
		redirect_to :back
	end

end