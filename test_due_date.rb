require_relative "due_date"
require "test/unit"

class TestDueDate < Test::Unit::TestCase
  def test_simple
    res = DueDate.new(Time.local(2016,05,26,12,13)).add_time("0:50")
    exp = Time.local(2016,05,6,13,03)
    assert_equal(exp,res)
  end
end
