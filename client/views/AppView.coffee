class window.AppView extends Backbone.View

  template: _.template '
    <div><button class="hit-button">Hit</button> <button class="stand-button">Stand</button></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    @model.on 'gameOver', @render, @

  render: (playerWon = null) ->
    @$el.children().detach()
    @$el.html @template()
    if playerWon != null
      playerWon = playerWon[0]
      if not playerWon
        @$el.children().first().html('You LOST!')
      else
        @$el.children().first().html('You WON!')
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
