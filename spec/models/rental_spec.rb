require 'spec_helper'

describe Rental do
	describe "validation" do
		let(:instrument) { FactoryGirl.create(:instrument) }
	    subject(:rental) { FactoryGirl.build(:rental, start_on: start_on, end_on: end_on, instrument: instrument) }

	    context "with valid start and end dates" do
	    	let(:start_on) { Date.today + 10 }
	    	let(:end_on) { start_on + 7 }

	    	it { should be_valid }
	    end

	    context "with a start date after the end date" do
	    	let(:start_on) { Date.today + 10 }
	    	let(:end_on) { start_on - 7 }

	    	it { should_not be_valid }
	    end

	    describe "overlapping validation" do
	    	let(:start_on) { Date.today + 10 }
	    	let(:end_on) { start_on + 7 }

		    context "with another non-overlapping rental" do
		    	let!(:other_rental) { FactoryGirl.create(:rental, start_on: start_on - 10, end_on: start_on - 5, instrument: instrument ) }

		    	it { should be_valid }
		    end

		    context "with another rental overlapping start_on" do
		    	let!(:other_rental) { FactoryGirl.create(:rental, start_on: start_on - 1, end_on: start_on + 1, instrument: instrument) }

		    	it { should_not be_valid }
		    end

		    context "with another rental completely inside your dates" do
		    	let!(:other_rental) { FactoryGirl.create(:rental, start_on: start_on + 1, end_on: end_on - 1, instrument: instrument) }

		    	it { should_not be_valid }
		    end

		    context "with another rental overlapping the whole time period" do
		    	let!(:other_rental) { FactoryGirl.create(:rental, start_on: start_on - 1, end_on: end_on + 1, instrument: instrument) }

		    	it { should_not be_valid }
		    end
	    end
	end
end
