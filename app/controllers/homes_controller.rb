class HomesController < ApplicationController
  
  skip_before_action :authenticate_customer!
  
  def top
    @genres = Genre.all
    @items = Item.order("created_at DESC").limit(4)
  end
  
  def about
  end
  
end
