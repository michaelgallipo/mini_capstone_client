class Client::ImagesController < ApplicationController

    def show
    image_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/images/#{image_id}")
    @image = response.body
    render "show.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    image_params = {
      url: params[:url],
      product_id: params["product_id"]
    }

    @image = Unirest.post("http://localhost:3000/api/images", parameters: image_params).body
    flash[:message] = "Image sucessfully added"
    redirect_to "/client/products/"
  end

end
