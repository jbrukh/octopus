class Obf < BinData::Record
  endian :big

  int8    :data_type
  int8    :version
  int8    :storage_mode_raw
  int8    :channels
  uint32  :samples
  uint16  :sample_rate
  int8    :endianness

  int8    :reserved1
  int8    :reserved2
  int8    :reserved3
  int8    :reserved4
  int8    :reserved5
  int8    :reserved6
  int8    :reserved7
  int8    :reserved8
  int8    :reserved9
  int8    :reserved10
  int8    :reserved11
  int8    :reserved12
  int8    :reserved13
  int8    :reserved14
  int8    :reserved15
  int8    :reserved16
  int8    :reserved17
  int8    :reserved18
  int8    :reserved19
  int8    :reserved20

  array   :measurements,  :type => :double, :initial_length => -> () { samples * channels }
  array   :timestamps,    :type => :uint32, :initial_length => -> () { samples }

  def storage_mode
    case storage_mode_raw
    when 1
      :parallel
    when 2
      :sequential
    when 3
      :combined
    else
      raise "unknown storage mode: #{@data.storage_mode}"
    end
  end

  def duration_ms
    timestamps.last
  end
end