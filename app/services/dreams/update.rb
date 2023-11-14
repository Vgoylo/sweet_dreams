# frozen_string_literal: true

module Dreams
  class Update < BaseService
    attr_accessor :dream
    attr_reader :user, :params, :post_params

    def initialize(dream:, params:, user:, post_params:)
      @params = params
      @user = user
      @post_params = post_params
      @dream = dream
    end

    def call
      dream.user = user
      dream.tag_ids = post_params[:tag_ids]
      dream.update!(params)
      dream
    rescue StandardError
      raise StandardError 'ggggg'
    end
  end
end
