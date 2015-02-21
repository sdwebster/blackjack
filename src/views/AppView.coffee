class window.AppView extends Backbone.View
  template: _.template '
    <h1>Black Jack Hacks Back</h1>
    <div class="game-container"></div>
  '

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.game-container').html new GameView(model: @model.get 'game').el

