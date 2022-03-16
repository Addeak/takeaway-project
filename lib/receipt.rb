class Receipt
  def initialize
  end
  
  def total(order)
    order.show.map { |dish| dish.price }.sum
  end

  def print(order)
    dishes = order.show
    format(dishes)
  end

  private

  def format(dishes)
    "Your receipt:\n- #{"
  end
end