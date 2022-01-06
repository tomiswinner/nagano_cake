class Admin::HomesController < ApplicationController
  
  def top
    @is_from_customer_show = !(params[:customer_id].nil?)
    if @is_from_customer_show
      @orders = Order.where(customer_id: params[:customer_id]).page(params[:page]).order('created_at DESC').per(8)
    else
      @orders = Order.page(params[:page]).order('created_at DESC').per(8)
   end   
  end
  
end
