#!/bin/env ruby
# encoding: utf-8

class DueDate
  def initialize(submit_date)
    @submit_date = submit_date
    @ret = submit_date

    return @ret
  end

  def add_time(turnaround_time)
    hours = turnaround_time.split(':')[0].to_i
    mins = turnaround_time.split(':')[1].to_i

    @ret = add_minutes(mins)
    @ret = add_hours(hours)
    return get_time
  end

  def add_minutes(min)
    @ret + min*60
  end

  def add_hours(hour)
    @ret + hour*60*60
  end

  def get_time
    return @ret
  end
end
