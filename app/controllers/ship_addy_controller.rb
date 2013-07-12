class Ship_AddyController < ApplicationController

	def show
		@ship_addy = Ship_Addy.find(params[:id])
	end

	def create
		@ship_addy = Ship_Addy.create(params[:rental])
	end

# GET /instruments/:instrument_id/rentals/new
	def new
		ship_addy_params = params[:ship_addy] || {}
		ship_addy_params[:rental_id] = current_rental.id
		@ship_addy = Ship_Addy.new(ship_addy_params)
	end

end