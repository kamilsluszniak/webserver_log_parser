# frozen_string_literal: true

RSpec.describe WebserverLogParser::WebagesVisitsStats do
  describe 'call' do
    context 'when file argument is missing' do
      subject { described_class.new(unique_views: false) }

      it 'raises an ArgumentError exception' do
        expect { described_class.new }.to raise_error(ArgumentError)
      end
    end

    context 'when file argument is present' do
      subject { described_class.new(file_path: file_path, unique_views: unique_views) }

      let(:processed_lines) do
        [
          {
            path: '/help_page/1',
            count: 1
          },
          {
            path: '/contact',
            count: 2
          }
        ]
      end
      let(:sorted_processed_lines) do
        [
          {
            path: '/contact',
            count: 2
          },
          {
            path: '/help_page/1',
            count: 1
          }
        ]
      end
      let(:log_file) { File.open(file_path, 'r') }
      let(:file_path) { 'spec/fixtures/files/logs.log' }

      before do
        allow_any_instance_of(WebserverLogParser::Processor).to receive(:call).and_return(processed_lines)
      end

      context 'when unique_views is false' do
        let(:unique_views) { false }

        it 'ResultPrinter with unique_views: false' do
          expect(WebserverLogParser::ResultPrinter).to receive(:new)
            .with(stats: sorted_processed_lines, unique_views: false)
            .and_call_original

          subject.call
        end
      end

      context 'when unique_views is true' do
        let(:unique_views) { true }

        it 'ResultPrinter with unique_views: true' do
          expect(WebserverLogParser::ResultPrinter).to receive(:new)
            .with(stats: sorted_processed_lines, unique_views: true)
            .and_call_original

          subject.call
        end
      end
    end
  end
end
