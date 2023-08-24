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
    "D" => 15,
    "E" => 40
  }

  class << self
    attr_accessor :price_lookup
  end

  def basket_discounts(sku_hash)
    total_discount = 0

    total_discount += 50 * (sku_hash["A"] / 5) if sku_hash["A"]
    total_discount += 20 * ((sku_hash["A"] % 5 ) / 3) if sku_hash["A"]
    total_discount += 15 * (sku_hash["B"] / 2) if sku_hash["B"]

    # puts total_discount

    total_discount
  end

  def checkout(skus)
    sku_hash = skus.split("").group_by { |sku| sku }.map { |sku, v| [sku, v.length] }.to_h

    if sku_hash.keys.all? { |sku| self.class.price_lookup.has_key?(sku) }
      base_price = sku_hash.map { |sku, quantity| self.class.price_lookup[sku] * quantity }.sum || 0
      discounts = basket_discounts(sku_hash)

      base_price - discounts
    else
      -1
    end
  end
end
