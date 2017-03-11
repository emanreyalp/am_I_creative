require_relative DueDateClass
reuire "test/unit"

class TestDueDate < Test::nit::TestCase
  def simple_test
    res = DueDate.new(Time.local(2016,05,26,12,13)).add_time("0:50")
    exp = Time.local(2016,05,6,13,03)
  end
end
