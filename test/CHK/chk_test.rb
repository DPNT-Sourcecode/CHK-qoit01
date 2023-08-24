require_relative '../test_helper'
require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout

require_solution 'CHK'

#noinspection RubyInstanceMethodNamingConvention
class ClientTest < Minitest::Test


  # +------+-------+------------------------+
  # | Item | Price | Special offers         |
  #   +------+-------+------------------------+
  # | A    | 50    | 3A for 130, 5A for 200 |
  # | B    | 30    | 2B for 45              |
  # | C    | 20    |                        |
  # | D    | 15    |                        |
  # | E    | 40    | 2E get one B free      |
  #                                 +------+-------+------------------------+


  def test_base_pricing
    chk = Checkout.new

    assert_equal(30, chk.checkout("B"))
    assert_equal(45, chk.checkout("BB"))
    assert_equal(45 + 30, chk.checkout("BBB"))
    assert_equal(20, chk.checkout("C"))
    assert_equal(40, chk.checkout("CC"))
    assert_equal(15, chk.checkout("D"))
    assert_equal(30, chk.checkout("DD"))
  end

  def test_discounts_for_A
    assert_equal(50, chk.checkout("A" * 1))
    assert_equal(100, chk.checkout("A" * 2))
    assert_equal(130, chk.checkout("A" * 3))
    assert_equal(130 + 50, chk.checkout("A" * 4))
    assert_equal(200, chk.checkout("A" * 5))
    assert_equal(250, chk.checkout("A" * 6))
    assert_equal(300, chk.checkout("A" * 7))
    assert_equal(330, chk.checkout("A" * 8))
    assert_equal(200 + 130 + 50, chk.checkout("A" * 9))
    assert_equal(400, chk.checkout("A" * 10))
  end

  def test_checkout_for_unusual_ordering
    chk = Checkout.new
    expected = chk.class.price_lookup["A"] * 2 + chk.class.price_lookup["B"] * 1
    assert_equal(expected, chk.checkout("ABA"))
  end

  def test_checkout_for_unexpected_sku
    chk = Checkout.new
    assert_equal(-1, chk.checkout("AXA"))
  end

  def test_checkout_for_empty_input
    chk = Checkout.new
    assert_equal(0, chk.checkout(""))
  end

end







