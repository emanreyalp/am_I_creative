#!/bin/env ruby
# encoding: utf-8

require 'core_ext/time'

class DueDate
  END_OF_SHIFT = 17
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

    self
  end

  private

  def add_minutes(work_min)
    @time += work_min.minute
    check_overflow!
  end

  def add_hours(work_hour)
    if work_hour > WORKDAY_LENGTH
      days = work_hour / WORKDAY_LENGTH
      add_days(days)

      work_hour -= days * WORKDAY_LENGTH
    end

    @time += work_hour.hour
    check_overflow!
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
    HOURS_IN_DAY = 24
    @time += (HOURS_IN_DAY - WORKDAY_LENGTH).hour
  end

  def overflow_a_weekend
    DAYS_IN_WEEK = 7
    @time += (DAYS_IN_WEEK - WORKWEEK_LENGTH).day
  end

  def check_overflow!
    overflow_a_day if @time.hour >= END_OF_SHIFT
    overflow_a_weekend if @time.saturday?
  end
end
