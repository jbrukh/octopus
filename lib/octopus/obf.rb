class Obf < BinData::Record
  endian :big

  int8    :data_type
  int8    :version
  int8    :storage_mode_raw
  int8    :channels
  uint32  :samples
  uint16  :sample_rate
  array   :measurements,  :type => :double, :initial_length => -> () { samples * channels }
  array   :timestamps,    :type => :uint64, :initial_length => -> () { samples }

  def storage_mode
    case storage_mode_raw
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