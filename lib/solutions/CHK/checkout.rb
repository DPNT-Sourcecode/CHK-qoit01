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
  # | F    | 10    | 2F get one F free      |
  # | G    | 20    |                        |
  # | H    | 10    | 5H for 45, 10H for 80  |
  # | I    | 35    |                        |
  # | J    | 60    |                        |
  # | K    | 80    | 2K for 150             |
  # | L    | 90    |                        |
  # | M    | 15    |                        |
  # | N    | 40    | 3N get one M free      |
  # | O    | 10    |                        |
  # | P    | 50    | 5P for 200             |
  # | Q    | 30    | 3Q for 80              |
  # | R    | 50    | 3R get one Q free      |
  # | S    | 30    |                        |
  # | T    | 20    |                        |
  # | U    | 40    | 3U get one U free      |
  # | V    | 50    | 2V for 90, 3V for 130  |
  # | W    | 20    |                        |
  # | X    | 90    |                        |
  # | Y    | 10    |                        |
  # | Z    | 50    |                        |
  # +------+-------+------------------------+

  @price_lookup = {
    "A" => 50, "B" => 30, "C" => 20, "D" => 15, "E" => 40, "F" => 10,
    "G" => 20, "H" => 10, "I" => 35, "J" => 60, "K" => 80, "L" => 90,
    "M" => 15, "N" => 40, "O" => 10, "P" => 50, "Q" => 30, "R" => 50,
    "S" => 30, "T" => 20, "U" => 40, "V" => 50, "W" => 20, "X" => 90,
    "Y" => 10, "Z" => 50
  }

  @discounts = [
    {}

  ]


  class << self
    attr_accessor :price_lookup
  end

  def basket_discounts(sku_hash)
    sku_hash = sku_hash.clone
    total_discount = 0

    if sku_hash["E"] && sku_hash["B"]
      max_b_to_remove = sku_hash["E"] / 2
      b_to_remove = [max_b_to_remove, sku_hash["B"]].min
      total_discount += b_to_remove * 30
      sku_hash["B"] -= b_to_remove
    end

    total_discount += 50 * (sku_hash["A"] / 5) if sku_hash["A"]
    total_discount += 20 * ((sku_hash["A"] % 5 ) / 3) if sku_hash["A"]
    total_discount += 15 * (sku_hash["B"] / 2) if sku_hash["B"]
    total_discount += 10 * (sku_hash["F"] / 3) if sku_hash["F"]
    total_discount += 20 * (sku_hash["H"] / 10) if sku_hash["H"]
    total_discount += 5 * ((sku_hash["H"] % 10 ) / 5) if sku_hash["H"]
    total_discount += 10 * (sku_hash["H"] / 2) if sku_hash["K"]
    total_discount += 50 * (sku_hash["P"] / 5) if sku_hash["P"]
    total_discount += 10 * (sku_hash["P"] / 3) if sku_hash["Q"]
    total_discount += 20 * (sku_hash["V"] / 3) if sku_hash["V"]
    total_discount += 10 * ((sku_hash["V"] % 3 ) / 2) if sku_hash["V"]

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





