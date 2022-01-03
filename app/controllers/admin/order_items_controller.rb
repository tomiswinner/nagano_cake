class Admin::OrderItemsController < ApplicationController
  
  before_action :is_possible_update_order_item_status?
  after_action :update_order_status
  
  def update
    @order_item = OrderItem.find(params[:id])
    
    if @order_item.update(order_item_params)
      flash[:notice] = "Order Item #{Item.find(@order_item.item_id).name} status was successfully updated"
      redirect_to request.referer
      
    else
      err_msg = "error! Failed to update Order Item #{Item.find(@order_item.item_id).name} status\n"
      flash[:alert] = err_msg
      render(template: "orders/show")
      
    end
  end
  
  private
  def order_item_params
    params.require(:order_item).permit(:status)
  end
  
  def is_possible_update_order_item_status?
    order_item = OrderItem.find(params[:id])
    order = Order.find(order_item.order_id)
    
    # 入金待ち、発送準備中、発送済みなら order_item ステータスは更新不可にする。
    if order.status == Order.statuses.keys[0] || order.status == Order.statuses.keys[3] || order.status == Order.statuses.keys[4]
      flash[:alert] = "Error! Order status is #{order.status}"
      redirect_to request.referer
      
    end
    
  end
  
  def update_order_status
    order_item = OrderItem.find(params[:id])
    order = Order.find(order_item.order_id)
    
    # order_item ステータスが"製作中"へ更新 && order ステータスが 入金確認であれば
    # （はじめて order 内の order_item が製作中となったら）
    if order_item.status == OrderItem.statuses.keys[2] && order.status == Order.statuses.keys[1]
      order.status = Order.statuses.keys[2]
      order.save
      return
      
    end
    
    # order.status "製作中", かつ order_item.status がすべて "製作完了"なら
    if order.status == Order.statuses.keys[2] &&\
      OrderItem.where(order_id: order.id).pluck("status").all? {|status| status == OrderItem.statuses.keys[3]}
      order.status = Order.statuses.keys[3]
      order.save
      
    end
    
    
  end
  
end
