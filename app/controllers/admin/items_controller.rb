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
  end
  
  def show
  end
  
  def update
  end
  
  private
  def item_params
    params.require(:item).permit(:genre_id,:name,:image,:introduction,:price,:is_active)
  end
  
end
