class Api::EventsController < ApplicationController
  include ActionController::Live

  def index
    response.headers['Content-Type'] = 'text/event-stream'

    redis = Redis.new :host => 'localhost', :port => 6379
    redis.subscribe('recording.updated') do |on|
      on.message do |event, data|
        logger.debug data
        response.stream.write(sse({data: data}, {event: 'recording.updated'}))
      end
    end

    rescue IOError
      # client disconnect
    ensure
    response.stream.close
  end

private
  def sse(object, options = {})
    (options.map{|k,v| "#{k}: #{v}" } << "data: #{JSON.dump object}").join("\n") + "\n\n"
  end
end
