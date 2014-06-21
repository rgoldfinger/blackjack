#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'playerBusted', =>
      @trigger 'gameOver', false

  #on add event on player hand
    # check the score
    # if score is over 21
    # indicate loss
    # UNSURE WHERE LIVES: player loses event

  #on add event on dealer hand
    # check the score
    #

###

need score when "hit" (to make sure not busted)
need score when dealer players
in determining winner
###
