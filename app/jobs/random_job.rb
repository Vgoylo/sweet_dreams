class RandomJob < ApplicationJob
  queue_as :default


  def perform(user_id, start_at, until_at)
    user = User.find(user_id)
    p user.dreams.where("created_at >= '#{start_at}' AND created_at <= '#{until_at}'")
  end
#   def perform(user)
#     sleep(20.seconds)
#     puts "Hello you changed status #{user} "
#   end
end
