class MessagesController < ApplicationController
  before_action :authenticate_user!
  include ActionController::Live

  def index
    @messages = Message.all
  end

  def create
    response.headers["Content-Type"] = "text/javascript"
    @message = Message.create(message_params)
    @message.name = current_user.name
    @message.save
    $redis.publish('channel_1', @message.to_json)
  end
  
  def events
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    # redis.subscribe('channel_1', 'heartbeat') do |on|
    redis.subscribe('channel_1') do |on|
      on.message do |event, data|
        response.stream.write("event: #{event}\n")
        response.stream.write("data: #{data}\n\n")
      end
    end
  rescue 
    IOError
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
