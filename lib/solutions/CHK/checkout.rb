# noinspection RubyUnusedLocalVariable
class Checkout

  # +------+-------+------------------------+
  # | Item | Price | Special offers         |
  #   +------+-------+------------------------+
  # | A    | 50    | 3A for 130, 5A for 200 |
  # | B    | 30    | 2B for 45              |
  # | C    | 20    |                        |
  # | D    | 15    |                        |
  # | E    | 40    | 2E get one B free      |

  @price_lookup = {
    "A" => 50,
    "B" => 30,
    "C" => 20,
    "D" => 15
  }

  @discounts = {
    "A" => [{ quantity: 3, discount: 20 }],
    "B" => [{ quantity: 2, discount: 15 }],
    "C" => [],
    "D" => [],
  }

  class << self
    attr_accessor :price_lookup, :discounts
  end

  def basket_discounts(sku_hash)
    total_discount = 0

    total_discount += 20 * sku_hash["A"] / 3
    total_discount += 30 * sku_hash["B"] / 2

    # applicable_discount = self.class.discounts[item]
    # discount = applicable_discount ? applicable_discount[:discount] * (quantity / applicable_discount[:quantity]) : 0
    #
    # base_price - discount
    total_discount
  end

  def checkout(skus)
    sku_hash = skus.split("").group_by { |sku| sku }

    if sku_hash.keys.all? { |sku| self.class.price_lookup.has_key?(sku) }
      base_price = sku_hash.map { |sku, v| self.class.price_lookup[sku] * v.length }.sum || 0
      discounts = basket_discounts(sku_hash)

      base_price - discounts
    else
      -1
    end
  end

end




