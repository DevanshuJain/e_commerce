class CartsController < ApplicationController
  protect_from_forgery :except => [:callback, :index]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @carts = current_user.orders.last.carts
    @orders = current_user.orders.last
  end

  def show
    @product = @cart.product
  end

  def edit
    @product = @cart.product
  end
  
  def update
    @p = params['cart']['quantity']
    if @cart.update_columns(:quantity => @p )
      redirect_to carts_index_path
    end
  end

  def callback
    if params[:data][:object][:metadata][:Order]
      @order = Order.find(params[:data][:object][:metadata][:Order])
      @order.update_attributes(:status => :true)  
    end
  end
 
  def add_to_cart
    @q = 0
    @product = Product.find(params[:id])
    @order = current_user.orders.where(status: false).last
    if @order.nil?
      @order = current_user.orders.new
      @order.save

    end
    if @order.carts.exists?
      @order.carts.each do |c|
        if c.cart_product.product_id == @product.id
          c.increment! :quantity
          @a = @product.price*c.quantity
          c.update_attributes(:rate => @a)
          return
        end
      end
      add_cart()  
    else
      add_cart()  
    end
  end
  
  def destroy
    @cart.destroy
    redirect_to carts_url, notice: 'Remove product successfully.'
  end

  def add_cart
    @cart = @order.carts.new()
    @cart.quantity = 1
    @cart.rate = @product.price
    @cart.save
    @cart_product = CartProduct.new(product_id: @product.id, cart_id: @cart.id)
    @cart_product.save
    redirect_to products_path, notice: 'product add successfully.'
  end
  
  private
    def set_product
      @cart = Cart.find(params[:id])
    end

    # def cart_item_params
    #   params.permit(:product_id)
    # end
end


