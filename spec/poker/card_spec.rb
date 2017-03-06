require 'spec_helper'

describe Poker::Card do
  let(:card) { Poker::Card.new(['K', 'S']) }

  describe '.initialize' do
    let(:subject) { card }
    let(:rank_index) { Poker::Card::RANKS.index('K') }

    it { is_expected.to be_a(Poker::Card) }
    it { is_expected.to have_attributes(suit: 'S', rank: 'K', rank_index: rank_index) }
  end


  describe '<=>(other)' do
    let(:subject) { card >= other }

    context "compares the RANKS index of each card's rank" do
      let(:other) { Poker::Card.new(['J', 'S']) }

      it { is_expected.to be_truthy }
    end


    context "compares the RANKS index of each card's rank" do
      let(:other) { card.dup }

      it { is_expected.to be_truthy }
    end


    context "compares the RANKS index of each card's rank" do
      let(:other) { Poker::Card.new(['A', 'S']) }

      it { is_expected.to be_falsy }
    end

  end

end
