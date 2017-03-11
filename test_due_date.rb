#!/bin/env ruby
# encoding: utf-8

require_relative "due_date"
require "test/unit"

class TestDueDate < Test::Unit::TestCase
  def test_initialize
    res = DueDate.new(Time.local(2016,05,6,13,03))
    exp = Time.local(2016,05,6,13,03)
    assert_equal(exp,res.get_time)
  end

  def test_add_minutes
    res = DueDate.new(Time.local(2016,05,26,12,13)).add_time("0:40")
    exp = Time.local(2016,05,26,12,53)
    assert_equal(exp, res)
  end

  def test_add_hours
    res = DueDate.new(Time.local(2017,3,9,15,40)).add_time("1:00")
    exp = Time.local(2017,3,9,16,40)
    assert_equal(exp, res)
  end

  def test_hour_overflow_cause_of_the_minutes
    res = DueDate.new(Time.local(2017,3,9,15,40)).add_time("0:30")
    exp = Time.local(2017,3,9,16,10)
    assert_equal(exp, res)
  end

  def test_add_hours_and_minutes
    res = DueDate.new(Time.local(2017,3,9,15,40)).add_time("1:10")
    exp = Time.local(2017,3,9,16,50)
    assert_equal(exp, res)
  end

  def test_day_overflow_cause_of_the_minutes
    res = DueDate.new(Time.local(2017,3,9,16,40)).add_time("0:30")
    exp = Time.local(2017,3,10,9,10)
    assert_equal(exp, res)
  end

  def test_day_overflow_cause_of_the_hours
    res = DueDate.new(Tiem.local(2017,3,9,16,40)).add_time("1:00")
    exp = Time.local(2017,3,10,9,40)
    assert_equal(exp, res)
  end
end
