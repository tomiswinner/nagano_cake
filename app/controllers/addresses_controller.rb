class AddressesController < ApplicationController
  
  
  def index
    @address = Address.new()
    @addresses = Address.where(customer_id: current_customer.id)
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def create
    @address = Address.create(addresses_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice] = "Address was successfully registered"
      redirect_to addresses_path
    else
      err_msg = "Error! Failed to register\n"
      @address.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end
      
      flash[:alert] = err_msg
      redirect_to addresses_path
    end
      
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(addresses_params)
      flash[:notice] = "Address was successfully updated"
      redirect_to addresses_path
    else
      err_msg = "Error! Failed to update\n"
      @address.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end
      
      flash[:alert] = err_msg
      render :edit
    end
  end
  
  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
      flash[:notice] = "Address was successfully deleted"
      redirect_to addresses_path
    else
      err_msg = "Error! Failed to delete\n"
      @address.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end
      
      flash[:alert] = err_msg
      redirect_to addresses_path
    end
    
  end
  
  private
  def addresses_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
  
end
