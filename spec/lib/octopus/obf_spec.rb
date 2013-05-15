require 'spec_helper'

describe Obf do
  describe '#read' do
    let(:file) { File.open("#{Rails.root}/spec/fixtures/files/obf.data") }
    it 'reads the obf file' do
      result = Obf.read(file)

      expect(result.data_type).to eq(1)
      expect(result.version).to eq(2)
      expect(result.storage_mode).to eq(:parallel)
      expect(result.channels).to eq(2)
      expect(result.samples).to eq(432)
      expect(result.sample_rate).to eq(250)
      expect(result.measurements.length).to eq(432*2)
      expect(result.timestamps.length).to eq(432)
      expect(result.duration_ms).to eq(1721)
    end
  end

  describe '#read with combined' do
    let(:file) { File.open("#{Rails.root}/spec/fixtures/files/obf_combined.data") }
    it 'reads the obf file' do
      result = Obf.read(file)

      expect(result.data_type).to eq(1)
      expect(result.version).to eq(2)
      expect(result.storage_mode).to eq(:combined)
      expect(result.channels).to eq(2)
      expect(result.samples).to eq(944)
      expect(result.sample_rate).to eq(250)
      expect(result.measurements.length).to eq(944*2)
      expect(result.timestamps.length).to eq(944)
      expect(result.duration_ms).to eq(3823)
    end
  end
end