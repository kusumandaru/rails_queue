# frozen_string_literal: true

class UserPublisher
  QUEUE_NAME = 'user.create'

  def initialize(users)
    @users = users
  end

  def publish(options = {})
    channel = ::Publisher::BunnyPublisher.connection.create_channel
    exchange = channel.exchange(
      ENV['AMQP_EXCHANGE'],
      type: 'direct',
      durable: true
    )
    headers = { 'x-delay' => options[:delay_time].to_i * 1_000 } if options[:delay_time].present?
    exchange.publish(payload.to_json, routing_key: QUEUE_NAME, headers: headers)
  end

  private

  def payload
    {
      users: @users
    }
  end
end
