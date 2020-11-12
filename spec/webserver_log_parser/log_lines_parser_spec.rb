# frozen_string_literal: true

RSpec.describe WebserverLogParser::LogLinesParser do
  describe 'call' do
    context 'when file argument missing' do
      subject { described_class.new }

      it 'raises an ArgumentError exception' do
        expect { subject.new }.to raise_error(ArgumentError)
      end
    end

    context 'when file exists and all lines contain path and addresses' do
      subject { described_class.new(file: file) }

      let(:file) { File.open('spec/fixtures/files/logs.log') }

      it 'returns parsed lines array' do
        expect(subject.call).to eq(
          [
            [
              '/help_page/1', '126.318.035.038'
            ],
            [
              '/contact', '184.123.665.067'
            ]
          ]
        )
      end
    end
  end
end
