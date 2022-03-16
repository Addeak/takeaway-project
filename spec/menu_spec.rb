require 'menu'

RSpec.describe Menu do
  it "adds items to a menu" do
    dish = double :dish
    menu = Menu.new
    menu.add(dish)
    expect(menu.list).to eq [dish]
  end

  it "adds items to a menu" do
    dish_1 = double :dish_1
    dish_2 = double :dish_2
    dish_3 = double :dish_3
    menu = Menu.new
    menu.add(dish_1)
    menu.add(dish_2)
    menu.add(dish_3)
    expect(menu.list).to eq [dish_1, dish_2, dish_3]
  end

  it "adds and removes items from the list" do
    dish_1 = double :dish_1
    dish_2 = double :dish_2
    dish_3 = double :dish_3
    menu = Menu.new
    menu.add(dish_1)
    menu.add(dish_2)
    menu.add(dish_3)
    menu.remove(dish_2)
    expect(menu.list).to eq [dish_1, dish_3]
  end

  context "when removing a dish" do
    it "raises an error if dish does not exist on list" do
      dish_1 = double :dish_1
      dish_2 = double :dish_2
      dish_3 = double :dish_3
      menu = Menu.new
      menu.add(dish_1)
      menu.add(dish_3)
      expect { menu.remove(dish_2) }.to raise_error "This dish is not on the menu."
    end
  end

end