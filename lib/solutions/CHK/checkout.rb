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
    "A": 50,
    "B": 30,
    "C": 20,
    "D": 15
  }

  def price_for_item_quantity(item, quantity)
    {}

    @price_lookup[item] * quantity

  end

  def checkout(skus)
    raise 'Not implemented'
  end

end


