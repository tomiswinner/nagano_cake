class CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end
  
  def update
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy 
      flash[:notice] = "CartItem was successfully deleted"
      redirect_to cart_items_path
    else
      err_msg = "Error! Failed to delete\n"
      logger.debug flash[:alert]
      @cart_item.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end
      
      flash[:alert] = err_msg
      redirect_to cart_items_path
    end
    
  end
  
  def destroy_all
    @cart_items = CartItem.where(customer_id: current_customer.id)
    if @cart_items.destroy_all
      flash[:notice] = "Cart was all cleaned"
      redirect_to(cart_items_path)
    else
      err_msg = "error! Failed to delete data\n"
      @cart_items.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end
      flash[:alert] = err_msg
      redirect_to cart_items_path
    end  
  end
  
  def create
    
    @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item
      @cart_item.amount += params[:cart_item][:amount].to_i
      if @cart_item.update(amount: @cart_item.amount)
        flash[:notice] = "customer info was successfully updated"
        redirect_to(cart_items_path)
      else
        err_msg = "error! Failed to update data\n"
        @cart_item.errors.full_messages.each do |msg|
          err_msg += msg + "\n"
        end
        flash[:alert] = err_msg
        redirect_to item_path(@cart_item.item_id)
      end
    else
      @cart_item = CartItem.create(cart_item_params)
      if @cart_item.save
        flash[:notice] = "customer info was successfully updated"
        redirect_to(cart_items_path)
      else
        err_msg = "error! Failed to update data\n"
        @cart_item.errors.full_messages.each do |msg|
          err_msg += msg + "\n"
        end
        flash[:alert] = err_msg
        redirect_to item_path(@cart_item.item_id)
      end
    end
      
  end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :customer_id, :item_id)
  end
  
end
