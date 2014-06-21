#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'playerBusted', =>
      @trigger 'gameOver', 'dealerWon'

    @get('playerHand').on 'stand', =>
      @get('dealerHand').at(0).flip()
      # while dealer score <= 16
      while @get('dealerHand').scores() <= 16 || @get('dealerHand').scores()[1] <= 16
        # calls hit for dealer
        @get('dealerHand').hit()

      dealer = @get('dealerHand').scores()
      player = @get('playerHand').scores()

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
