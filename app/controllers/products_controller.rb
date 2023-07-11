class ProductsController < ApplicationController
  def index
    @products = Product.where(fruit: true).all
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    product = Product.find(params[:id])
    product.update({
      name: params["Name"],
      fruit: params["Fruit"],
      seeds: params["Seeds"],
      cost_per_pound: params["Cost Per Pound"]
    })
    product.save

    redirect_to "/products/#{product.id}"
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to "/products"
  end
end