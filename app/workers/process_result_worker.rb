class ProcessResultWorker
  include Sidekiq::Worker

  def perform(id)
    puts "finding result by id #{id}"
    result = Result.find(id)

    puts 'fetching obf data'
    contents = Paperclip.io_adapters.for(result.data).read
    obf = Obf.read(contents)

    puts 'updating recording'
    result.recording.update_from_obf!(obf)

    puts 'publishing recording updated'
    $redis.publish('recording.updated', result.recording.to_json)

  rescue ActiveRecord::RecordNotFound
    puts 'couldnt find record, it was probably deleted'
  end
end