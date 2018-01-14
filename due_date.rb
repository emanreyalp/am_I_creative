#!/bin/env ruby
# encoding: utf-8

require "core_ext/time"

class DueDate
  def initialize(submit_date)
    @submit_date = submit_date
    @time = submit_date
  end

  def add_time(turnaround_time)
    dst_before = @time.dst?

    hours = turnaround_time.split(':')[0].to_i
    mins = turnaround_time.split(':')[1].to_i

    add_minutes(mins)
    add_hours(hours)

    time?
  end

  def time?
    @time
  end

  private

  def add_minutes(work_min)
    @time += work_min.minute
    check_overflow!
    @time
  end

  def add_hours(work_hour)
    add_days(work_hour / 8)
    work_hour -= (work_hour / 8) * 8
    @time += work_hour.hour
    check_overflow!
    @time
  end

  def add_days(work_day)
    if work_day < 5
      @time += work_day.day
    else
      week = work_day / 5
      work_day -= week * 5
      @time += (week * 7 + work_day).day
    end
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
