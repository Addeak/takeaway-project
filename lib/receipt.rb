class Receipt
  def initialize
  end
  
  def total(order)
    fail "There is nothing on the order." if order.show.empty?
    order.show.map { |dish| dish.price }.sum
  end

  def print(order)
    fail "There is nothing to print." if order.show.empty?
    format(order)
  end

  private

  def format(order)
    receipt = ""
    
    order.show.each do |dish|
      receipt += "* #{dish.name} - £%.2f\n" % [dish.price]
    end

    receipt += "---------------\nTotal: £%.2f" % [total(order)]
    receipt
  end
end