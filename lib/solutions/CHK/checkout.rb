# noinspection RubyUnusedLocalVariable
class Checkout

  # +------+-------+------------------------+
  # | Item | Price | Special offers         |
  #   +------+-------+------------------------+
  # | A    | 50    | 3A for 130, 5A for 200 | x
  # | B    | 30    | 2B for 45              | x
  # | E    | 40    | 2E get one B free      | x
  # | F    | 10    | 2F get one F free      | x
  # | H    | 10    | 5H for 45, 10H for 80  | x
  # | K    | 80    | 2K for 150             | x
  # | N    | 40    | 3N get one M free      | x
  # | P    | 50    | 5P for 200             | x
  # | Q    | 30    | 3Q for 80              | x
  # | R    | 50    | 3R get one Q free      |
  # | U    | 40    | 3U get one U free      | x
  # | V    | 50    | 2V for 90, 3V for 130  | x
  # +------+-------+------------------------+

  @price_lookup = {
    "A" => 50, "B" => 30, "C" => 20, "D" => 15, "E" => 40, "F" => 10,
    "G" => 20, "H" => 10, "I" => 35, "J" => 60, "K" => 80, "L" => 90,
    "M" => 15, "N" => 40, "O" => 10, "P" => 50, "Q" => 30, "R" => 50,
    "S" => 30, "T" => 20, "U" => 40, "V" => 50, "W" => 20, "X" => 90,
    "Y" => 10, "Z" => 50
  }

  @discounts = [
    { items: ["E" => 2, "B" => 1], discount: 30 },
    { items: ["N" => 3, "M" => 1], discount: 15 },
    { items: ["R" => 3, "Q" => 1], discount: 30 },

    { items: ["A" => 5], discount: 50 },
    { items: ["A" => 3], discount: 20 },
    { items: ["B" => 2], discount: 15 },
    { items: ["F" => 3], discount: 10 },
    { items: ["H" => 10], discount: 20 },
    { items: ["H" => 5], discount: 5 },
    { items: ["K" => 2], discount: 10 },
    { items: ["P" => 5], discount: 50 },
    { items: ["Q" => 3], discount: 10 },
    { items: ["U" => 4], discount: 40 },
    { items: ["V" => 3], discount: 130 },
    { items: ["V" => 2], discount: 50 },
  ]

  class << self
    attr_accessor :price_lookup, :discounts
  end

  def basket_discounts(sku_hash)
    sku_hash = sku_hash.clone
    total_discount = 0

    self.class.discounts.map do |discount|
      while discount[:items].all? { |sku, required_quantity| sku_hash[:sku] >= required_quantity }

        total_discount += discount[:discount]

      end


    end


    if sku_hash["E"] && sku_hash["B"]
      max_b_to_remove = sku_hash["E"] / 2
      b_to_remove = [max_b_to_remove, sku_hash["B"]].min
      total_discount += b_to_remove * 30
      sku_hash["B"] -= b_to_remove
    end

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







