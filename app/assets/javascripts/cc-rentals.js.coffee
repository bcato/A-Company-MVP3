# collect the data from the form.
responseCallbackHandler = (response) ->
  switch response.status
    when 400
      
      # missing or invalid field - check response.error for details
      console.log response.error
    when 404
      
      # your marketplace URI is incorrect
      console.log response.error
    when 201
      
      # WOO HOO! MONEY!
      # response.data.uri == URI of the card resource
      # you should store this returned card URI to later charge it
      console.log response.data

# TODO: Replace this with your marketplace URI

$.post "your-marketplace.tld/cards", response.data
marketplaceUri = "{YOUR-MARKETPLACE-URI}"
$form = $("#credit-card-form")
creditCardData =
  card_number: $form.find(".cc-number").val()
  expiration_month: $form.find(".cc-em").val()
  expiration_year: $form.find(".cc-ey").val()
  security_code: $form.find("cc-csc").val()