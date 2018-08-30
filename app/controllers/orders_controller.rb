class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.where(status: true)
  end

  def placed_order
    @q=0
    @p=0
    if current_user.orders.exists?
      @order = current_user.orders.last
    end
    if @order.carts.exists?
      @order.carts.each do |c|
        @q = @q + c.quantity 
        @p = @p + c.rate
      end
      @order.total_quantity = @q
      @order.total_ammount = @p
      @order.save
      redirect_to carts_path
    end
  end
end
