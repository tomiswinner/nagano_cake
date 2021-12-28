class ItemsController < ApplicationController
  def index
    if params[:genre_id]
      @items = Item.where(genre_id: params[:genre_id]).page(params[:page]).per(8)
      @genres = Genre.all
      @title = Genre.find(params[:genre_id]).name
    else
      @items = Item.page(params[:page]).per(8)
      @genres = Genre.all
      @title = "商品"
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new()
  end
  
end
