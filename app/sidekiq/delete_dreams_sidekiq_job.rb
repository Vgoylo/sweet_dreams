# frozen_string_literal: true

class DeleteDreamsSidekiqJob
  include Sidekiq::Job
  sidekiq_options queue: 'critical'

  def perform(current_user, start_at, until_at)
    user = User.find(current_user)
    puts "Hello #{user.name} Your delete dream"
    p user.dreams.where("created_at >= '#{start_at}' AND created_at <= '#{until_at}'")
  end
end

