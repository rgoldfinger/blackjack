#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'playerBusted', =>
      @get('dealerHand').at(0).flip()
      @trigger 'gameOver', 'dealerWon'

    @get('playerHand').on 'stand', =>
      @get('dealerHand').at(0).flip()

      dealer = @get('dealerHand').scores()
      player = @get('playerHand').scores()

      if dealer.length == 2
        dealerScore = dealer[1]
      else
        dealerScore = dealer[0]

      while dealerScore < 17
        @get('dealerHand').hit()
        dealer = @get('dealerHand').scores()
        if dealer.length == 2 and dealer[1] < 22
          dealerScore = dealer[1]
        else
          dealerScore = dealer[0]


      if dealer.length > 1 and dealer[1] < 22
        dealer[0] = dealer[1]

      if player.length > 1 and player[1] < 22
        player[0] = player[1]

      if dealer[0] > 21 or dealer[0] < player[0]
        result = 'playerWon'
      else if dealer[0] == player[0]
        result = 'push'
      else
        result = 'dealerWon'

      @trigger 'gameOver', result
