require 'spec_helper'

describe Poker::Game do
  let(:game) { Poker::Game.new(hands: [winning_hand, losing_hand]) }

  describe '.initialize' do
    let(:subject) { game }

    it { is_expected.to be_a(Poker::Game) }

    describe 'hands' do
      let(:subject) { game.hands }

      it { is_expected.to all(be_a(Poker::Hand)) }
    end
  end


  describe '.winner' do
    let(:game) { Poker::Game.new(hands: []) }
    let(:subject) { game.winner }

    before do
      game.hands = [1, 2]
    end

    it { is_expected.to eq 2 }
  end

  describe 'games' do
    let(:game) { Poker::Game.new(hands: [hand, other_hand]) }
    let(:subject) { game.winner.to_s }

    describe 'straight_flush' do
      context 'win' do
        let(:hand) { 'TH JH QH KH AH' }
        let(:other_hand) { '9H 9S 9D 9C AS' }

        it { is_expected.to eq hand }
      end

      context 'draw' do
        let(:hand) { 'TH JH QH KH AH' }
        let(:other_hand) { 'TS JS QS KS AS' }

        it { is_expected.to eq "DRAW" }
      end


      context 'lose' do
        let(:hand) { '9H 9S 9D 9C AS' }
        let(:other_hand) { 'TH JH QH KH AH' }

        it { is_expected.to eq other_hand }
      end
    end


    describe 'four_of_a_kind' do
      context 'win' do
        let(:hand) { '9H 9S 9D 9C AS' } # four_of_a_kind
        let(:other_hand) { 'KS KH AS AH AD' } # full_house

        it { is_expected.to eq hand }
      end

      context '2 FoK' do
        let(:hand) { 'QS AH AS AD AC' } # four_of_a_kind
        let(:other_hand) { 'KH KS KD KC AH' } # four_of_a_kind

        it { is_expected.to eq hand }
      end


      context 'lose' do
        let(:hand) { 'KS KH AS AH AD' } # full_house
        let(:other_hand) { '9H 9S 9D 9C AS' } # four_of_a_kind

        it { is_expected.to eq other_hand }
      end

    end


    describe 'full_house' do
      context 'win' do
        let(:hand) { 'KS KH AS AH AD' } # full_house
        let(:other_hand) { 'TH JH 4H QH AH' } # flush

        it { is_expected.to eq hand }
      end


      context '2 fh' do
        let(:hand) { 'KS KH AS AH AD' } # full_house
        let(:other_hand) { 'JS JH QS QH QD' } # full_house

        it { is_expected.to eq hand }
      end


      context 'lose' do
        let(:hand) { 'QS QH QC AH AD' } # full_house
        let(:other_hand) { 'JH JD KS KH KC' } # full_house

        it { is_expected.to eq other_hand }
      end
    end


    describe 'flush' do
      context 'win' do
        let(:hand) { '4H TH JH QH AH' } # flush
        let(:other_hand) { '4S 5H 6H 7H 8H' } # straight

        it { is_expected.to eq hand }
      end


      context '2 flush different ranks' do
        let(:hand) { '4H TH JH QH AH' } # flush
        let(:other_hand) { '3S TS JS QS AS' } # flush

        it { is_expected.to eq hand }
      end


      context '2 flush same ranks' do
        let(:hand) { '4H TH JH QH AH' } # flush
        let(:other_hand) { '4S TS JS QS AS' } # flush

        it { is_expected.to eq "DRAW" }
      end


      context 'lose' do
        let(:hand) { '2S 3H 4C 5H 6D' } # straight
        let(:other_hand) { '4S TS JS QS AS' } # flush

        it { is_expected.to eq other_hand }
      end
    end



    describe 'straight' do
      context 'win' do
        let(:hand) { '4S 5H 6H 7H 8H' } # straight
        let(:other_hand) { '4H 5S 9D 9H 9S' } # three_of_a_kind

        it { is_expected.to eq hand }
      end


      context '2 straights different ranks' do
        let(:hand) { '4D 5H 6H 7H 8H' } # straight
        let(:other_hand) { '3D 4S 5S 6S 7S' } # straight

        it { is_expected.to eq hand }
      end


      context '2 straights same ranks' do
        let(:hand) { '4D 5H 6H 7H 8H' } # straight
        let(:other_hand) { '4H 5S 6S 7S 8S' } # straight

        it { is_expected.to eq "DRAW" }
      end


      context 'lose' do
        let(:hand) { '4H 5S 9D 9H 9S' } # three_of_a_kind
        let(:other_hand) { '4S 5H 6H 7H 8H' } # straight

        it { is_expected.to eq other_hand }
      end


      describe 'low ace in straight' do
        let(:hand) { '2S 3D 4H 5S AH' } # straight
        let(:other_hand) { '4H 5S 9D 9H 9S' } # three_of_a_kind

        it { is_expected.to eq hand }
      end
    end


    describe 'three_of_a_kind' do
      context 'win' do
        let(:hand) { '9H 9S 9D TC AS' } # three_of_a_kind
        let(:other_hand) { 'KS KH AS AH QD' } # two_pairs

        it { is_expected.to eq hand }
      end

      context '2 FoK' do
        let(:hand) { '9H 9S 9D TC AS' } # three_of_a_kind
        let(:other_hand) { '8H 8S 8D TD AH' } # three_of_a_kind

        it { is_expected.to eq hand }
      end


      context 'lose' do
        let(:hand) { 'KS KH AS AH QD' } # two_pairs
        let(:other_hand) { '9H 9S 9D TC AS' } # three_of_a_kind

        it { is_expected.to eq other_hand }
      end

    end


    describe 'two_pairs' do
      context 'win' do
        let(:hand) { '9H 9S TD TC AS' } # two_pairs
        let(:other_hand) { 'KS KH JS AH QD' } # one_pair

        it { is_expected.to eq hand }
      end


      context '2 two_pairs different ranks' do
        let(:hand) { 'TD TC JH JS AS' } # two_pairs
        let(:other_hand) { '8H 8S TD TC AH' } # two_pairs

        it { is_expected.to eq hand }
      end


      context '2 two_pairs same high ranks' do
        let(:hand) { '8C 8D 9H 9S AS' } # two_pairs
        let(:other_hand) { '7H 7S 9D 9C AH' } # two_pairs

        it { is_expected.to eq hand }
      end


      context '2 two_pairs same high and low ranks' do
        let(:hand) { '9H 9S TD TC AS' } # two_pairs
        let(:other_hand) { '9D 9C TS TH AH' } # two_pairs

        it { is_expected.to eq 'DRAW' }
      end


      context 'lose' do
        let(:hand) { 'KS KH JS AH QD' } # one_pair
        let(:other_hand) { '9H 9S TD TC AS' } # two_pairs

        it { is_expected.to eq other_hand }
      end

    end


    describe 'one_pair' do
      context 'win' do
        let(:hand) { '9H 9S TD JC AS' } # one_pair
        let(:other_hand) { '2S 3H JS KH QD' } # high_card

        it { is_expected.to eq hand }
      end


      context '2 one_pair different ranks' do
        let(:hand) { '9H 9S TD JC AS' } # one_pair
        let(:other_hand) { '8H 8S 9D TC AH' } # one_pair

        it { is_expected.to eq hand }
      end


      context '2 one_pair same ranks' do
        let(:hand) { '5C 8D 9H 9S AS' } # one_pair
        let(:other_hand) { '6H 7S 9D 9C AH' } # one_pair

        it { is_expected.to eq 'DRAW' }
      end


      context 'lose' do
        let(:hand) { '4S 5H JS QH KD' } # high_card
        let(:other_hand) { '8H 9S TD TC AS' } # one_pair

        it { is_expected.to eq other_hand }
      end

    end



    describe 'highest_card' do
      context 'win' do
        let(:hand) { '8H 9S TD JC AS' } # ace
        let(:other_hand) { '2S 3H JS QH KD' } # king

        it { is_expected.to eq hand }
      end


      context '2 one_pair different ranks' do
        let(:hand) { '8H 9S TD JC AS' } # ace
        let(:other_hand) { '4H 5S 9D TC AH' } # ace

        it { is_expected.to eq 'DRAW' }
      end


      context 'lose' do
        let(:hand) { '2S 3H JS QH KD' } # king
        let(:other_hand) { '8H 9S TD JC AS' } # ace

        it { is_expected.to eq other_hand }
      end

    end
  end
end
