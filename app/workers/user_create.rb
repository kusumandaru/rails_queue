# frozen_string_literal: true

class UserCreate
  include Sneakers::Worker

  QUEUE_NAME = ::UserPublisher::QUEUE_NAME
  from_queue QUEUE_NAME, arguments: { 'x-dead-letter-exchange': "#{QUEUE_NAME}-retry" }

  def work(msg)
    data = ActiveSupport::JSON.decode(msg)
    data['users'].each do |user|
      update_user(user.to_h)
    end
    ack!
  rescue StandardError => e
    create_log(false, data, message: e.message)
    reject!
  end

  private

  def update_user(user_hash)
    user = User.find_by(email: user_hash['email'].to_s)
    user.assign_attributes user_hash.slice('first_name', 'last_name')
    user.save!
  rescue StandardError => e
    create_log(false, user, message: e.message)
  end

  def create_log(success, payload, message = {})
    message = {
      success: success,
      payload: payload
    }.merge(message).to_json

    severity = success ? :info : :error
    Rails.logger.send(severity, message)
  end
end
