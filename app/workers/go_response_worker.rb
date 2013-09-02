class GoResponseWorker
  include Sidekiq::Worker

  def perform(analysis_id)
    analysis = Analysis.find(analysis_id)
    analysis.complete!
  end
end