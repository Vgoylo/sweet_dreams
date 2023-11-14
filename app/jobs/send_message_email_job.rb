# frozen_string_literal: true
class SendMessageEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    puts "Hello #{user} this your profile. You can edit self profile"
  end
end
