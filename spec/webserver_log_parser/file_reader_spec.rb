# frozen_string_literal: true

RSpec.describe WebserverLogParser::FileReader do
  describe "call when arguments missing" do
    context "when file_path argument missing" do
      it "raises an ArgumentError exception" do
        expect{ described_class.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe "call" do
    subject { described_class.new(file_path: file_path) }
    

    context "when the file doesn't exist" do
      let(:file_path) { "/some/path" }

      it "raises a FileNotFoundException exception" do
        expect{ subject.call }.to raise_error(WebserverLogParser::FileNotFoundException)
      end
    end

    context "when file exist" do
      let(:file_path) { "spec/fixtures/files/existing.file" }

      it "raises a FileNotFoundException exception" do
        expect( subject.call ).to be_instance_of(File)
      end
    end
  end
end