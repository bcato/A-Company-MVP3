//= require noty/jquery.noty
//= require noty/layouts/center
//= require noty/themes/default

$ = jQuery
$.noty.defaults.timeout = 8000
$.noty.defaults.layout = "center"

$.rails.allowAction = (link) ->
	return true unless link.attr('data-confirm')
	$.rails.showConfirmDialog(link) 
	false

$.rails.showConfirmDialog = (link) ->
  message = link.attr 'data-confirm'
  okButton =
    type: 'btn btn-primary'
    text: 'Ok'
    click: (noty) -> $.rails.confirmed(link); noty.close()
  cancelButton = 
    type: 'btn btn-danger'
    text: 'Cancel'
    click: (noty) -> noty.close()
  noty
    text: message
    buttons: [okButton, cancelButton]
    closable: false
    timeout: false
    modal: true


