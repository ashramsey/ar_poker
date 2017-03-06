module GameHelpers
  def winning_hand
    "TH JS QD KC AH"
  end


  def losing_hand
    "TH 2S 3D 4C 5H"
  end


  def straight_flush(suit = 'H')
    [:T,:J,:Q,:K,:A].map{|rank| "#{rank}#{suit}"}.join(" ")
  end

  def four_of_a_kind(rank = 'A', high = 'K', suit = 'H')
    "#{high}#{suit} " + [:S,:D,:C,:H].map{|suit| "#{rank}#{suit}"}.join(" ")
  end

  def full_house(ranks = ['A', 'K'])
    ([:H,:S].map{|suit| "#{ranks[1]}#{suit}"} +
    [:H,:S,:D].map{|suit| "#{ranks[0]}#{suit}"}).join(' ')
    # "TH TS AD AC AH"
  end

  def flush
    "9H JH QH KH AH"
  end

  def straight
    "TS JH QH KH AH"
  end

  def three_of_a_kind
    "TH JS AD AC AH"
  end

  def two_pairs
    "TH JS JD AC AH"
  end

  def one_pair
    "TH JS QD AC AH"
  end

  def highest_card
    "9H JS QD KC AH"
  end
end
