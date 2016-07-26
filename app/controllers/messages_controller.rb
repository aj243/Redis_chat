class MessagesController < ApplicationController
  before_action :authenticate_user!
  include ActionController::Live

  def index
    @messages = Message.all
  end

  def create
    response.headers["Content-Type"] = "text/javascript"
    @message = Message.create(message_params)
    $redis.publish('channel_1', @message.to_json)
    # $redis.publish('channel_1', @message.to_json)
  end
  
  def events
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    # redis.subscribe('channel_1', 'heartbeat') do |on|
    #   on.message do |event, data|
    #     p 'Subscribed to channel_1 and heartbeat'
    #     p "Message: #{data}"
    #     response.stream.write("event: #{event}\n")
    #     response.stream.write("event: #{data}\n\n")
    redis.subscribe('channel_1') do |on|
      on.message do |event, data|
        response.stream.write("event: #{event}\n")
        response.stream.write("data: #{data}\n\n")
        # binding.pry
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close
  end

  private

  def message_params
    params.require(:message).permit(:content, :name)
  end
end
