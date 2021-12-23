class OrdersController < ApplicationController
  
  def new
    @order = Order.new()
  end
  
  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order = Order.create(order_params)
    
    
    if order_params[:select_address] == 1
      @order.address = current_customer.address
      @order.name = current_customer.full_name
      @order.postal_code = current_customer.postal_code
      
    elsif order_params[:select_address] == 2
      selected_address = Address.find(order_params[:address_id])
      @order.address = selected_address.address
      @order.name = selected_address.name
      @order.postal_code = selected_address.postal_code
    
    else
      @order.address = order_params[:address]
      @order.name = order_params[:name]
      @order.postal_code = order_params[:postal_code]
    
    end
    
  end
  
  def complete
  end
  
  def create
  end
  
  def index
  end
  
  def show
  end
  
  private 
  def order_params
    params.require(:order).permit(:address, :name, :select_address, :postal_code, :payment, :address_id)
  end
  
  
  
end
