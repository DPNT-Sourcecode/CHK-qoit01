# noinspection RubyUnusedLocalVariable
class Checkout


  @price_lookup = {
    "A" => 50, "B" => 30, "C" => 20, "D" => 15, "E" => 40, "F" => 10,
    "G" => 20, "H" => 10, "I" => 35, "J" => 60, "K" => 70, "L" => 90,
    "M" => 15, "N" => 40, "O" => 10, "P" => 50, "Q" => 30, "R" => 50,
    "S" => 20, "T" => 20, "U" => 40, "V" => 50, "W" => 20, "X" => 17,
    "Y" => 20, "Z" => 21
  }

  @discounts = [
    { items: { "E" => 2, "B" => 1 }, discount: 30 },
    { items: { "N" => 3, "M" => 1 }, discount: 15 },
    { items: { "R" => 3, "Q" => 1 }, discount: 30 },

    { items: { "A" => 5 }, discount: 50 },
    { items: { "A" => 3 }, discount: 20 },
    { items: { "B" => 2 }, discount: 15 },
    { items: { "F" => 3 }, discount: 10 },
    { items: { "H" => 10 }, discount: 20 },
    { items: { "H" => 5 }, discount: 5 },
    { items: { "K" => 2 }, discount: 20 },
    { items: { "P" => 5 }, discount: 50 },
    { items: { "Q" => 3 }, discount: 10 },
    { items: { "U" => 4 }, discount: 40 },
    { items: { "V" => 3 }, discount: 20 },
    { items: { "V" => 2 }, discount: 10 },
  ]


  class << self
    attr_accessor :price_lookup, :discounts
  end

  def basket_discounts(sku_hash)
    sku_hash = sku_hash.clone
    total_discount = 0

    self.class.discounts.map do |discount|
      while discount[:items].all? { |sku, required_quantity| (sku_hash[sku] || 0) >= required_quantity }
        discount[:items].each { |sku, quantity| sku_hash[sku] -= quantity }
        total_discount += discount[:discount]
      end
    end

    # Group offers :'(
    total_group_items = %w[S T X Y Z].map { |sku| sku_hash[sku] }.sum
    


    # +------+-------+------------------------+
    # | Item | Price | Special offers         |
    # | S    | 20    | buy any 3 of (S,T,X,Y,Z) for 45 |
    # | T    | 20    | buy any 3 of (S,T,X,Y,Z) for 45 |
    # | X    | 17    | buy any 3 of (S,T,X,Y,Z) for 45 |
    # | Y    | 20    | buy any 3 of (S,T,X,Y,Z) for 45 |
    # | Z    | 21    | buy any 3 of (S,T,X,Y,Z) for 45 |



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




