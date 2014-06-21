class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    # if scores[1] && scores[1] < 22
    # scores = scores[1]
    # else scores = scores[0]

    scoresArr = @collection.scores()
    if scoresArr.length == 2 and scoresArr[1] < 22 then score = scoresArr[1] else score = scoresArr[0]

    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text score

