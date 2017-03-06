require 'spec_helper'

describe Poker::Hand do
  let(:cards) { winning_hand.split(' ') }
  let(:hand) { Poker::Hand.new(cards) }

  describe '.initialize' do
    let(:subject) { hand }

    it { is_expected.to be_a(Poker::Hand) }

    it 'creates a HandRanker and processes the cards' do
      ranker = double(:ranker, process_cards: true)
      expect(Poker::HandRanking).to receive(:new).with(cards).and_return ranker
      expect(ranker).to receive(:process_cards)
      subject
    end

    describe 'rank' do
      let(:subject) { hand.rank }

      it { is_expected.to be_a(Poker::Rank) }
    end
  end



  describe '<=>(other)' do
    let(:subject) { hand >= other }
    let(:other) { double(:other, rank: 2) }

    it 'compares the value of each hand' do
      allow(hand).to receive(:rank).and_return 1
      expect(subject).to be_falsy
    end

    it 'compares the value of each hand' do
      allow(hand).to receive(:rank).and_return 2
      expect(subject).to be_truthy
    end

    it 'compares the value of each hand' do
      allow(hand).to receive(:rank).and_return 3
      expect(subject).to be_truthy
    end

  end

end
