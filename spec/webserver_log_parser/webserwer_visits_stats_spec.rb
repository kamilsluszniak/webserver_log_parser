RSpec.describe WebserverLogParser::WebagesVisitsStats do
  subject { described_class.new(file_path: file_path, unique_views: unique_views) }

  describe "call when arguments missing" do
    context "when file argument missing" do
      it "raises an ArgumentError exception" do
        expect{ described_class.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe "call" do
    let(:processed_lines) {
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
    let(:sorted_processed_lines) {
      [
        {
          path: "/contact",
          count: 2
        },
        {
          path: "/help_page/1",
          count: 1
        }
      ]
    }
    let(:log_file) { File.open(file_path, "r") }
    let(:file_path) { "spec/fixtures/files/logs.log" }

    before do
      allow_any_instance_of(WebserverLogParser::Processor).to receive(:call).and_return(processed_lines)
    end


    context "when unique_views is false" do
      let(:unique_views) { false }

      it "calls ParsedLinesAnalyzer" do
        expect(WebserverLogParser::ResultPrinter).to receive(:new)
          .with(stats: sorted_processed_lines, unique_views: false)
        subject.call
      end
    end

    context "when unique_views is true" do
      let(:unique_views) { true }

      it "calls ParsedLinesAnalyzer" do
        expect(WebserverLogParser::ResultPrinter).to receive(:new)
          .with(stats: sorted_processed_lines, unique_views: true)
        subject.call
      end
    end
  end
end