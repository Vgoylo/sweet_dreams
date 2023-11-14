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

      @user
    end
  end
end
