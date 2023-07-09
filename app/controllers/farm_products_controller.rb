class FarmProductsController < ApplicationController
  def index
    @farm = Farm.find(params[:farm_id])
    @products = @farm.products
  end

  def new
    @farm = Farm.find(params[:id])
  end
  
  def create
    farm = Farm.find(params[:id])
    product = farm.products.create!({
      name: params["Product Name"],
      fruit: params["Fruit"],
      seeds: params["Seeds"],
      cost_per_pound: params["Cost Per Pound"]
    })
    redirect_to "/farms/#{farm.id}/products"
  end
end