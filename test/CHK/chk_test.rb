require_relative '../test_helper'
require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout

require_solution 'CHK'

class ClientTest < Minitest::Test


  # +------+-------+----------------+
  # | Item | Price | Special offers |
  # +------+-------+----------------+
  # | A    | 50    | 3A for 130     |
  # | B    | 30    | 2B for 45      |
  # | C    | 20    |                |
  # | D    | 15    |                |
  # +------+-------+----------------+

  def test_price_for_item_quantity
    chk = Checkout.new

    assert_equal(50, chk.price_for_item_quantity("A", 1))
    assert_equal(100, chk.price_for_item_quantity("A", 2))
    assert_equal(130, chk.price_for_item_quantity("A", 3))
    assert_equal(130 + 130 + 50, chk.price_for_item_quantity("A", 7))
    assert_equal(30, chk.price_for_item_quantity("B", 1))
    assert_equal(45, chk.price_for_item_quantity("B", 2))
    assert_equal(45 + 30, chk.price_for_item_quantity("B", 3))
    assert_equal(20, chk.price_for_item_quantity("C", 1))
    assert_equal(40, chk.price_for_item_quantity("C", 2))
    assert_equal(15, chk.price_for_item_quantity("D", 1))
    assert_equal(30, chk.price_for_item_quantity("D", 2))
    # assert_equal(0, chk.price_for_item_quantity("D", -1))
  end

  def test_checkout_for_arithmetic
    chk = Checkout.new
    expected = chk.price_for_item_quantity("A", 2) + chk.price_for_item_quantity("B", 1)
    assert_equal(expected, chk.checkout("ABA"))
  end

  def test_checkout_for_unexpected_sku
    chk = Checkout.new
    expected = chk.price_for_item_quantity("A", 2)
    assert_equal(expected, chk.checkout("AFA"))
  end

  def test_checkout_for_empty_input
    chk = Checkout.new
    assert_equal(0, chk.checkout(""))
  end

end
