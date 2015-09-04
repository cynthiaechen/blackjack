class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('dealerHand').play(@model.get('playerHand').minScore())

  initialize: ->
    @render()
    @model.get('playerHand').on 'busted', => 
      window.alert('Player busted!')
      @reset()
    @model.get('dealerHand').on 'busted', => 
      window.alert('Dealer busted!')
      @reset()
    @model.get('dealerHand').on 'dealerWins', =>
      window.alert('Dealer wins!')
      @reset()
    @model.get('dealerHand').on 'playerWins', =>
      window.alert('Player wins!')
      @reset()
    @model.get('dealerHand').on 'push', =>
      window.alert("It's a tie!")
      @reset()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  reset: ->
    @model.reset()
    @initialize()

    #app view listens to bust event, then alerts who wins (1: player hits/bust, 2: player stand/dealer wins, 3: player stand/player wins, 4: dealer hits/busts)



