class CartsController < ApplicationController
  protect_from_forgery :except => [:callback, :index]

  def index
    @carts = current_user.orders.last.carts
    @orders = current_user.orders.last
  end

  def callback
    if params[:data][:object][:metadata][:Order]
      @order = Order.find(params[:data][:object][:metadata][:Order])
      @order.update_attributes(:status => :true)  
      redirect_to products_path, notice: 'product placed successfully.'
    end
  end
 
  def add_to_cart
    @flag = 0
    @product = Product.find(params[:id])
    if current_user.orders.exists?(status: false)
      @order = current_user.orders.where(status: false)
      @order = @order.first
    else    
      @order = current_user.orders.new
      @order.save
    end
    if @order.carts.exists?
      @order.carts.each do |c|
        if c.cart_product.product_id == @product.id
          c.increment! :quantity
          @a = @product.price*c.quantity
          c.update_attributes(:rate => @a)
          @flag = 1
          redirect_to products_path, notice: 'product add successfully.'
        end
      end
      if @flag == 0
        @cart = @order.carts.new()
        @cart.quantity = 1
        @cart.rate = @product.price
        @cart.save
        @cart_product = CartProduct.new(product_id: @product.id, cart_id: @cart.id)
        @cart_product.save

        redirect_to products_path, notice: 'product add successfully.'
      end
    else
      @cart = @order.carts.new()
      @cart.quantity = 1
      @cart.rate = @product.price        
      @cart.save
      @cart_product = CartProduct.new(product_id: @product.id, cart_id: @cart.id)
      @cart_product.save
      redirect_to products_path, notice: 'product add successfully.'
   end
  end
  
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to carts_url, notice: 'Remove product successfully.'
  end
  
  private
    def cart_item_params
      params.permit(:product_id)
    end
end


