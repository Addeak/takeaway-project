require 'order'

RSpec.describe Order do
  context "initially" do
    it "has an empty order" do
      menu = double :menu
      order = Order.new(menu)
      expect(order.show).to eq []
    end
  end

  it "adds dishes to the order" do
    dish_1 = double :dish_1
    dish_2 = double :dish_2
    menu = double :menu
    order = Order.new(menu)
    order.select(dish_1)
    order.select(dish_2)
    expect(order.show).to eq [dish_1, dish_2]
  end

  it "removes dishes from the order" do
    dish_1 = double :dish_1
    dish_2 = double :dish_2
    menu = double :menu
    order = Order.new(menu)
    order.select(dish_1)
    order.select(dish_2)
    order.remove(dish_1)
    expect(order.show).to eq [dish_2]
  end

  it "removes one dish from an order with duplicate dishes" do
    dish_1 = double :dish_1
    dish_2 = double :dish_2
    menu = double :menu
    order = Order.new(menu)
    order.select(dish_1)
    order.select(dish_1)
    order.remove(dish_1)
    expect(order.show).to eq [dish_1]
  end

  it "raises an error if dish is not on the order" do
    dish_1 = double :dish_1
    dish_2 = double :dish_2
    menu = double :menu
    order = Order.new(menu)
    expect { order.remove(dish_1) }.to raise_error "This dish is not on the order."
  end



end