class Api::V1::StoresController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  DeviseTokenAuth::Concerns::User
  def stores
    @q = 0
    @product = Product.find(params[:product_id])
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
          # redirect_to products_path, notice: 'product add successfully.'
        end
      end
      @cart = @order.carts.new()
      @cart.quantity = 1
      @cart.rate = @product.price
      @cart.save
      @cart_product = CartProduct.new(product_id: @product.id, cart_id: @cart.id)
      @cart_product.save
      # redirect_to products_path, notice: 'product add successfully.'
    else
      @cart = @order.carts.new()
      @cart.quantity = 1
      @cart.rate = @product.price
      @cart.save
      @cart_product = CartProduct.new(product_id: @product.id, cart_id: @cart.id)
      @cart_product.save
      # redirect_to products_path, notice: 'product add successfully.'
    end
    render json: "product add"
  end

  def payment
    @orders = current_user.orders.last
    @q=0
    @amount=0
    if current_user.orders.where(status: false).last
      @order = current_user.orders.last
    end
    if @order.carts.exists?
      @order.carts.each do |c|
        @q = @q + c.quantity 
        @amount = @amount + c.rate
      end
      @order.total_quantity = @q
      @order.total_ammount = @amount
      @amount = @order.total_ammount
      @order.save

     cart = Stripe::Token.create(
    :card => {
      :number => "4242424242424242",
      :exp_month => 9,
      :exp_year => 2019,
      :cvc => "314"
      },
    )

    custmer = Stripe::Customer.create(
      :email => "djain@bestpeers.com",
    :source => cart['id'] 
    )

    charge = Stripe::Charge.create(
     :amount => "#{@order.total_ammount}",
     :currency => "usd",
     :source => "tok_mastercard", # obtained with Stripe.js
     :description => "Charge for jenny.rosen@example.com",
    )

    if current_user.orders.where(status: false).last
      @order = current_user.orders.last
      @order.update_attributes(:status => :true)  
      render json: "product payment successfully"    
    end
     end
  end


end