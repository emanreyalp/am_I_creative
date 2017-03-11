#!/bin/env ruby
# encoding: utf-8

require_relative "due_date"
require "test/unit"

class TestDueDate < Test::Unit::TestCase
  def test_simple
    res = DueDate.new(Time.local(2016,05,26,12,13)).add_time("0:50")
    exp = Time.local(2016,05,26,13,03)
    assert_equal(exp,res)
  end

  def test_so_simple
    res = DueDate.new(Time.local(2016,05,6,13,03))
    exp = Time.local(2016,05,6,13,03)
    assert_equal(exp,res.get_time)
  end
end
