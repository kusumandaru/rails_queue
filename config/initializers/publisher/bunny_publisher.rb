# frozen_string_literal: true

module Publisher
  class BunnyPublisher
    def self.logger
      Rails.logger.tagged('bunny') do
        @logger ||= Rails.logger
      end
    end

    def self.connection
      @connection ||= begin
        instance = Bunny.new(
          addresses: ENV['AMQP_ADDRESSES'].try(:split, ','),
          username: ENV['AMQP_USER'],
          password: ENV['AMQP_PASSWORD'],
          vhost: ENV['AMQP_VHOST'],
          automatically_recover: true,
          connection_timeout: 2,
          continuation_timeout: (ENV['CONTINUATION_TIMEOUT'] || 10_000).to_i,
          logger: Rails.logger
        )
        instance.start

        instance
      end
    end
  end
end
