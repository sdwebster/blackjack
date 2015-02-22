class window.GameView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <button class="play-again-button">Play Again</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <h2 class="lowDown">"lowDown goes here"<h2>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .play-again-button': -> @newGame()
    "gameOver, @model.get 'playerHand')": -> console.log 'the View can see the game end'

  newGame: ->
    # console.log 'gameView knows its a new game'
    @model.initialize();
    @render();

  initialize: ->
    @render()
    # this feels like cheating. Are you allowed to do this in BBone?
    @model.on 'gameOver', (->
      # console.log 'gameView knows game is done'
      @completeGame()),
      @

  completeGame: ->
    @$('.lowDown').text(@model.get 'lowDown')
    @$('.hit-button').prop('disabled', true);
    @$('.stand-button').prop('disabled', true);


  render: ->
    @$el.children().detach()
    @$el.html @template @model
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.lowDown').text(@model.get 'lowDown')

