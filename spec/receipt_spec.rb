require 'receipt'

RSpec.describe Receipt do
  context "given an order" do
    it "calculates the total cost of the order with two decimal places" do
      dish_1 = double :dish1, name: "salad", price: 3.00
      dish_2 = double :dish2, name: "sushi", price: 9
      order = double :order, show: [dish_1, dish_2]
      receipt = Receipt.new
      expect(receipt.total(order)).to eq 12.00
    end

    it "prints a receipt of the order" do
      dish_1 = double :dish1, name: "salad", price: 3.00
      dish_2 = double :dish2, name: "sushi", price: 9.00
      order = double :order, show: [dish_1, dish_2]
      receipt = Receipt.new
      expect(receipt.print(order)).to eq [
      "Your receipt:",
      "* salad - £3.00",
      "* sushi - £9.00",
      "---------------",
      "Total: £12.00"].join("\n")
    end
  end

  context "given an empty order" do
    it "raises an error upon attempting to calculate total" do
      receipt = Receipt.new
      order = double :order, show: []
      expect {receipt.total(order) }.to raise_error "There is nothing on the order."
    end

    it "raises an error upon attempting to print" do
      receipt = Receipt.new
      order = double :order, show: []
      expect {receipt.print(order) }.to raise_error "There is nothing to print."
    end
  end
end