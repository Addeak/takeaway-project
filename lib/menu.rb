class Menu
  def initialize
    @menu = []
  end

  def add(dish) 
    @menu << dish
  end

  def remove(dish) 
    fail "This dish is not on the menu." unless @menu.include?(dish)
    @menu.delete(dish)
  end

  def list
    @menu
  end
end