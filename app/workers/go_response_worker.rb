class GoResponseWorker
  include Sidekiq::Worker

  def perform(response_id)
    puts "received a response from the go worker: #{response_id}"
  end
end