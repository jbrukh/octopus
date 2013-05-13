class ProcessResultWorker
  include Sidekiq::Worker

  def perform(id)
    puts "finding result by id #{id}"
    result = Result.find(id)

    contents = Paperclip.io_adapters.for(result.data).read
    obf = Obf.read(contents)

    result.recording.update_from_obf!(obf)
  end
end