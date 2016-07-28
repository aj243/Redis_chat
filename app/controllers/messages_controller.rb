class MessagesController < ApplicationController
  before_action :authenticate_user!
  include ActionController::Live

  def index
    user = User.find_by_id(current_user.id)
    @messages = Message.where(channel: user.subscribed_channel[:channel])
  end

  def create
    response.headers["Content-Type"] = "text/javascript"
    @message = Message.create(message_params)
    @message.name = current_user.name
    @message.channel = "channel_#{current_user.id}"
    @message.save
    $redis.publish("channel_#{current_user.id}", @message.to_json)
  end
  
  def events
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    current_user.subscribed_channel[:channel].each do |channel|
      redis.subscribe("#{channel}", "channel_#{current_user.id}") do |on|
        on.message do |event, data|
          response.stream.write("event: #{event}\n")
          response.stream.write("data: #{data}\n\n")
        end
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
    params.require(:message).permit(:content, :name, :channel)
  end
end
