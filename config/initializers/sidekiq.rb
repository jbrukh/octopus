unless Rails.env.development?
  Sidekiq.configure_server do |config|
    config.redis = { :url => ENV['REDIS_PROVIDER'], :namespace => 'octopus' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { :url => ENV['REDIS_PROVIDER'], :namespace => 'octopus' }
  end
end