class UserNotifier < ActionMailer::Base
  default from: "hello@andante.cc"

  def instrument_requested(rental_id)
  	rental = Rental.find(rental_id)

  	@user = rental.instrument.user
  	@renter = rental.user

  	mail to: @user.email,
  		subject: "Hey there. #{@rental.user.first_name} wants to rent your instrument. How do you feel about that?"
  end


  def instrument_request_accepted(rental_id)
  	rental = Rental.find(rental_id)

  	@user = rental.instrument.user
    @renter = rental.user

  	mail to: @renter.email,
  		subject: "Great news, #{@rental.instrument.user.first_name} has agreed to lend you #{@instrument.name}! Isn't that cool!"
  end

  def instrument_request_canceled(rental_id)
    rental = Rental.find(rental_id)

    @user = rental.instrument.user
    @renter = rental.user

    mail to: @user.email,
      subject: "Hello #{@rental.instrument.user.first_name}, sorry but, #{@rental.user.first_name} has decided to cancel the rental. #{@instrument.name} will now be made available for rent again."
  end

  def instrument_request_rejected(rental_id)
    rental = Rental.find(rental_id)

    @user = rental.instrument.user
    @renter = rental.user

    mail to: @renter.email,
      subject: "Hello #{@rental.user.first_name}, sorry but #{@rental.instrument.user.first_name} did not want to lend you #{@instrument.name} at this time. Please try another!"
  end


end
