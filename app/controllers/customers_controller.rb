class CustomersController < ApplicationController
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    
    if params[:is_deactivation?]
      @customer.update(is_active: false) 
      flash[:notice] = "Account is successfully deleted"
      sign_out_and_redirect(current_customer)
      
    else
      logger.debug "あじぇおｆ"
      logger.debug customer_params

      if @customer.update(customer_params) 
        flash[:notice] = "Data is successfully updated"
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
