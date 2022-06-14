# frozen_string_literal: true

class SendMessageSidekiqJob
  include Sidekiq::Job

  def perform(user)
    puts "Hello #{user} Your edit self profile"
  end
end
