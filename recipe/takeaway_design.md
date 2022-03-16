# {{PROBLEM}} Multi-Class Planned Design Recipe

## 1. Describe the Problem

_Put or write the user story here. Add any clarifying notes you might have._

As a customer
So that I can check if I want to order something
I would like to see a list of dishes with prices.

As a customer
So that I can order the meal I want
I would like to be able to select some number of several available dishes.

As a customer
So that I can verify that my order is correct
I would like to see an itemised receipt with a grand total.

As a customer
So that I am reassured that my order will be delivered on time
I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered.


## 2. Design the Class System

_Consider diagramming out the classes and their relationships. Take care to
focus on the details you see as important, not everything. The diagram below
uses asciiflow.com but you could also use excalidraw.com, draw.io, or miro.com_

```
┌────────────┐    ┌────────────┐
│            │    │            │
│  Menu      │    │  Dish      │
│ ────────── │    │  ───────   │    ┌────────────┐
│            │    │            │    │ Messenger  │
│ add(dish)  ├───►│  name      │    │ ─────────  │
│ remove     │    │            │    │            │
│ list       │    │  price     │    │ send       │
│            │    │            │    └────┬───────┘
└──────────▲─┘    └────────────┘         │
    ▲      │                      ┌──────▼─────────
    │      ├────────────┬─────────┤ Interface      │
    │      │            │         │ ─────────────  │
 ┌──┴──────▼─┐    ┌─────▼─────┐   │                │
 │           │    │           │   │ show_menu      │
 │  Order    │    │ Receipt   │   │                │
 │  ───────  │    ├────────   │   │ take_order     │
 │           │    │           │   │                │
 │  select   │ ◄──┤ total     │   │ request_number │
 │           │    │           │   │                │
 │  remove   │    │ print     │   │ print_receipt  │
 │           │    │           │   └────────────────┘
 └───────────┘    └────┬──────┘
                       │
                       ▼
               <!-- ┌───────────────────┐
               │                   │
               │ ReceiptFormatter  │
               │ ────────────────  │
               │                   │
               │  format           │
               │                   │
               └───────────────────┘ -->
```

_Also design the interface of each class in more detail._

```ruby

Dish = Struct.new(:name, :price) do
end

class Menu
  def initialize
  end

  def add(dish) # dish is an instance of Dish
    # adds a dish to the menu
    # returns nothing
  end

  def remove(dish) # dish is an instance of Dish
    # removes a dish from the menu
    #returns nothing
  end

  def list
    # returns the list of Dishes on the menu
  end
end

class Order
  def initialize(menu) # menu is an instance of Menu
    # empty list for order
  end

  def select(dish) # dish is an instance of Dish
    # adds a dish to the order
    # returns nothing
  end

  def remove(dish) # dish is an instance of Dish on the order
    # finds dish on order and removes it if it exists, otherwise raises an error
    # returns nothing
  end
end

class Receipt
  def initialize(order) # order is an instance of Order
  end
  
  def total
    # returns total price for the order
  end

  def print
    # returns a formatted version of the order including total
  end
end

# class ReceiptFormatter
#   def initialize(receipt)
#   end

#   def format
#     # returns a formatted receipt
#   end
# end

class Interface
  def initialize
  end

  def show_menu
    # displays menu to user and asks them to select dishes
  end

  def take_order
    # takes user input to store dishes in order
  end

  def request_number
    # asks user to enter phone number - checks it's valid - error if not
  end

  def print_receipt
    # displays itemised receipt to user
  end

class Messenger
  def initialize(number) # number is a phone number
  end

  def send
    # sends confirmation message via twilio to user
  end
end
```

## 3. Create Examples as Integration Tests

_Create examples of the classes being used together in different situations and
combinations that reflect the ways in which the system will be used._

```ruby
# 1

burger = Dish.new("Burger", 7.49)
chips = Dish.new("Chips", 3.99)
coke = Dish.new("Coca-cola", 2,49)
menu = Menu.new
menu.add(burger)
menu.add(chips)
menu.add(coke)
menu.list # => [burger, chips, coke] * as Dish instances *

# 2

burger = Dish.new("Burger", 7.49)
chips = Dish.new("Chips", 3.99)
coke = Dish.new("Coca-cola", 2,49)
menu = Menu.new
menu.add(burger)
menu.add(chips)
menu.add(coke)
menu.remove(chips)
menu.list # => [burger, coke] * as Dish instances *

# 3

burger = Dish.new("Burger", 7.49)
chips = Dish.new("Chips", 3.99)
coke = Dish.new("Coca-cola", 2,49)
menu = Menu.new
menu.add(burger)
menu.add(chips)
menu.add(coke)
order = Order.new(menu)
order.select(burger)
order.select(chips)
receipt = Receipt.new(order)
receipt.total # => 11.48

# 4

burger = Dish.new("Burger", 7.49)
chips = Dish.new("Chips", 3.99)
coke = Dish.new("Coca-cola", 2,49)
menu = Menu.new
menu.add(burger)
menu.add(chips)
menu.add(coke)
order = Order.new(menu)
order.select(burger)
order.select(chips)
order.remove(chips)
receipt = Receipt.new(order)
receipt.total # => 7.49

# 5

burger = Dish.new("Burger", 7.49)
chips = Dish.new("Chips", 3.99)
coke = Dish.new("Coca-cola", 2,49)
menu = Menu.new
menu.add(burger)
menu.add(chips)
menu.add(coke)
order = Order.new(menu)
order.select(burger)
order.select(chips)
order. select(coke)
receipt = Receipt.new(order)
receipt.print # => 
  # Your receipt:
  # - Burger - £7.49
  # - Chips - £3.99
  # - Coca-cola - £2.49
  # ---------------
  # Total: £13.97

# 6

burger = Dish.new("Burger", 7.49)
chips = Dish.new("Chips", 3.99)
coke = Dish.new("Coca-cola", 2,49)
menu = Menu.new
menu.add(burger)
menu.add(chips)
menu.add(coke)
order = Order.new(menu)
order.select(burger)
order.select(chips)
order. remove(chips)
receipt = Receipt.new(order)
receipt.print # => 
  # Your receipt:
  # - Burger - £7.49
  # ---------------
  # Total: £7.49
```

## 4. Create Examples as Unit Tests

_Create examples, where appropriate, of the behaviour of each relevant class at
a more granular level of detail._

```ruby
# EXAMPLE

# Constructs a track
track = Track.new("Carte Blanche", "Veracocha")
track.title # => "Carte Blanche"
```

_Encode each example as a test. You can add to the above list as you go._

## 5. Implement the Behaviour

_After each test you write, follow the test-driving process of red, green,
refactor to implement the behaviour._

