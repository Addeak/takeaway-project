require 'menu'
require 'dish'
require 'order'
require 'receipt'

RSpec.describe "integration" do
  describe "menu-dish integration" do
    it "adds dishes to a menu" do
      burger = Dish.new("Burger", 7.49)
      chips = Dish.new("Chips", 3.99)
      coke = Dish.new("Coca-cola", 2.49)
      menu = Menu.new
      menu.add(burger)
      menu.add(chips)
      menu.add(coke)
      expect(menu.list).to eq [burger, chips, coke]
    end

    it "adds and removes dishes from the menu" do
      burger = Dish.new("Burger", 7.49)
      chips = Dish.new("Chips", 3.99)
      coke = Dish.new("Coca-cola", 2.49)
      menu = Menu.new
      menu.add(burger)
      menu.add(chips)
      menu.add(coke)
      menu.remove(chips)
      expect(menu.list).to eq [burger, coke]
    end
  end

  describe "order-menu-receipt integration" do
    it "provides a total cost when dishes are added to an order" do
      burger = Dish.new("Burger", 7.49)
      chips = Dish.new("Chips", 3.99)
      coke = Dish.new("Coca-cola", 2.49)
      menu = Menu.new
      menu.add(burger)
      menu.add(chips)
      menu.add(coke)
      order = Order.new(menu)
      order.select(burger)
      order.select(chips)
      receipt = Receipt.new
      expect(receipt.total(order)).to eq 11.48
    end

    it "provides a total cost when dishes are added and removed from an order" do
      burger = Dish.new("Burger", 7.49)
      chips = Dish.new("Chips", 3.99)
      coke = Dish.new("Coca-cola", 2.49)
      menu = Menu.new
      menu.add(burger)
      menu.add(chips)
      menu.add(coke)
      order = Order.new(menu)
      order.select(burger)
      order.select(chips)
      order.remove(chips)
      receipt = Receipt.new
      expect(receipt.total(order)).to eq 7.49
    end

    it "provides a receipt when dishes are ordered" do
      burger = Dish.new("Burger", 7.49)
      chips = Dish.new("Chips", 3.99)
      coke = Dish.new("Coca-cola", 2.49)
      menu = Menu.new
      menu.add(burger)
      menu.add(chips)
      menu.add(coke)
      order = Order.new(menu)
      order.select(burger)
      order.select(chips)
      order. select(coke)
      receipt = Receipt.new
      expect(receipt.print(order)).to eq [
      "Your receipt:",
      "* Burger - £7.49",
      "* Chips - £3.99",
      "* Coca-cola - £2.49",
      "---------------",
      "Total: £13.97"].join("\n")

    end

    it "provides a receipt when dishes have been ordered and some removed" do
      burger = Dish.new("Burger", 7.49)
      chips = Dish.new("Chips", 3.99)
      coke = Dish.new("Coca-cola", 2.49)
      menu = Menu.new
      menu.add(burger)
      menu.add(chips)
      menu.add(coke)
      order = Order.new(menu)
      order.select(burger)
      order.select(chips)
      order. remove(chips)
      receipt = Receipt.new
      expect(receipt.print(order)).to eq [
      "Your receipt:",
      "* Burger - £7.49",
      "---------------",
      "Total: £7.49"].join("\n")
    end
  end
end