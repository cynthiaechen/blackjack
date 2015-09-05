class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @last()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: ->
    @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    #check if minScore > 21, if so, trigger bust event
  
  checkForBust: ->
    if @minScore() > 21
      setTimeout( this.trigger("busted").bind(this), 100)

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    @minScore() #@minScore() + 10 * @hasAce()]

  play: (playerScore) ->
    @at(0).flip()
    minScore = @minScore()
    while minScore < 17
      @hit()
      minScore = @minScore()
    if minScore > 21
    else if minScore > playerScore 
      @trigger('dealerWins')
    else if minScore < playerScore 
      @trigger('playerWins')
    else @trigger('push')

  #play: -> takes in player score as parameter
  # check dealer score 
  # (while dealer score < 17)
    #dealer hits, then check dealer score for bust;
    #if score is bust, trigger bust event that appView is listening for
  #compare dealer score and player score --> fire off dealer wins or player wins events