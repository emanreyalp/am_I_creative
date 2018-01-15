#!/bin/env ruby
# encoding: utf-8

require 'core_ext/time'

class DueDate
  attr_reader :time

  def initialize(submit_date)
    @time = submit_date
  end

  def add_time(turnaround_time)
    hours = turnaround_time.split(':')[0].to_i
    mins = turnaround_time.split(':')[1].to_i

    add_minutes(mins)
    add_hours(hours)

    @time
  end

  private

  def add_minutes(work_min)
    @time += work_min.minute
    check_overflow!
    @time
  end

  def add_hours(work_hour)
    if work_hour > 8
      days = work_hour / 8
      add_days(days)

      work_hour -= days * 8
    end

    @time += work_hour.hour
    check_overflow!
    @time
  end

  def add_days(work_day)
    if work_day >= 5
      week = work_day / 5
      add_weeks(week)

      work_day -= week * 5
    end

    @time += work_day.day
  end

  def add_weeks(work_week)
    @time += work_week.week
  end

  def overflow_a_day
    @time += 16.hour
  end

  def overflow_a_weekend
    @time += 2.day
  end

  def check_overflow!
    overflow_a_day if @time.hour >= 17
    overflow_a_weekend if @time.saturday?
  end
end
