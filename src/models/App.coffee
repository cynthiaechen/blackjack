# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @deal()

  deal: ->
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()

  reset: ->
    @get('playerHand').each((card)->
      @get('deck').unshift card.reveal()
    , @)
    @get('dealerHand').each((card)->
      @get('deck').unshift card.reveal()
    , @)
    @deal()

  playerHit: ->
    playerHand = @get 'playerHand'
    playerHand.hit()
    if playerHand.checkForBust()
      @trigger 'endGame', 'Player ', 'busted'

  playOutDealer: ->
    dealerHand = @get 'dealerHand'
    #check for bust
    if dealerHand.checkForBust()
      @trigger 'endGame', 'Dealer ', 'busted'
    # if not bust continue
    else
      #check if over/under 17
      if dealerHand.scores() >= 17
        #some method that compares scores and triggers apropriate endgame event
        @compareScores()
      else
        dealerHand.hit()
        #recursive call
        @playOutDealer()
        undefined

  compareScores: ->
    dealer = @get('dealerHand').scores()
    player = @get('playerHand').scores()
    if dealer > player
      @trigger 'endGame', 'Dealer ', 'wins'
    else if player > dealer
      @trigger 'endGame', 'Player ', 'wins'
    else @trigger 'endGame', '', 'Push'


