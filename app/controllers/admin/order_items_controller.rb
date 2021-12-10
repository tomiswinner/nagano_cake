class Admin::OrderItemsController < ApplicationController
  
  def update
    @order_item = OrderItem.find(params[:id])
    if @order_item.update(order_item_params)
      flash[:notice] = "Order Item #{Item.find(@order_item.item_id).name} status was successfully updated"
      redirect_to request.referer
    else
      err_msg = "error! Failed to update Order Item #{Item.find(@order_item.item_id).name} status\n"
      @order.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end
      flash[:alert] = err_msg
      render(template: "orders/show")
    end
  end
  
  private
  def order_item_params
    params.require(:order_item).permit(:status)
  end
end
