# noinspection RubyUnusedLocalVariable
class Checkout

  # +------+-------+----------------+
  # | Item | Price | Special offers |
  # +------+-------+----------------+
  # | A    | 50    | 3A for 130     |
  # | B    | 30    | 2B for 45      |
  # | C    | 20    |                |
  # | D    | 15    |                |
  # +------+-------+----------------+

  @price_lookup = {
    "A" => 50,
    "B" => 30,
    "C" => 20,
    "D" => 15
  }

  @discounts = {
    "A" => {quantity: 3, discount: 20},
    "B" => {quantity: 2, discount: 15},
    "C" => nil,
    "D" => nil,
  }

  class << self
    attr_accessor :price_lookup, :discounts
  end

  def price_for_item_quantity(item, quantity)
    base_price = self.class.price_lookup[item] * quantity

    applicable_discount = self.class.discounts[item]
    discount = applicable_discount ? applicable_discount[:discount] * (quantity / applicable_discount[:quantity]) : 0

    [base_price - discount, 0].max
  end

  def checkout(skus)
    raise 'Not implemented'
  end

end







