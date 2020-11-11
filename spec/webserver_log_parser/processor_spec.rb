# frozen_string_literal: true

RSpec.describe WebserverLogParser::Processor do
  subject { described_class.new(file_path: file_path, unique_views: unique_views) }

  describe "call when arguments missing" do
    context "when file argument missing" do
      it "raises an ArgumentError exception" do
        expect{ described_class.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe "call" do
    let(:parsed_lines) {
      [
        ["/help_page/1", "126.318.035.038"],
        ["/contact", "184.123.665.067"],
        ["/contact", "184.123.665.067"]
      ]
    }
    let(:log_file) { File.open(file_path, "r") }
    let(:file_path) { "spec/fixtures/files/logs.log" }

    before do
      allow_any_instance_of(WebserverLogParser::FileReader).to receive(:call).and_return(log_file)
      allow_any_instance_of(WebserverLogParser::LogLinesParser).to receive(:call).and_return(parsed_lines)
      allow(WebserverLogParser::ParsedLinesAnalyzer).to receive(:new).and_return(lines_analyzer)
    end


    context "when unique_views is false" do
      let(:unique_views) { false }
      let(:lines_analyzer) { instance_double(WebserverLogParser::ParsedLinesAnalyzer) }
      let(:analyzer_response) {
        [
          {
            path: "/help_page/1",
            count: 1
          },
          {
            path: "/contact",
            count: 2
          }
        ]
      }

      it "calls ParsedLinesAnalyzer" do
        expect(lines_analyzer).to receive(:call).and_return(analyzer_response)
        expect(subject.call).to eq(analyzer_response)
      end
    end

    context "when unique_views is true" do
      let(:unique_views) { true }
      let(:lines_analyzer) { instance_double(WebserverLogParser::UniqueParsedLinesAnalyzer) }
      let(:analyzer_response) {
        [
          {
            path: "/help_page/1",
            count: 1
          },
          {
            path: "/contact",
            count: 1
          }
        ]
      }

      it "calls ParsedLinesAnalyzer" do
        expect(lines_analyzer).to receive(:call).and_return(analyzer_response)
        expect(subject.call).to eq(analyzer_response)
      end
    end
  end
end