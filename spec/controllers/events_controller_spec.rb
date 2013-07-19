require 'spec_helper'

describe EventsController do
	describe "#create" do
		let(:owner) do
			FactoryGirl.create(:user)
		end
		let(:instrument) do
			FactoryGirl.create(:instrument, {
                user: owner
			})
		end
		let(:renter) do
			FactoryGirl.create(:user)
		end
		let(:rental) do
			FactoryGirl.create(:rental, {
				instrument: instrument,
				user: renter,
				start_on: Date.today,
				end_on: Date.today+10
			})
		end

		before do
			request.env["HTTP_REFERER"] = "/"
		end

		context "with a valid rental_id" do
			let(:rental_id) { rental.id }

			context "with a valid event" do
				let(:event) { "accept" }

				it "changes the state of the Rental" do
					expect {
						post :create, rental_id: rental_id, event: event
					}.to change {
						rental.reload.state
					}.from("requested").to("accepted")
				end
			end

			context "with an invalid event" do
				let(:event) { "transmogrify" }

				it "doesn't crash" do
					expect {
						post :create, rental_id: rental_id, event: event
					}.not_to raise_error
				end
			end
		end

		context "with an invalid rental_id" do
			let(:rental_id) { -1 }

			it "doesn't crash" do
				post :create, rental_id: rental_id, event: "accept"
				response.should be_redirect
			end
		end
	end
end
