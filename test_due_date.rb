#!/bin/env ruby
# encoding: utf-8

require_relative 'due_date'
require 'test/unit'

class TestDueDate < Test::Unit::TestCase
  def test_initialize
    res = DueDate.new(Time.local(2016, 5, 6, 13, 3))
    exp = Time.local(2016, 5, 6, 13, 3)
    assert_equal(exp, res.time)
  end

  def test_add_minutes
    res = DueDate.new(Time.local(2016, 5, 26, 12, 13)).add_time!('0:40')
    exp = Time.local(2016, 5, 26, 12, 53)
    assert_equal(exp, res)
  end

  def test_add_hours
    res = DueDate.new(Time.local(2017, 3, 9, 15, 40)).add_time!('1:00')
    exp = DueDate.new(Time.local(2017, 3, 9, 16, 40)).time
    assert_equal(exp, res)
  end

  def test_add_a_work_day
    res = DueDate.new(Time.local(2017, 3, 9, 15, 40)).add_time!('8:00')
    exp = DueDate.new(Time.local(2017, 3, 10, 15, 40)).time
    assert_equal(exp, res)
  end

  def test_add_a_work_week
    res = DueDate.new(Time.local(2017, 3, 9, 15, 40)).add_time!('40:00')
    exp = DueDate.new(Time.local(2017, 3, 16, 15, 40)).time
    assert_equal(exp, res)
  end

  def test_hour_overflow_cause_of_the_minutes
    res = DueDate.new(Time.local(2017, 3, 9, 15, 40)).add_time!('0:30')
    exp = DueDate.new(Time.local(2017, 3, 9, 16, 10)).time
    assert_equal(exp, res)
  end

  def test_add_hours_and_minutes
    res = DueDate.new(Time.local(2017, 3, 9, 15, 40)).add_time!('1:10')
    exp = DueDate.new(Time.local(2017, 3, 9, 16, 50)).time
    assert_equal(exp, res)
  end

  def test_day_overflow_cause_of_the_minutes
    res = DueDate.new(Time.local(2017, 3, 9, 16, 40)).add_time!('0:30')
    exp = DueDate.new(Time.local(2017, 3, 10, 9, 10)).time
    assert_equal(exp, res)
  end

  def test_day_overflow_cause_of_the_hours
    res = DueDate.new(Time.local(2017, 3, 9, 16, 40)).add_time!('1:00')
    exp = DueDate.new(Time.local(2017, 3, 10, 9, 40)).time
    assert_equal(exp, res)
  end

  def test_day_overflow_cause_of_a_lot_of_hours
    res = DueDate.new(Time.local(2017, 3, 6, 13, 40)).add_time!('11:00')
    exp = DueDate.new(Time.local(2017, 3, 7, 16, 40)).time
    assert_equal(exp, res)
  end

  def test_add_two_week_of_hours
    res = DueDate.new(Time.local(2017, 3, 9, 16, 40)).add_time!('80:00')
    exp = DueDate.new(Time.local(2017, 3, 23, 16, 40)).time
    assert_equal(exp, res)
  end

  def test_add_two_week_of_hours_and_overflow_cause_of_the_minutes
    res = DueDate.new(Time.local(2017, 3, 9, 16, 40)).add_time!('80:30')
    exp = DueDate.new(Time.local(2017, 3, 24, 9, 10)).time
    assert_equal(exp, res)
  end

  def test_week_overflow_cause_of_the_hours
    res = DueDate.new(Time.local(2017, 3, 10, 15, 0)).add_time!('3:00')
    exp = DueDate.new(Time.local(2017, 3, 13, 10, 0)).time
    assert_equal(exp, res)
  end

  def test_daylight_saving_time_ending
    res = DueDate.new(Time.local(2017, 3, 24, 15, 0)).add_time!('3:00')
    exp = DueDate.new(Time.local(2017, 3, 27, 10, 0)).time
    assert_equal(exp, res)
  end

  def test_daylight_saving_time_starting
    res = DueDate.new(Time.local(2017, 10, 27, 15, 0)).add_time!('3:00')
    exp = DueDate.new(Time.local(2017, 10, 30, 10, 0)).time
    assert_equal(exp, res)
  end
end
