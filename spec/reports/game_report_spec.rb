# frozen_string_literal: true

require 'spec_helper'

describe GameReport do
  describe '#report_content' do
    let(:game_id) { 'game_id' }
    let(:players) { ['player 1'] }
    let(:kills_by_means) { { 'MEAN' => 1 } }
    let(:game) do
      {
        game_id => {
          players: players,
          kills_by_means: kills_by_means
        }
      }
    end

    it 'rejects key :kills_by_means from game' do
      expected = {
        game_id => game[game_id].reject { |k| k == :kills_by_means }
      }
      expect(described_class.report_content(game)).to eq(expected)
    end
  end

  describe '.report_name' do
    let(:report_content) { double(:report_content) }

    subject { described_class.new(report_content).filename }

    it 'returns report name' do
      expect(subject).to include('game_report')
    end
  end
end
