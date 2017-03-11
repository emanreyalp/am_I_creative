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

  def test_hour_overflow_cause_of_the_minutes
    res = DueDate.new(Time.local(2017,3,9,15,40)).add_time("0:30")
    exp = Time.local(2017,3,9,16,10)
    assert_equal(exp,res)
  end

  def test_add_hours_and_minutes
    res = DueDate.new(Time.local(2017,3,9,15,40)).add_time("1:10")
    exp = Time.local(2017,3,9,16,50)
    assert_equal(exp,res)
  end
end
