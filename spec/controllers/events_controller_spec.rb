require 'spec_helper'

describe EventsController do
	describe "#create" do
		let(:owner) do
			User.create!({
				email: "guitarist@awesome.com",
				password: "password",
				password_confirmation: "password",
				first_name: "Nigel",
				last_name: "Foo"
			})
		end
		let(:instrument) do
			Instrument.create!({
				name: "Awesome Instrument",
				user: owner,
				description: "something",
				price: 35,
				category: "Guitar"
			})
		end
		let(:renter) do
			User.create!({
				email: "starving_artist@lessawesome.com",
				password: "password",
				password_confirmation: "password",
				first_name: "Nigel",
				last_name: "Bar"
			})
		end
		let(:rental) do
			Rental.create!({
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
