# frozen_string_literal: true

module Dreams
  class ShowPresenter < SimpleDelegator
    def initialize(dream)
      @dream = dream

      super(@dream)
    end

    def show_dream_title
      "This is length title < #{@dream.title.length} >"
    end

    def length_show_description
      @dream.description.first(100)
    end
  end
end
