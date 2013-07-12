
responseCallbackHandler = (response) ->
	switch response.status
		when 400

			# missing or invalid field - check response.error for details
      		console.log response.error
    	
    	when 404
      
      		# your marketplace URI is incorrect
      		console.log response.error
    	
    	when 201
      
      		# WOO HOO MONEY
      		# response.data.uri == URI of the bank account resource you
      		# should store this bank account URI to later credit it
      		console.log response.data
      		$form = $("#bank-account-form")

      		# the uri is an opaque token referencing the tokenized bank account
      		bank_account_uri = response.data["uri"]

      		# append the token as a hidden field to submit to the server
      		$("<input>").attr(
      			type: "hidden"
      			value: bank_account_uri
      			name: "balanceBankAccountURI"
      		).appendTo $form
      		$form.attr action: requestBinURL
      		$form.get(0).submit()

# FOR DEMONSTRATION PURPOSES ONLY - if you already have a server you can POST to, replace the URL with the URL to post to.
# go to http://requestb.in/
# click create new request bin and COPY that URL without the ?inspect at the end
#replace the /v1/ with the Uri from balanced
 requestBinURL = "http://requestb.in/onetigon"
 marketplaceUri = "/v1/marketplaces/TEST-MP2autgNHAZxRWZs76RriOze"
 balanced.init marketplaceUri
 tokenizeInstrument = (e) ->
 	e.preventDefault()
 	$form = $("#bank-account-form")
 	bankAccountData = 
 		name: $form.find(".ba-name").val()
 		bank_code: $form.find(".ba-rn").val()
 		type: $form.find("select").val()

 balanced.bankAccount.create bankAccountData, responseCallbackHandler

$("#bank-account-form").submit tokenizeInstrument
