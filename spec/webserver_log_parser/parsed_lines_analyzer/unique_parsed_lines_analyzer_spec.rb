# frozen_string_literal: true

RSpec.describe WebserverLogParser::UniqueParsedLinesAnalyzer do


  describe "call" do
    subject { described_class.new(parsed_lines: parsed_lines) }

    context "when parsed lines are valid" do
      let(:parsed_lines) {
        [
          ["/help_page/1", "126.318.035.038"],
          ["/contact", "184.123.665.067"],
          ["/contact", "184.123.665.067"]
        ]
      }

      it "returns unique counted page hits" do
        expect( subject.call ).to eq(
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
        )
      end
    end
  end
end