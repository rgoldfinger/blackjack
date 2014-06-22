class window.AppView extends Backbone.View

  template: _.template '
    <div><button class="hit-button">Hit</button> <button class="stand-button">Stand</button></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .next-hand": -> @model.nextHand()

  initialize: ->
    @render()
    @model.on 'gameOver nextHand', @render, @

  render: (result = null) ->
    @$el.children().detach()
    @$el.html @template()
    if result != null
      if result == 'dealerWon'
        @model.set 'playerScore', @model.get('playerScore') - 1
        @$el.children().first().html('You LOST!')
      else if result == 'playerWon'
        @model.set 'playerScore', @model.get('playerScore') + 1
        @$el.children().first().html('You WON!')
      else if result == 'push'
        @$el.children().first().html('push')
      @$el.children().first().append('<button class="next-hand">Next Hand</button>')

    @$el.children().first().append('Your score is ' + @model.get 'playerScore')

    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
