class FarmsController < ApplicationController
  def index
    Farm.all
  end
end