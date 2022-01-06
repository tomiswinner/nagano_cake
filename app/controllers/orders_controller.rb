class OrdersController < ApplicationController
  
  before_action :is_cart_empty?, only: :new
  
  def new
    @order = Order.new()
  end
  
  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order = Order.new(order_params)
    
    if @order.payment.blank?
      flash.now[:alert] = "Error! You must select payment method"
      render :new
      return
    end
    
    if params[:order][:select_address] == "1"
      @order.address = current_customer.address
      @order.name = current_customer.full_name
      @order.postal_code = current_customer.postal_code
      
    elsif params[:order][:select_address] == "2"
      selected_address = Address.find(params[:order][:address_id])
      @order.address = selected_address.address
      @order.name = selected_address.name
      @order.postal_code = selected_address.postal_code
    
    elsif params[:order][:select_address] == "3"
      if @order.address.blank? || @order.name.blank? || @order.postal_code.blank?
        flash.now[:alert] = "Error! New address, name or postal_code is empty"
        render :new
      end
      
    end

    
  end
  
  def complete
  end
  
  def create
    @order = Order.create(order_params)
    @order.status = 0
    @cart_items = CartItem.where(customer_id: current_customer.id)
      
    Order.transaction do
      @cart_items.each do |cart_item|
        order_item = OrderItem.create(order_id: @order.id, item_id: cart_item.item_id,\
                                      amount: cart_item.amount,price: Item.find(cart_item.item_id).price, \
                                      status: OrderItem.statuses.keys[0])
        order_item.save!
        cart_item.destroy!
      end
      
      @order.save!
    end
      redirect_to complete_orders_path
  rescue => e
    err_msg = e
    
    flash[:alert] = err_msg
    redirect_to confirm_orders_path
    
  end
  
  def index
    @orders = Order.where(customer_id: current_customer.id).order("created_at DESC")
  end
  
  def show
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order.id)
  end
  
  private 
  def order_params
    params.require(:order).permit(:address, :name, :postal_code, :payment, :customer_id, :total_price, \
                                  :shipping_fee, :status)
  end
  
  def is_cart_empty?
    cart_items = CartItem.where(customer_id: current_customer.id)
    if cart_items.count == 0
      flash[:alert] = "Cart is empty"
      redirect_to cart_items_path
    end
      
  end
  
  
end
