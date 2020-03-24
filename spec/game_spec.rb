# frozen_string_literal: true

require 'spec_helper'

describe Game do
  subject { described_class.new(game_id) }

  describe '.add_player' do
    let(:game_id) { 'game_0' }
    let(:player_name) { 'Player 1' }

    before { subject.add_player(player_name) }

    it 'adds player to game' do
      expect(subject.players).to match_array([player_name])
    end
  end

  describe '.add_kill' do
    let(:game_id) { 'game_0' }
    let(:killer) { 'Player 1' }
    let(:killed) { 'Player 2' }
    let(:world) { '<world>' }
    let(:mean) { 'MOD_TRIGGER_HURT' }

    context 'when killer is <world>' do
      it 'decreases player kills' do
        expect do
          subject.add_kill(world, killer, mean)
        end.to change { subject.kills[killer] }.by(-1)
      end
    end

    context "when killer isn't <world>" do
      it 'increases player kills' do
        expect do
          subject.add_kill(killer, killed, mean)
        end.to change { subject.kills[killer] }.by(1)
      end
    end
  end

  describe '.to_h' do
    let(:game_id) { 'game_0' }
    let(:killer) { 'Player 1' }
    let(:killed) { 'Player 2' }
    let(:mean) { 'MOD_TRIGGER_HURT' }
    let(:game) { described_class.new(game_id) }

    subject { game.to_h }

    before do
      game.add_player(killer)
      game.add_kill(killer, killed, mean)
    end

    it 'converts game to hash' do
      expected = Hash[game_id, {
        total_kills: 1,
        players: [killer],
        kills: { killer => 1 },
        kills_by_means: { mean => 1 }
      }]

      is_expected.to match(expected)
    end
  end
end
