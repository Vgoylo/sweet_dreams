class SendMessageNewDreamSidekiqJob
  include Sidekiq::Job

  def perform(user)
    puts "Hello #{user} Your created new dream"
  end
end