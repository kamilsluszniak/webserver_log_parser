# frozen_string_literal: true

RSpec.describe WebserverLogParser::ResultPrinter do
  describe 'call when arguments missing' do
    context 'when file argument missing' do
      it 'raises an ArgumentError exception' do
        expect { described_class.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'call' do
    subject { described_class.new(stats: stats) }

    context 'when provided with valid stats' do
      let(:stats) { [{ path: '/help_page/1', count: 1 }, { path: '/contact', count: 2 }] }

      it 'prints to stdout' do
        expect($stdout).to receive(:puts).with('Page views:')
        expect($stdout).to receive(:puts).with('/help_page/1: 1')
        expect($stdout).to receive(:puts).with('/contact: 2')
        subject.call
      end
    end
  end
end
