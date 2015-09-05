class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.playerHit()
    'click .stand-button': -> 
      @model.get('dealerHand').at(0).flip()
      @model.playOutDealer()

  initialize: ->
    @render()
    context = @
    @model.on 'endGame', (name, condition) -> 
      setTimeout ->
        window.alert("#{name}#{condition}!")
        context.reset()
      , 100

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  reset: ->
    @model.reset()
    @render()
