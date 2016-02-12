class TurnsController < ApplicationController
  def index
    @current_week = TurnBuilder.build(Calendar.new.build_week)
  end
end
