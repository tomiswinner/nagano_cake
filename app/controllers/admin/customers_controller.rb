class Admin::CustomersController < ApplicationController
  
  def index
    @customers = Customer.order("created_at DESC").page(params[:page])
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "customer info was successfully updated"
      redirect_to(admin_customer_path(@customer.id))
    else
      err_msg = "error! Failed to update data\n"
      @customer.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end
      flash[:alert] = err_msg
      render :edit
    end
      
    
  end
  
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, \
                                     :address, :telephone_number, :email, :is_active)
  end
  
end

