require 'thor'

module Poker
  class CLI < Thor

    desc "play HAND HAND",
<<-EOL
Determines the winner of 2 hands

Examples:
  $ poker play '2S 3S 4S 5S 6S' 'TC JS QD KH AC'
  $ poker play '5H AD 3C JH JS' 'TC TS TD TH AC'

  Supply 2 hands. Each hand is made up of 5 cards each represented by a Rank (2..9, TJQKA) and a Suit (H,S,D,C).
  The result of the play is output as the winnig hand or a 'DRAW'.

EOL
    def play(hand1, hand2)
      game = Game.new(hands: [hand1.upcase, hand2.upcase])

      print 'Invalid hands, please try again' unless game.valid?

      print game.winner.to_s
      game.winner.to_s
    end
  end
end
