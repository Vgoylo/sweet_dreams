# frozen_string_literal: true

module Dreams
  class Create < BaseService
    attr_reader :user, :params, :post_params

    def initialize(params, user, post_params = {})
      @params = params
      @user = user
      @post_params = post_params
    end

    def call
      @dream = Dream.new(params)
      @dream.user = user
      @dream.tag_ids = post_params[:tag_ids]
      SendMessageNewDreamSidekiqJob.set(wait: 1.minutes).perform_at(1.minutes, @dream.user.name)
      @dream.save!
      @dream
    rescue StandardError
      raise StandardError
    end
  end
end
