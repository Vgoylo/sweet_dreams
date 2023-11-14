# frozen_string_literal: true

module Users
  class Show < BaseService
    attr_accessor :user

    def initialize(user)
      @user = user
    end

    def call
      @user = Users::ShowPresenter.new(user)
      SendMessageSidekiqJob.set(queue: :critical).perform_at(1.minutes, @user.name)
      GetsDreamsInTheIntervalSidekiqJob.perform_at(1.minutes, @user.id,
                                                Time.zone.parse('13-04-2022'),
                                                Time.zone.now)

      @user
    end
  end
end
