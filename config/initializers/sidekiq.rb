unless Rails.env.development?
  Sidekiq.configure_server do |config|
    config.redis = { :url => ENV['REDIS_PROVIDER'], :namespace => '' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { :url => ENV['REDIS_PROVIDER'], :namespace => '' }
  end
end