
# frozen_string_literal: true

class GetsDreamsInTheIntervalSidekiqJob
  include Sidekiq::Job
  sidekiq_options queue: 'critical'

  def perform(user_id, start_at, until_at)
    user = User.find(user_id)
    p user.dreams.where("created_at >= '#{start_at}' AND created_at <= '#{until_at}'")
  end
end
