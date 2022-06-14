class SendMessageSidekiqJob
  include Sidekiq::Job
  sidekiq_options queue: 'low'
  
  def perform(user)
    puts "Hello #{user} Your edit self profile"
  end
end
