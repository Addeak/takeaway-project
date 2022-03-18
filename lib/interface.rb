require './lib/dish'
require './lib/menu'
require './lib/order'
require './lib/receipt'
require './lib/messenger'

class Interface
  def initialize(menu)
    @menu = menu
    @order = Order.new(@menu)
    @receipt = Receipt.new
  end

  def interactive_menu
    loop do
      puts "Please, select an option:\n1. See menu\n2. Order an item\n3. Remove an item from order\n4. View items ordered so far\n5. Place order and get receipt\n6. Exit"
      menu_process(gets.chomp)
    end
  end

  def menu_process(input)
    case input.to_i
    when 1
      show_dishes
    when 2
      add_to_order
    when 3
      remove_from_order
    when 4
      show_order
    when 5
      place_order
    when 6
      exit
    else
      puts "Please enter a number corresponding to one of the options."
    end
  end

  def show_dishes
    @menu.list.each_with_index do |dish, i|
      puts "#{i + 1}. #{dish.name} - £%.2f" % [dish.price]
    end
  end

  def add_to_order
    @order.select(@menu.list[approved_input.to_i - 1])
  end

  def remove_from_order
    @order.remove(@menu.list[approved_input.to_i - 1])
  end

  def approved_input
  input = ""
    until (1..@menu.list.length).include?(input.to_i)
      puts "Enter the number of an item on the menu."
    input = gets.chomp
    end
    input
  end

  def show_order
    return puts "Order is empty." if @order.show.empty?
    puts @receipt.print(@order)
  end

  def place_order
    number = request_number
    send_sms(number) unless number == ""
    print_receipt
  end

  def request_number
    puts "Enter your number if you would like a confirmation of your order via sms. If not, just hit enter."
    number = gets.chomp
  end

  def send_sms(number)
    send(number)
  end

  def print_receipt
    return puts "Order is empty." if @order.show.empty?
    puts "Your receipt:"
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
int.show_dishes
int.interactive_menu