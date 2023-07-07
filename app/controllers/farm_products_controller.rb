class FarmProductsController < ApplicationController
  def index
    @farm = Farm.find(params[:farm_id])
    @products = @farm.products
  end
end