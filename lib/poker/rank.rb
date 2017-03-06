module Poker
  class Rank
    include Comparable

    attr_accessor :values

    def initialize(hand_rank, card_ranks)
      @hand_rank = hand_rank
      @card_ranks = card_ranks

      @values = [@hand_rank, @card_ranks].flatten

      self
    end


    def <=>(other)
      for i in 0..(values.count - 1) do
        comparison = values[i] <=> other.values[i]
        break unless comparison == 0
      end

      comparison
    end


  end
end
