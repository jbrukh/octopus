module Octopus
  class OdfDataFile < BinData::Record
    endian :big

    int8    :data_type
    int8    :version
    int8    :storage_mode
    int8    :channels
    uint32  :samples
    uint16  :sample_rate
  end

  class Odf
    extend Forwardable

    attr_accessor :data

    def initialize(data)
      @data = data
    end

    def_delegators :@data, :data_type, :version, :channels, :samples, :sample_rate

    def storage_mode
      case @data.storage_mode
      when 1
        :parallel
      when 2
        :sequential
      else
        raise "unknown storage mode: #{@data.storage_mode}"
      end
    end

    def duration_ms
      (samples / sample_rate) * 1000
    end
  end

  class OdfReader
    def self.read(file)
      data_file = OdfDataFile.read(file)
      Odf.new(data_file)
    end
  end
end