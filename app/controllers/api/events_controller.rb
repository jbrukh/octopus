class Api::EventsController < ApplicationController
  include Tubesock::Hijack

  def index
    hijack do |tubesock|
      tubesock.onopen do
        tubesock.send_data message: "streaming"

        redis = Redis.new(:host => 'localhost', :port => 6379)
        redis.subscribe('recording.updated') do |on|
          on.message do |event, data|
            logger.debug data
            tubesock.send_data message: data
          end
        end
      end
    end
  end
end
