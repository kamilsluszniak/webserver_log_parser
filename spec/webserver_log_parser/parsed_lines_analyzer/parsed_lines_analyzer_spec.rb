# frozen_string_literal: true

RSpec.describe WebserverLogParser::ParsedLinesAnalyzer do
  describe 'call' do
    context 'when file argument is missing' do
      subject { described_class.new }

      it 'raises an ArgumentError exception' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when parsed_lines argument present' do
      subject { described_class.new(parsed_lines: parsed_lines) }

      context 'when parsed lines are valid' do
        let(:parsed_lines) do
          [
            ['/help_page/1', '126.318.035.038'],
            ['/contact', '184.123.665.067'],
            ['/contact', '184.123.665.067']
          ]
        end

        it 'returns counted page hits' do
          expect(subject.call).to eq(
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
          )
        end
      end

      context 'when parsed lines are empty' do
        let(:parsed_lines) { [] }

        it 'returns parsed lines array' do
          expect { subject.call }.to raise_error(WebserverLogParser::EmptyParsedLinesException)
        end
      end
    end
  end
end
