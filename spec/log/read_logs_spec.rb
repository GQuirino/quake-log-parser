require 'spec_helper'

describe ReadLogs do
  describe '#perform' do
    let(:file) { double(:file, readlines: file_lines) }
    let(:file_path) { 'file/path' }
    let(:file_lines) do
      [
        '789:12 ------------------------',
        ' 0:37 InitGame: -----',
        '20:38 ClientConnect: 2',
        ' 212:12 ------------------------',
        '  20:40 InitGame: -----',
        '020:45 ClientConnect: 1'
      ]
    end

    before do
      allow(File).to receive(:open).and_call_original
      allow(File).to receive(:open).with(file_path).and_return(file)
    end

    subject { described_class.perform(file_path) }

    it 'separates logs by games ids' do
      expect(subject.keys).to match_array(['game_1', 'game_2'])
    end

    it 'removes times from logs' do
      expected = {
        'game_1' => ['InitGame: -----', 'ClientConnect: 2'],
        'game_2' => ['InitGame: -----', 'ClientConnect: 1']
      }

      is_expected.to eq(expected)
    end
  end
end
