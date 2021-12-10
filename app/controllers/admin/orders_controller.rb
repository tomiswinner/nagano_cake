class Admin::OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order.id)
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "Order status was successfully updated"
      redirect_to request.referer
    else
      err_msg = "error! Failed to update status\n"
      @order.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end
      flash[:alert] = err_msg
      render :show
    end
    
  end
  
  private
  def order_params
    params.require(:order).permit(:status)
  end
end
