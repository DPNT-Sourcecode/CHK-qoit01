require_relative '../test_helper'
require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout

require_solution 'CHK'

class ClientTest < Minitest::Test

  def test_price_for_item_quantity
    assert_equal(50, Sum.new.sum("A", 1))
  end

end
