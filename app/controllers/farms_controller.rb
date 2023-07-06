class FarmsController < ApplicationController
  has_many :products
  
  def index
    @farms = Farm.all
  end

  def show
    
  end
end
