class Client::CartedProductsController < ApplicationController

  def index
    # product_params = {
    #   search: params[:search],
    #   sort_by_price: params[:sort_by_price]
    # }
    @carted_products = Unirest.get("http://localhost:3000/api/carted_products").body
    render "index.html.erb"
  end

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

    if @carted_product.code == 200
      flash[:message] = "Product added to cart"
      redirect_to "/client/carted_products/"
    else
      flash[:message] = "Must be logged in to place item in cart"
      redirect_to "/client/products/"
    end
  end

  def destroy
    carted_product_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/carted_products/#{carted_product_id}").body
    flash[:message] = "Successfully removed product from cart"
    redirect_to "/client/carted_products"
  end


end
