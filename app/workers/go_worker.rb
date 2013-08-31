class GoWorker
  include Sidekiq::Worker

  sidekiq_options :queue => 'sentipus-queue'

  def perform()
    raise 'This should not be called...'
  end
end