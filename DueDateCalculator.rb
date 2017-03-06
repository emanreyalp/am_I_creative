#!/bin/env ruby
# encoding: utf-8
def calculate_due_date (submitDate, turnaroundTime) # submitDate is a Time, turnaroundTime is a "hh:mm" string 
  ret = Time.new
  hour = turnaroundTime.split(':')[0].to_i
  min = turnaroundTime.split(':')[1].to_i

  ## hozzáadjuk a kapott perceket
    ret = submitDate + min*60 

    #puts turnaroundTime
    if hour > 8 ## napokra bontás
    ret += (hour/8) *24*60*60 ## órák lebontása napokra és a napok hozzáadása
    puts "+ " +(hour/8).to_s + "*16 hour"
    end
  ret += hour % 8 * 60*60  ## a maradék órák hozzáadása
  puts "+ " + (hour%8).to_s + " hour"
    if hour == 8 and min > 0 ## csak 1 nappal  esünk túl
      ret += 16*60*60 
      puts "+ 16 hour"
    end

    if hour > 40 
    weekend = hour/(8*5) ## 
    ret += weekend*2*24*60*60 ## hozzáadjuk a hétvége
    puts "+ " + weekend.to_s + "*48 hour"
  end
  if hour == 40 and min > 0
    ret += 2*24*60*60
    puts "+ 2 day"
  end
  ## eddig hozzáadtuk az átcsordult hétvégéket és napokat

  ## most megnézzük, hogy hova esett a végeredmény és annak fényében csordulunk túl
  begin
    isItOk = true
    
    wday = ret.wday

    if ret.hour > 17 or ret.hour < 9
      ret += 16*60*60
      puts "+ 16 hour"
        isItOk = false
      end
      if ret.hour == 17 and ret.min > 0
      ret += 16*60*60
      puts "+ 16 hour"
        isItOk = false  
      end
      
    # ha a ret hétvégére esik
    if (wday == 0 or wday.to_i == 6)
        puts "+ " + (wday%5 + 1).to_s + "*24 hour"
        ret += 60*60*24*(wday%5 + 1) 
        puts ret
        isItOk = false
      puts ret
    end
  end while !isItOk
  return ret
end
