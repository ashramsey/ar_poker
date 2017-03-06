module Poker
  class Game

    attr_accessor :hands

    def initialize(opts = {})
      @hands = opts[:hands].map do |hand|
        Hand.new(hand.split(' '))
      end

      self
    end


    def winner
      a, b = *@hands
      result = a <=> b
      return a if result > 0
      return b if result < 0
      return "DRAW"
    end


    def valid?
      # TODO validate hands
      true
    end
  end
end
