# noinspection RubyUnusedLocalVariable
class Checkout

  @price_lookup = {
    "A" => 50,
    "B" => 30,
    "C" => 20,
    "D" => 15,
    "E" => 40,
    "F" => 10
  }

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



