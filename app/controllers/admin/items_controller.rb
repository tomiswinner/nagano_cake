class Admin::ItemsController < ApplicationController
  
  def index
    @items = Item.page(params[:page])
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def show
  end
  
  def update
  end
  
end
