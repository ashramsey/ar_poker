module Poker
  class Hand
    include Comparable

    attr_accessor :rank

    def initialize(cards)
      @ranker = HandRanking.new(cards)
      @rank = @ranker.process_cards

      self
    end


    def <=>(other)
      rank <=> other.rank
    end


    def to_s
      @ranker.cards.flat_map(&:to_s).join(' ')
    end

  end
end
