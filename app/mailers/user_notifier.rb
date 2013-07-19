class UserNotifier < ActionMailer::Base
  default from: "hello@andante.cc"

  def instrument_requested(rental_id)
  	@rental = Rental.find(rental_id)

  	@user = @rental.instrument.user
  	@renter = @rental.user

  	mail to: @user.email,
  		subject: "You have a rental request on Andante!"
  end


  def instrument_request_accepted(rental_id)
  	@rental = Rental.find(rental_id)

  	@user = @rental.instrument.user
    @renter = @rental.user

  	mail to: @renter.email,
  		subject: "Your Andante rental request has been accepted!"
  end

  def instrument_request_canceled(rental_id)
    @rental = Rental.find(rental_id)

    @user = @rental.instrument.user
    @renter = @rental.user

    mail to: @user.email,
      subject: "Your Andante rental request has been cancelled"
  end

  def instrument_request_rejected(rental_id)
    @rental = Rental.find(rental_id)

    @user = @rental.instrument.user
    @renter = @rental.user

    mail to: @renter.email,
      subject: "Andante was not able to complete your rental request"
  end

end
