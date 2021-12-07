class DreamsController < ApplicationController
  def index
    @dreams = Note.all
  end

  def show
    @dream = Note.find(params[:id])
  end
end
