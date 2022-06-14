class SendMessageNewDreamSidekiqJob
  include Sidekiq::Job
  sidekiq_options queue: 'low'

  def perform(user)
    puts "Hello #{user} Your created new dream"
  end
end