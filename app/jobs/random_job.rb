# frozen_string_literal: true

class RandomJob < ApplicationJob
  queue_as :default

  def perform(user)
    sleep(20.seconds)
    puts "Hello #{user} this is a random job"
  end
end
