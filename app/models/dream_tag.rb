# frozen_string_literal: true

class DreamTag < ApplicationRecord
  belongs_to :dream
  belongs_to :tag
end
