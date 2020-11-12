# frozen_string_literal: true

RSpec.describe WebserverLogParser::ResultPrinter do
  describe 'call' do
    context 'when file argument is missing' do
      subject { described_class.new(unique_views: false) }

      it 'raises an ArgumentError exception' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when stats argument present' do
      let(:stats) { [{ path: '/help_page/1', count: 1 }, { path: '/contact', count: 2 }] }

      context 'when unique_views is false' do
        subject { described_class.new(stats: stats, unique_views: false) }

        context 'when provided with valid stats' do
          let(:stats) { [{ path: '/help_page/1', count: 1 }, { path: '/contact', count: 2 }] }

          it 'prints to stdout', :aggregate_failures do
            expect($stdout).to receive(:puts).with('Page views:')
            expect($stdout).to receive(:puts).with('/help_page/1: 1')
            expect($stdout).to receive(:puts).with('/contact: 2')

            subject.call
          end
        end
      end

      context 'when unique_views is true' do
        subject { described_class.new(stats: stats, unique_views: true) }

        context 'when provided with valid stats' do
          let(:stats) { [{ path: '/help_page/1', count: 1 }, { path: '/contact', count: 2 }] }

          it 'prints to stdout', :aggregate_failures do
            expect($stdout).to receive(:puts).with('Page unique views:')
            expect($stdout).to receive(:puts).with('/help_page/1: 1')
            expect($stdout).to receive(:puts).with('/contact: 2')

            subject.call
          end
        end
      end
    end
  end
end
