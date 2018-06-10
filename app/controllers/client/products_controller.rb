class Client::ProductsController < ApplicationController

  def index
    product_params = {
      search: params[:search],
      sort_by_price: params[:sort_by_price]
    }
    @products = Unirest.get("http://localhost:3000/api/products", parameters: product_params).body
    render "index.html.erb"
  end

  def show
    product_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/products/#{product_id}")
    @product = response.body
    render "show.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    product_params = {
      name: params["name"],
      category: params["category"],
      price: params["price"],
      description: params["description"],
      color: params["color"]
    }
    response = Unirest.post("http://localhost:3000/api/products", parameters: product_params).body
    flash[:message] = "Product sucessfully created"
    redirect_to "/client/products/#{response['id']}"
  end

  def edit
    response = Unirest.get("http://localhost:3000/api/products/#{params[:id]}")
    @product = response.body
    render "edit.html.erb"
  end

  def update
    product_params = {
      name: params["name"],
      category: params["category"],
      price: params["price"],
      description: params["description"],
      color: params["color"],
      supplier_id: params["supplier_id"]
    }
    response = Unirest.patch("http://localhost:3000/api/products/#{params['id']}", parameters: product_params).body
    flash[:message] = "Proudct successfully updated"
    redirect_to "/client/products/#{response['id']}"
  end    

  def destroy
    product_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/products/#{product_id}")
    flash[:message] = "Product successfully deleted"
    redirect_to "/client/products"
  end


end
