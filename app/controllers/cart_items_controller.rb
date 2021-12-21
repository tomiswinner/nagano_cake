class CartItemsController < ApplicationController
  def index
  end
  
  def update
  end
  
  def destroy
  end
  
  def destroy_all
  end
  
  def create
    @cart_item = CartItem.create(cart_items_params)
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
  
  private
  def cart_items_params
    params.require(:cart_item).permit(:amount, :customer_id, :item_id)
  end
  
end
