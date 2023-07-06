class FarmsController < ApplicationController
  def index
    @farms = Farm.all
  end

  def show
    
  end
end