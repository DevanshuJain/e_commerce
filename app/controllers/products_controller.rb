class ProductsController < ApplicationController
	before_action :set_product, only: [:show, :edit, :update, :destroy]

	def index
	  @products = Product.all
	end

	def seller_product
    @products = current_seller.products
	end

	def show
	end

	def edit
	end

  def update
	  if @product.update_attributes(product_params)
      flash[:success] = "Task updated successfully"
      redirect_to products_path
    else
      render 'new'
    end
	end
	
	def destroy
    if @product.destroy
      redirect_to seller_product_path
    else
      render 'new'
    end  
	end
	
	def new
		@product = current_seller.products.new
	end

	def create
    @product = current_seller.products.new(product_params)
		if @product.save
      redirect_to new_product_path, note: 'product add successfully'
    else
  		render 'new'
	  end
  end


  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :quantity, :avatars)    
  end
end


  
