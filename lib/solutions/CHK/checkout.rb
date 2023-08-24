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
    "B" => {quantity: 2, discount: 5},
    "C" => nil,
    "D" => nil,
  }

  class << self
    attr_accessor :price_lookup, :discounts
  end

  def price_for_item_quantity(item, quantity)
    base_price = self.class.price_lookup[item] * quantity
    discounts = self.class.discounts[item]

    {}

    # self.class.price_lookup


  end

  def checkout(skus)
    raise 'Not implemented'
  end

end





