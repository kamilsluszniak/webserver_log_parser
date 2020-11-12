# frozen_string_literal: true

RSpec.describe WebserverLogParser::Processor do
  describe 'call' do
    context 'when file_path argument missing' do
      let(:unique_views) { false }
      subject { described_class.new(unique_views: unique_views) }

      it 'raises an ArgumentError exception' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when file_path argument is present' do
      subject { described_class.new(file_path: file_path, unique_views: unique_views) }

      let(:parsed_lines) do
        [
          ['/help_page/1', '126.318.035.038'],
          ['/contact', '184.123.665.067'],
          ['/contact', '184.123.665.067']
        ]
      end
      let(:file_path) { 'spec/fixtures/files/logs.log' }
      let(:log_file) { File.open(file_path, 'r') }
      let(:file_reader_instance) { instance_double(WebserverLogParser::FileReader) }
      let(:log_lines_parser_instance) {  instance_double(WebserverLogParser::LogLinesParser) }

      before do
        allow(file_reader_instance).to receive(:call).and_return(log_file)
        allow(log_lines_parser_instance).to receive(:call).and_return(parsed_lines)
        allow(WebserverLogParser::ParsedLinesAnalyzer).to receive(:new).and_return(lines_analyzer)
        allow(WebserverLogParser::UniqueParsedLinesAnalyzer).to receive(:new).and_return(lines_analyzer)
      end

      context 'when unique_views is false' do
        let(:unique_views) { false }
        let(:lines_analyzer) { instance_double(WebserverLogParser::ParsedLinesAnalyzer) }
        let(:analyzer_response) do
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

        it 'calls ParsedLinesAnalyzer', :aggregate_failures do
          expect(WebserverLogParser::FileReader).to receive(:new).with(file_path: file_path)
            .and_call_original
          expect(WebserverLogParser::LogLinesParser).to receive(:new).with(file: instance_of(File))
            .and_call_original
          expect(lines_analyzer).to receive(:call).and_return(analyzer_response)
          expect(subject.call).to eq(analyzer_response)
        end
      end

      context 'when unique_views is true' do
        let(:unique_views) { true }
        let(:lines_analyzer) { instance_double(WebserverLogParser::UniqueParsedLinesAnalyzer) }
        let(:analyzer_response) do
          [
            {
              path: '/help_page/1',
              count: 1
            },
            {
              path: '/contact',
              count: 1
            }
          ]
        end

        it 'calls ParsedLinesAnalyzer', :aggregate_failures do
          expect(WebserverLogParser::FileReader).to receive(:new).with(file_path: file_path)
          .and_call_original
          expect(WebserverLogParser::LogLinesParser).to receive(:new).with(file: instance_of(File))
            .and_call_original
          expect(lines_analyzer).to receive(:call).and_return(analyzer_response)
          expect(subject.call).to eq(analyzer_response)
        end
      end
    end
  end
end
