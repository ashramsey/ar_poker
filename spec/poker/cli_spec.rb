require 'spec_helper'

describe Poker::CLI do
  include CLIHelpers

  describe 'play' do
    let(:play) { subject.play winning_hand, losing_hand }
    let(:output) { capture(:stdout) { play } }

    it { expect(output).to eq winning_hand }


    describe 'game' do
      let(:game) { double(:game, winner: winning_hand, valid?: true) }

      it 'creates a game with the 2 hands' do
        expect(Poker::Game).to receive(:new).with(hands: [winning_hand, losing_hand]).and_return game

        play
      end


      it 'it returns the winner' do
        allow(Poker::Game).to receive(:new).and_return game

        expect(play).to eq winning_hand
      end
    end
  end


end
