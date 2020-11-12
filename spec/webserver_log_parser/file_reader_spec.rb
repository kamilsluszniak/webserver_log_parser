# frozen_string_literal: true

RSpec.describe WebserverLogParser::FileReader do
  describe 'call' do
    context 'when file_path argument missing' do
      subject { described_class.new }

      it 'raises an ArgumentError exception' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when file_path argument present' do
      subject { described_class.new(file_path: file_path) }

      context "when the file doesn't exist" do
        let(:file_path) { '/some/path' }

        it 'raises a FileNotFoundException exception' do
          expect { subject.call }.to raise_error(WebserverLogParser::FileNotFoundException)
        end
      end

      context 'when file is in unaccepted format' do
        let(:file_path) { 'spec/fixtures/files/existing.file' }

        it 'raises an UnacceptedFileFormatException' do
          expect { subject.call }.to raise_error(WebserverLogParser::UnacceptedFileFormatException)
        end
      end

      context 'when the .txt file is empty' do
        let(:file_path) { 'spec/fixtures/files/empty.txt' }

        it 'raises a FileEmptyException exception' do
          expect { subject.call }.to raise_error(WebserverLogParser::FileEmptyException)
        end
      end

      context 'when the .log file is empty' do
        let(:file_path) { 'spec/fixtures/files/empty.log' }

        it 'raises a FileEmptyException exception' do
          expect { subject.call }.to raise_error(WebserverLogParser::FileEmptyException)
        end
      end

      context 'when a .txt file exists' do
        let(:file_path) { 'spec/fixtures/files/logs.txt' }

        it 'returns a file' do
          expect(subject.call).to be_instance_of(File)
        end
      end

      context 'when a .log file exists' do
        let(:file_path) { 'spec/fixtures/files/logs.log' }

        it 'returns a file' do
          expect(subject.call).to be_instance_of(File)
        end
      end
    end
  end
end
