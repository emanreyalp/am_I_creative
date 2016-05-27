#!/bin/env ruby
# encoding: utf-8
def calculate_due_date (submitDate, turnaroundTime) # submitDate is a Time, turnaroundTime is a "hh:mm" string 
 	ret = Time.new
 	hour = turnaroundTime.split(':')[0].to_i
 	min = turnaroundTime.split(':')[1].to_i

	## hozz�adjuk a kapott perceket
  	ret = submitDate + min*60 

    #puts turnaroundTime
    if hour > 8 ## napokra bont�s
		ret += (hour/8) *24*60*60 ## �r�k lebont�sa napokra �s a napok hozz�ad�sa
		puts "+ " +(hour/8).to_s + "*16 hour"
    end
	ret += hour % 8 * 60*60  ## a marad�k �r�k hozz�ad�sa
	puts "+ " + (hour%8).to_s + " hour"
    if hour == 8 and min > 0 ## csak 1 nappal  es�nk t�l
    	ret += 16*60*60 
    	puts "+ 16 hour"
    end

    if hour > 40 
	 	weekend = hour/(8*5) ## 
	 	ret += weekend*2*24*60*60 ## hozz�adjuk a h�tv�ge
	 	puts "+ " + weekend.to_s + "*48 hour"
	end
	if hour == 40 and min > 0
		ret += 2*24*60*60
		puts "+ 2 day"
	end
	## eddig hozz�adtuk az �tcsordult h�tv�g�ket �s napokat

	## most megn�zz�k, hogy hova esett a v�geredm�ny �s annak f�ny�ben csordulunk t�l
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
	  	
		# ha a ret h�tv�g�re esik
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

##
## tests

ido = Time.new
#puts "+1�ra " + calculate_due_date(ido,"1:20").to_s;

#puts "201605261213 00:50 " + calculate_due_date(Time.local(2016,05,26,12,13),"00:50").to_s

#puts "201605261620 07:50 " + calculate_due_date(Time.local(2016,05,26,16,20),"07:50").to_s

#puts "201605261620 00:50 " + calculate_due_date(Time.local(2016,05,26,16,20),"00:50").to_s

#puts "201605261200 03:00 " + calculate_due_date(Time.local(2016,05,26,12,00),"03:00").to_s

## csordulunk napot - �ra miatt
#puts "201605261600 03:00 " + calculate_due_date(Time.local(2016,05,26,16,00),"03:00").to_s

## csordulunk hetet, napot - �ra miatt
#puts "201605271330 12:00 " + calculate_due_date(Time.local(2016,05,27,13,30),"12:00").to_s

## csordulunk hetet, napot - percmiatt
#puts "201605271330 03:40 " + calculate_due_date(Time.local(2016,05,27,13,30),"03:40").to_s

#puts "201605271330 45:49 " + calculate_due_date(Time.local(2016,05,27,13,30),"45:49").to_s

#puts "201605271630 40:50 " + calculate_due_date(Time.local(2016,05,27,16,30),"40:50").to_s

## end of test
#