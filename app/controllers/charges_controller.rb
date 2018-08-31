class ChargesController < ApplicationController
  def new
    @orders = current_user.orders.last
  end

  def create
    @orders = current_user.orders.last
    @q=0
    @amount=0
    if current_user.orders.exists?
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
    end
    redirect_to(products_url, :notice => 'Order was successfully Placed.')
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd',
      :metadata    => {Order: "#{@order.id}"}
    )
  rescue Stripe::CardError => e
    flash[:error] = e.message
  # @orders = current_user.orders.last
   # redirect_to new_charge_path
  end
end


