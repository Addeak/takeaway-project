class Order
  def initialize(menu) 
    @order = []
  end

  def select(dish) 
    @order << dish
  end

  def remove(dish)
    fail "This dish is not on the order." unless @order.include?(dish)
    @order.delete_at(@order.index(dish))
  end

  def show
    @order
  end
end