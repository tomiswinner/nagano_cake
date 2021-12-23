class OrdersController < ApplicationController
  
  def new
    @order = Order.new()
  end
  
  def confirm
    @order = params[:order]
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
    
  end
  
  
  
end
