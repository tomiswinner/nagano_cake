module ApplicationHelper
  
  def delimitate(price)
    return price.to_s(:delimited, delimiter: ",")
  end
  
end
