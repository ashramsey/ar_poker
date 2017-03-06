require 'spec_helper'

describe Poker::HandRanking do
  let(:cards) { winning_hand }
  let(:ranking) { Poker::HandRanking.new(cards.split(' ')) }


  describe '@cards' do
    let(:subject) { ranking.cards }

    let(:cards) { 'JH 9H KH TH AH' }

    it { is_expected.to all(be_a(Poker::Card)) }

    it 'is sorted' do
      expect(subject.map(&:to_s).join(' ')).to eq '9H TH JH KH AH'
    end
  end



  describe '.process_cards' do
    let(:subject) { ranking.process_cards }

    it 'iterates RANKS to identify a ranking' do
      count_combinations = Poker::HandRanking::COMBINATIONS.count
      expect(ranking).to receive(:build).exactly(count_combinations).times
      subject
    end

    context 'identified rank' do
      let(:combinations) { {
        straight_flush: false,
        four_of_a_kind: true,
        full_house: true
      } }

      before do
        combinations.each do |combo, result|
          allow(ranking).to receive(:build).with(combo) { result ? combo : nil}
        end

      end

      it { is_expected.to eq :four_of_a_kind }

      it 'finds the top matching rank' do
        subject
        expect(ranking).to_not have_received(:build).with(:full_house)
      end
    end
  end



  describe '.build(combination)' do
    let(:combination) { :straight_flush }
    let(:subject) { ranking.build(combination) }

    context 'combination does not match' do
      let(:cards) { '8H 9H KH TH AH' }

      it { is_expected.to be_nil }
    end

    context 'combination matches' do
      let(:cards) { 'JH QH KH TH AH' }

      it { is_expected.to be_a(Poker::Rank) }

      describe 'initialiser params' do
        let(:combinations) { Poker::HandRanking::COMBINATIONS }
        let(:index) { combinations.count - combinations.index(combination) }
        let(:values) { 'FOO' }

        it 'initializes the rank with index and values' do
          allow(ranking).to receive(:send) { values }
          expect(Poker::Rank).to receive(:new).with(index, values)
          subject
        end
      end

    end
  end



  describe '.highest_card' do
    let(:subject) { ranking.highest_card }

    it { is_expected.to be_truthy }

    it 'returns the highest ranked card' do
      expect(subject.to_s).to eq 'AH'
    end
  end


  describe '.one_pair' do
    let(:subject) { ranking.one_pair }

    it { is_expected.to be_falsey }

    context 'exists' do
      let(:cards) { '2S 2H 3H 4H 5H' }
      it { is_expected.to be_truthy }
    end


    context '2 pairs exist' do
      let(:cards) { '2S 2H 3H 3S 5H' }
      it { is_expected.to be_falsey }
    end
  end


  describe '.two_pairs' do
    let(:subject) { ranking.two_pairs }

    it { is_expected.to be_falsey }

    context 'only 1 exists' do
      let(:cards) { '2S 2H 3H 4H 5H' }
      it { is_expected.to be_falsey }
    end


    context 'exist' do
      let(:cards) { '2S 2H 3H 3S 5H' }
      it { is_expected.to be_truthy }
    end
  end


  describe '.three_of_a_kind' do
    let(:subject) { ranking.three_of_a_kind }

    it { is_expected.to be_falsey }

    context 'exists' do
      let(:cards) { '2S 2H 2D 4H 5H' }
      it { is_expected.to be_truthy }
    end
  end


  describe '.straight' do
    let(:cards) { 'AS 3H 4D 5H 6H' }
    let(:subject) { ranking.straight }

    it { is_expected.to be_falsey }

    context 'has less than 5 groups of card ranks' do
      let(:cards) { '6H 6S 4D 4C 5H' }
      it { is_expected.to be_falsey }
    end

    context 'difference between first and last ranks > 4' do
      let(:cards) { '2S 3H 4D 5H 7H' }
      it { is_expected.to be_falsey }
    end

    context 'exists' do
      let(:cards) { '2S 3H 4D 5H 6H' }
      it { is_expected.to be_truthy }
    end

    context 'ace low' do
      let(:cards) { '2S 3H 4D 5H AH' }
      it { is_expected.to be_truthy }
    end

    context 'ace high' do
      let(:cards) { 'TS JH QD KH AH' }
      it { is_expected.to be_truthy }
    end
  end


  describe '.flush' do
    let(:cards) { 'AH 3H 4D 5H 6H' }
    let(:subject) { ranking.flush }

    it { is_expected.to be_falsey }

    context 'exists' do
      let(:cards) { 'AH 3H 4H 5H 6H' }
      it { is_expected.to be_truthy }
    end
  end


  describe '.full_house' do
    let(:subject) { ranking.full_house }

    it { is_expected.to be_falsey }

    context 'exists' do
      let(:cards) { 'AH AS 4H 4D 4C' }
      it { is_expected.to be_truthy }
    end
  end


  describe '.four_of_a_kind' do
    let(:subject) { ranking.four_of_a_kind }

    it { is_expected.to be_falsey }

    context 'exists' do
      let(:cards) { 'AH AS AC AD 4C' }
      it { is_expected.to be_truthy }
    end
  end


  describe '.straight_flush' do
    let(:subject) { ranking.straight_flush }

    it { is_expected.to be_falsey }

    context 'exists' do
      let(:cards) { '2C 3C 4C 5C 6C' }
      it { is_expected.to be_truthy }
    end
  end
end
