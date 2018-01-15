#!/bin/env ruby
# encoding: utf-8

require 'core_ext/time'

class DueDate
  WORKDAY_LENGTH = 8
  WORKWEEK_LENGTH = 5

  attr_reader :time

  def initialize(submit_date)
    @time = submit_date
  end

  def add_time!(turnaround_time)
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
    if work_hour > WORKDAY_LENGTH
      days = work_hour / WORKDAY_LENGTH
      add_days(days)

      work_hour -= days * WORKDAY_LENGTH
    end

    @time += work_hour.hour
    check_overflow!
    @time
  end

  def add_days(work_day)
    if work_day >= WORKWEEK_LENGTH
      week = work_day / WORKWEEK_LENGTH
      add_weeks(week)

      work_day -= week * WORKWEEK_LENGTH
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
