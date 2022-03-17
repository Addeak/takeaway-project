require './lib/dish'
require './lib/menu'
require './lib/order'
require './lib/receipt'

class Interface
  def initialize(menu)
    @menu = menu
    @order = Order.new(@menu)
    @receipt = Receipt.new
  end

  def show_menu
    puts "Please, take a look at our menu:"
    @menu.list.each_with_index do |dish, i|
      puts "#{i + 1}. #{dish.name} - £%.2f" % [dish.price]
    end
  end

  def add_to_order
    puts "Enter the number of an item you would like to order."
    input = gets.chomp
    until input == ""
      if input == "remove"
        remove_from_order
      end
      @order.select(@menu.list[input.to_i - 1])
      puts "Enter a number to order more items, 'remove' to remove items or just press enter to continue."
    input = gets.chomp
    end
  end

  def remove_from_order
    # takes user input to delete a dish from order
  end

  def request_number
    # asks user to enter phone number - checks it's valid - error if not
  end

  def print_receipt
    puts @receipt.print(@order)
  end

  def run

  end

end

burger = Dish.new("Burger", 7.49)
chips = Dish.new("Chips", 3.99)
coke = Dish.new("Coca-cola", 2.49)
menu = Menu.new
menu.add(burger)
menu.add(chips)
menu.add(coke)
int = Interface.new(menu)
int.show_menu
int.add_to_order
int.print_receipt