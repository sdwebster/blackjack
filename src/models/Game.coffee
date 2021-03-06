# an internal Game Model that contains the game logic
class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'lowDown', "Let's play some blackjack!"

    (@get 'playerHand').on 'gameOver', (->
      # console.log 'game is done'
      @completeGame()),
      @

  completeGame: ->
    if (@get 'playerHand').busted()
      lowDown = 'You got busted! You lose!'
    else
      (@get 'dealerHand').playOut()
      if (@get 'dealerHand').busted()
        lowDown = 'The dealer got busted! You win!'
      else
        console.log (@get 'playerHand').scores()
        pScore = (@get 'playerHand').bestScore();
        dScore = (@get 'dealerHand').bestScore();
        lowDown = "You had #{pScore} and the dealer had #{dScore}. "
        if (pScore > dScore)
          lowDown += "Well done!"
        else if (pScore == dScore)
          lowDown += "It's a tie! Click 'Play Again' to play again."
        else
          lowDown += "Better luck next time!"
    @set 'lowDown', lowDown
    @trigger 'gameOver'

      # if (@get 'dealerHand').minScore()

