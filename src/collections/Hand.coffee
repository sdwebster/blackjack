class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    if not @isDealer and @busted() then @trigger('gameOver')

  stand: ->
    console.log 'stand'
    @trigger('gameOver')

  hasAceShowing: -> @reduce (memo, card) ->
    memo or (card.get('revealed') and card.get('value') is 1)
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAceShowing()]

  bestScore: ->
    if @scores()[1] > 21
      @scores()[0]
    else
      @scores()[1]

  busted: ->
    @minScore() > 21

  #if this is the dealer hand, it needs to be able to
  playOut: ->
    console.log 'playing out dealer hand'
    # flip first card over
    @at(0).flip()
    while (@bestScore() < 17 and not @busted())
      @hit()

