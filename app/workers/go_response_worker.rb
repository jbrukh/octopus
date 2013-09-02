class GoResponseWorker
  include Sidekiq::Worker

  def perform()
    puts 'received a response from the go worker'
  end
end