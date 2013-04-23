class RentshipsController < ApplicationController
	before_filter :authenticate_user!

	def index
	end

	def accept
		@rentship = current_user.Rentship.find(params[:id])
		if @rentship.accept!
			flash[:success] = "You are now rentship with #{@rentship.renter.name}"
		else
			flash[:error] = "That rentship could not be accepted."
		end
		redirect_to_rentships_path
	end

	def new
		@rentship = current_user.Rentship.new(params[:rentship])
	end


	def create
			@rentship = current_user.Rentship.build(:renter_id => params[:renter_id])
		if   @rentship.save
			flash[:success] = "You are now renting an instrument to #{@renter.name}"
			redirect_to users_path(@renter)
		else
			flash[:error] = "Renter required"
			redirect_to root_path
		end
	end

	def edit
		
	end
end
