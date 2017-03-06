module Poker
  class HandRanking

    COMBINATIONS = %i(straight_flush four_of_a_kind full_house flush straight three_of_a_kind two_pairs one_pair highest_card)

    attr_accessor :cards

    def initialize(cards)
      @cards = cards.map do |card|
        Card.new(card.split(//))
      end

      @cards.sort!

      self
    end


    def process_cards
      rank = nil
      COMBINATIONS.find do |combination|
        rank = self.build(combination)
      end

      rank
    end


    def build(combination)
      return nil unless values = send(combination)

      index = COMBINATIONS.count - COMBINATIONS.index(combination)
      Rank.new(index, values)
    end


    # (5 cards in a row all of the same suit)
    def straight_flush
      return unless straight && flush
      straight
    end


    def four_of_a_kind
      rank = of_a_kind(4).keys[0]
      Card::RANKS.index(rank)
    end


    # three of a kind plus a pair
    # returns the value of the three_of_a_kind
    def full_house
      return unless three_of_a_kind && one_pair
      three_of_a_kind
    end


    # 5 of the same suit
    def flush
      return unless uniq(&:suit)
      cards.map(&:to_s)
      sum(&:rank_index)
    end


    # 5 cards in a row
    def straight
      return if groups.count < 5

      delta = cards[4].rank_index - cards[0].rank_index

      # try for low ace
      if cards[0].rank == '2' && cards[4].rank == 'A'
        delta = cards[3].rank_index
      end

      return if delta > 4

      @straight ||= sum(&:rank_index)

      @straight
    end


    def three_of_a_kind
      @three_of_a_kind ||= begin
        rank = of_a_kind(3).keys[0]
        Card::RANKS.index(rank)
      end
    end


    def two_pairs
      return unless pairs.values.count == 2
      pairs.keys.map { |rank| Card::RANKS.index(rank) }.reverse
    end



    def one_pair
      return unless pairs.values.count == 1
      rank = pairs.keys[0]
      Card::RANKS.index(rank)
    end


    def pairs
      @pairs ||= of_a_kind(2) || []
    end


    def groups
      @groups ||= @cards.group_by(&:rank)
    end


    def highest_card
      @cards.last
    end



    def of_a_kind(num)
      groups.select do |rank, cards|
        cards.count == num
      end
    end


    def sum(&block)
      @cards.map(&block).inject(:+)
    end


    def uniq(&block)
      @cards.map(&block).uniq.count == 1
    end

  end

end
