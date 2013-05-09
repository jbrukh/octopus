require 'spec_helper'

describe Octopus::OdfReader do
  describe '#read' do
    let(:file) {  File.new("#{Rails.root}/spec/fixtures/files/odf.data") }
    before :each do
      @reader = Octopus::OdfReader.new
    end
    it 'reads the odf file' do
      result = @reader.read(file)
      expect(result.data_type).to eq(1)
      expect(result.version).to eq(1)
      expect(result.storage_mode).to eq(1)
      expect(result.channels).to eq(2)
      expect(result.samples).to eq(960)
      expect(result.sample_rate).to eq(250)
    end
  end
end