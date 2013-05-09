require 'spec_helper'

describe Octopus::Obf do
  describe '#read' do
    let(:file) {  File.new("#{Rails.root}/spec/fixtures/files/obf.data") }
    it 'reads the obf file' do
      result = Octopus::Obf.read(file)

      expect(result.data_type).to eq(1)
      expect(result.version).to eq(1)
      expect(result.storage_mode).to eq(:parallel)
      expect(result.channels).to eq(2)
      expect(result.samples).to eq(688)
      expect(result.sample_rate).to eq(250)
      expect(result.duration_ms).to eq(2000)
      expect(result.measurements.length).to eq(688*2)
      expect(result.timestamps.length).to eq(688)
    end
  end
end