class Client::CartedProductsController < ApplicationController

  def show
    carted_product_id = params[:id]
    @carted_product = Unirest.get("http://localhost:3000/api/carted_products/#{carted_product_id}").body
    render "show.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    cart_params = {
      product_id: params["product_id"],
      quantity: params[:quantity],
    }

    @carted_product = Unirest.post("http://localhost:3000/api/carted_products", parameters: cart_params).body
    flash[:message] = "Product added to cart"
    render 'show.html.erb'

  end


end
