# frozen_string_literal: true

require 'spec_helper'

describe BaseReport do
  let(:base_report) { double(:base_report) }

  before { Timecop.freeze(Time.now) }

  after { Timecop.return }

  describe '#perform' do
    let(:game) { double(:game) }
    let(:games) { [game] }
    let(:report_content) { double(:report_content) }

    subject { described_class.perform(games) }

    before do
      allow(described_class).to receive(:new).and_return(base_report)
      allow(described_class).to receive(:report_content).and_return(report_content)
      allow(base_report).to receive(:export)
    end

    it 'calls report_content' do
      expect(described_class).to receive(:report_content).and_return([games])
      subject
    end

    it 'calls new with report_content' do
      expect(described_class).to receive(:new).with([report_content])
      subject
    end
  end

  describe '#report_content' do
    let(:game) { double(:game) }
    let(:games) { [game] }

    subject { described_class.perform(games) }

    it 'raises NotImplementedError' do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end

  describe '.export' do
    let(:report_content) { double(:report_content) }
    let(:report_name) { 'report_name' }
    let(:filename) { "#{report_name}-#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.json" }
    let(:path) { "reports_parsed/#{filename}" }

    subject { described_class.new(report_content).export }

    before do
      allow_any_instance_of(described_class).to receive(:report_name).and_return(report_name)
      allow(File).to receive(:open)
    end

    it 'creates new file' do
      expect(File).to receive(:open).with(path, 'w+')
      subject
    end

    it 'returns success message' do
      expect(subject).to eq("report #{filename} created! \nin: #{path}")
    end
  end

  describe '.report_name' do
    let(:report_content) { double(:report_content) }

    subject { described_class.new(report_content).report_name }

    it 'raises NotImplementedError' do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end
end
