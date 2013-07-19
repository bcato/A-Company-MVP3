FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@example.com" }

  factory :user do
  	password 'password'
  	password_confirmation 'password'
  	email { generate :email }
    first_name 'John'
    last_name 'Doe'
  end

  factory :instrument do
  	description "My description."
  	name "My Instrument"
  	price 10
  	category "Guitars"
  	user
  end

  factory :rental do
  	instrument
  	user
  	start_on { Date.today + 10 }
  	end_on { Date.today + 40 }
  end
end