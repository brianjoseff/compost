# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  subscriber.setupForm()

subscriber =
  setupForm: ->
    $('#new_subscriber').submit ->
      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        subscriber.processCard()
        false
      else
        true
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, subscriber.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
    if status == 200
    # "You will be charged $30 right now for the compost bin, and your subscription will start when you get your bin and I make the first delivery"
      # alert(response.id)
      $('#subscriber_stripe_card_token').val(response.id)
      $('#new_subscriber')[0].submit()
    else
      alert(response.error.message)
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)