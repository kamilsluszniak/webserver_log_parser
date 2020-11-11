# frozen_string_literal: true

RSpec.describe WebserverLogParser::LogLinesParser do
  describe "call when arguments missing" do
    context "when file argument missing" do
      it "raises an ArgumentError exception" do
        expect{ described_class.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe "call" do
    subject { described_class.new(file: file) }

    context "when file exist and all lines contain path and addresses" do
      let(:file_path) { "spec/fixtures/files/logs.log" }
      let(:file) { File.open(file_path) }

      it "returns parsed lines array" do
        expect( subject.call ).to eq(
          [
            [
              "/help_page/1", "126.318.035.038"
            ],
            [
              "/contact", "184.123.665.067"
            ]
          ]
        )
      end
    end
  end
end