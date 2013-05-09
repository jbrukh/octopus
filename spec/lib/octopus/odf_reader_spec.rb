require 'spec_helper'

describe Octopus::OdfReader do
  describe '#read' do
    let(:file) {  File.new("#{Rails.root}/spec/fixtures/files/odf.data") }
    it 'reads the odf file' do
      result = Octopus::OdfReader.read(file)
      
      expect(result.data_type).to eq(1)
      expect(result.version).to eq(1)
      expect(result.storage_mode).to eq(:parallel)
      expect(result.channels).to eq(2)
      expect(result.samples).to eq(960)
      expect(result.sample_rate).to eq(250)
      expect(result.duration_ms).to eq(3000)
    end
  end
end