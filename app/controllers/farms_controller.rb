class FarmsController < ApplicationController
  
  def index
    @farms = Farm.order("created_at desc")
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
    @farm = Farm.find(params[:id])
    if @farm.pick_your_own == true
      @upick = "checked"
    else
      @upick = nil
    end
  end

  def update
    farm = Farm.find(params[:id])
    farm.update({
      name: params[:farm][:name],
      pick_your_own: (params[:farm][:pick_your_own] || false),
      acres: params[:farm][:acres]
    })
    farm.save
    redirect_to "/farms/#{farm.id}"
  end
end
