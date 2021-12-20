class CustomersController < ApplicationController
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params) 
      flash[:notice] = "Your info was successfully updated"
      redirect_to customer_mypage_path
    else
      err_msg = "error! Failed to update data\n"
      @customer.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end
      flash[:alert] = err_msg
      render :edit
    end

    
  end
  
  def confirm
    @customer = current_customer
  end
  
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, \
                                     :postal_code, :address, :telephone_number, :email, :is_active)
  end
  
end
