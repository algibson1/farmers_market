class FarmsController < ApplicationController
  
  def index
    @farms = Farm.all.reverse
  end

  def show
    @farm = Farm.find(params[:id])
  end
  
  def create
    
  end
end
