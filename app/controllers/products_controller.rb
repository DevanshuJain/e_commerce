class ProductsController < ApplicationController
	before_action :set_product, only: [:show, :edit, :update, :destroy]

	def index
	@product=Product.all
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
	end
	
	def new
		@product=Product.new
	end

	def create
      @product=Product.new(product_params)
	  @product.seller_id = current_seller.id
		 # @product.seller.id = current_seller.id
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
     params.require(:product).permit(:title, :description, :price, :quantity)    
   end

end


   # @product.seller_id = current_seller.id

