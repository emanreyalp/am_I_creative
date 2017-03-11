class DueDate
  def initialize(submit_date)
    @submit_date = submit_date
    @ret = submit_date
  end

  def add_time(turnaround_time)
    hours = turnaround_time.split(':')[0].to_i
    mins = turnaround_time.split(':')[1].to_i

    add_minutes(mins)
    add_hours(hours)
  end

  def add_minutes(min)

  end

  def add_hours(hour)

  end
end
