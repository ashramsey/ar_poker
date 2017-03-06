require 'spec_helper'

describe Poker::Rank do
  let(:hand_rank) { 1 }
  let(:card_ranks) { 2 }
  let(:rank) { Poker::Rank.new(hand_rank, card_ranks) }


  describe '.initialize' do
    let(:subject) { rank }

    it { is_expected.to have_attributes({ values: [hand_rank, card_ranks] }) }
  end


  describe '<=>(other)' do
    let(:subject) { rank }
    let(:other) { double(:other, values: other_values) }

    before do
      rank.values = values
    end

    context '1st values' do
      let(:values) { [3,2,3] }
      let(:other_values) { [2,2,3] }

      it { is_expected.to satisfy { |v| v > other } }
      it { is_expected.to_not satisfy { |v| v == other } }
      it { is_expected.to_not satisfy { |v| v < other } }
    end


    context '2nd values' do
      let(:values) { [1,3,3] }
      let(:other_values) { [1,2,3] }

      it { is_expected.to satisfy { |v| v > other } }
      it { is_expected.to_not satisfy { |v| v == other } }
      it { is_expected.to_not satisfy { |v| v < other } }
    end


    context 'nth values' do
      let(:values) { [1,2,5] }
      let(:other_values) { [1,2,3] }

      it { is_expected.to satisfy { |v| v > other } }
      it { is_expected.to_not satisfy { |v| v == other } }
      it { is_expected.to_not satisfy { |v| v < other } }
    end

  end
end
