class Admin::ItemsController < ApplicationController
  
  def index
    @items = Item.page(params[:page])
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "New Item was successfully registerd!"
      redirect_to(admin_item_path(@item.id))
    else
      err_msg = "error! Failed to register item\n"
      @item.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end
      flash[:alert] = err_msg
      render(:new)
    end
      
      
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def show
    @item  = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "Item was successfully updated"
      redirect_to(admin_item_path(@item.id))
    else
      err_msg = "error! Failed to update data\n"
      @item.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end
      flash[:alert] = err_msg
      render :edit
    end
  end
  
  private
  def item_params
    params.require(:item).permit(:genre_id,:name,:image,:introduction,:price,:is_active)
  end
  
end
