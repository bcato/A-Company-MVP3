class UserNotifier < ActionMailer::Base
  default from: "from@andante.cc"

  def instrument_requested(instrument_id)
  	instrument = Instrument.find(instrument_id)

  	@user = instrument.user
  	@renter = instrument.renter

  	mail to: @user.email,
  		subject: "Hey there. #{@renter.name} wants to rent your instrument. How do you feel about that?"
  end


  def instrument_request_accepted(instrument_id)
  	instrument = Instrument.find(instrument_id)

  	@user = instrument.user
  	@renter = instrument.renter

  	mail to: @user.email,
  		subject: "Great news, #{@user.name} has agreed to lend you #{@instrument.name}! Isn't that cool!"
  end

  def instrument_request_canceled(instrument_id)
    instrument = Instrument.find(instrument_id)

    @user = instrument.user
    @renter = instrument.renter

    mail to: @user.email,
      subject: "Hello #{@user.name}, sorry but, has decided to cancel the rental. #{@instrument.name} will now be made available for rent again."
  end

  def instrument_request_rejected(instrument_id)
    instrument = Instrument.find(instrument_id)

    @user = instrument.user
    @renter = instrument.renter

    mail to: @user.email,
      subject: "Hello #{@renter.name}, sorry but #{@user.name} did not want to lend you #{@instrument.name} at this time. Please try another!"
  end


end
