class RandomJob < ApplicationJob
  queue_as :default

  def perform(user)
    sleep(20.seconds)
    puts "Hello you changed status #{user} "
  end
end
