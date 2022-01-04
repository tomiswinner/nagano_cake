class ItemsController < ApplicationController
  
  skip_before_action :authenticate_customer!
  
  def index
    @genres = Genre.all
    
    if params[:genre_id]
      @count = Item.where(genre_id: params[:genre_id]).count
      @items = Item.where(genre_id: params[:genre_id]).page(params[:page]).per(8)
      @title = Genre.find(params[:genre_id]).name
      
    elsif params[:searchword]
      @count = Item.where("name LIKE ?", "%#{params[:searchword]}%").count
      @items = Item.where("name LIKE ?", "%#{params[:searchword]}%").page(params[:page]).per(8)
      @title = "\"" + params[:searchword] + "\" での検索結果"
      
    else
      @count = Item.count
      @items = Item.page(params[:page]).per(8)
      @title = "商品"
      
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new()
  end
  
end
