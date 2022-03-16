class Order
  def initialize(menu) 
    @menu = menu
    @order = []
  end

  def select(dish) 
    @order << dish
  end

  def remove(dish)
    fail "This dish is not on the order." unless @order.include?(dish)
    @order.delete(dish)
  end

  def show
    @order
  end
end