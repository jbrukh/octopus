class ProcessResultWorker
  include Sidekiq::Worker

  def perform(id)
    puts "finding result by id #{id}"
    recording = Recording.find(id)

    puts 'fetching obf data'
    contents = Paperclip.io_adapters.for(recording.data).read
    obf = Obf.read(contents)

    puts 'updating recording'
    recording.update_from_obf!(obf)

    puts 'publishing recording updated'
    $redis.publish('recording.updated', recording.to_json)

  rescue ActiveRecord::RecordNotFound
    puts 'couldnt find recording, it was probably deleted'
  end
end