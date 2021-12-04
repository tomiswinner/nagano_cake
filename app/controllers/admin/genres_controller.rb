class Admin::GenresController < ApplicationController
  
  def index
    @genres = Genre.all
    @genre = Genre.new
    
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "Genre was successfully registerd"
      redirect_to admin_genres_path
    else
      err_msg = "error! Failed to register genre.\n"
      @genre.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end
      flash[:alert] = err_msg
      redirect_back(fallback_location: admin_genres_path)
    end
      
    
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "Genre was successfully updated"
      redirect_to(admin_genres_path)
    else
      err_msg = "error! Failed to update data\n"
      @genre.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end
      flash[:alert] = err_msg
      render :edit
    end
  end
  
  private
  def genre_params
    params.require(:genre).permit(:name)
  end
  
  
end
