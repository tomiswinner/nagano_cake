class Admin::OrdersController < ApplicationController
  
  
  def show
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order.id)
  end
  
  def update
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order.id)
    
    Order.transaction do
      @order.update!(order_params)
      
      # 入金確認済みにしたら、order_item のステータスも変更
      if @order.status == Order.statuses.keys[1]
        @order_items.each do |order_item|
          order_item.status = OrderItem.statuses.keys[1]
          order_item.save!
          
        end
      end
        
      flash[:notice] = "Order status was successfully updated"
      redirect_to request.referer
    end
      
  rescue
    flash[:alert] = "Some errors occured"
    render :show
    
  end
      
  
  private
  def order_params
    params.require(:order).permit(:status)
  end
  
end
