module Octopus
  class OdfFile < BinData::Record
    endian :big

    int8    :data_type
    int8    :version
    int8    :storage_mode
    int8    :channels
    uint32  :samples
    uint16  :sample_rate
  end

  class OdfReader
    def read(file)
      OdfFile.read(file)
    end
  end
end