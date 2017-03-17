#!/bin/env ruby
# encoding: utf-8

class DueDate
  def initialize(submit_date)
    @submit_date = submit_date
    @time = submit_date
  end

  def add_time(turnaround_time)
    hours = turnaround_time.split(':')[0].to_i
    mins = turnaround_time.split(':')[1].to_i

    @time = add_minutes(mins)
    @time = add_hours(hours)
    get_time
    return DueDate.new(@time).get_time
  end

  def get_time
    @time
  end

private

  def add_minutes(work_min)
    @time += work_min * minute_in_seconds
    if(@time.hour >= 17)
      overflow_a_day
    end
    @time
  end

  def add_hours(work_hour)
    add_days(work_hour / 8)
    work_hour -= (work_hour / 8) * 8
    @time += work_hour * hour_in_seconds
    if(@time.hour >= 17)
      overflow_a_day
    end
    @time
  end

  def add_days(work_day)
    if work_day < 5
      return @time += work_day * day_in_seconds
    else
      week = work_day/5
      work_day -= week*5
      return @time += (week*7 + work_day) * day_in_seconds
    end
  end

  def overflow_a_day
    @time += 16 * hour_in_seconds
  end

  def minute_in_seconds
    60
  end

  def hour_in_seconds
    60 * minute_in_seconds
  end

  def day_in_seconds
    24 * hour_in_seconds
  end
end
