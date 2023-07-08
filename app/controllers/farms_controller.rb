class FarmsController < ApplicationController
  
  def index
    @farms = Farm.all.reverse
  end

  def show
    @farm = Farm.find(params[:id])
  end

  def new

  end
  
  def create
    farm = Farm.new({
      name: params[:farm][:name],
      pick_your_own: (params[:farm][:pick_your_own] || false),
      acres: params[:farm][:acres]
    })
    farm.save
    redirect_to "/farms"
  end

  def edit
    
  end
end
