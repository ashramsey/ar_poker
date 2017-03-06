module Poker
  class Card
    include Comparable

    RANKS = %w(LOW_ACE 2 3 4 5 6 7 8 9 T J Q K A)

    attr_accessor :suit, :rank, :rank_index

    def initialize(rank_suit)
      @rank, @suit = *rank_suit
      @rank_index = RANKS.index(@rank)
      self
    end


    def to_s
      [@rank, @suit].join
    end


    def <=>(other)
      @rank_index <=> other.rank_index
    end




  end
end
