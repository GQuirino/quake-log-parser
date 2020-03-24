# frozen_string_literal: true

require 'spec_helper'

describe ReadGamesLogs do
  describe '#perform' do
    let(:file) { double(:file, readlines: file_lines) }
    let(:file_path) { 'file/path' }
    let(:player_1) { 'Player1' }
    let(:world) { '<world>' }
    let(:mean_kill) { 'MOD_ROCKET_SPLASH' }
    let(:file_lines) do
      [
        '789:12 ------------------------',
        ' 0:37 InitGame: -----',
        '20:38 ClientUserinfoChanged: n\\' + player_1 + '\t',
        " 212:12 Kill: 1022: #{world} killed #{player_1} by #{mean_kill}",
        '  20:40 InitGame: -----',
        '020:45 ClientConnect: 1'
      ]
    end
    let(:game) { double(:game, to_h: Hash) }

    before do
      allow(File).to receive(:open).and_call_original
      allow(File).to receive(:open).with(file_path).and_return(file)
      allow(Game).to receive(:new).and_return(game)
      allow(game).to receive(:add_player)
      allow(game).to receive(:add_kill)
    end

    subject { described_class.perform(file_path) }

    it 'converts Game to Hash' do
      expect(game).to receive(:to_h).twice
      subject
    end

    it 'calls Game with game_0' do
      expect(Game).to receive(:new).with('game_0')
      subject
    end

    it 'calls Game with game_1' do
      expect(Game).to receive(:new).with('game_1')
      subject
    end

    it 'adds player to game' do
      expect(game).to receive(:add_player).with(player_1)
      subject
    end

    it 'adds kill to game' do
      expect(game).to receive(:add_kill).with(world, player_1, mean_kill)
      subject
    end
  end
end
