class DreamsController < ApplicationController
  def index
    @dreams = Note.all
  end
end
