class ProcessResultWorker
  include Sidekiq::Worker

  def perform(id)
    puts "finding result by id #{id}"
    result = Result.find(id)

    contents = Paperclip.io_adapters.for(result.data).read

    #dest = Tempfile.new(result.data_file_name)
    #dest.binmode
    #contents = result.data.copy_to_local_file(:original, dest.path).read

    obf = Obf.read(contents)
    puts "samples: #{obf.samples}/#{obf.storage_mode}"
  end
end