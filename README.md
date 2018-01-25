# Due Date Calculator

### The problem: 

The program reads the currently reported problems (bugs) from an issue tracking system and calculates the due date following the rules below: 
Working hours are 9AM to 5PM every working day (Monday through Friday) 

The program does not deal with holidays, which means that a holiday on a Thursday is still considered as a working day by the program.
Also a working Saturday will still be considered as a nonworking day by the system.   
The turnaround time is given in working hours, which means for example that 2 days are 16 hours. 
As an example: if a problem was reported at 2:12PM on Tuesday then it is due by 2:12PM on Thursday.  

**A problem can only be reported during working hours, which means that all submit date values fall between 9AM and 5PM.**  

Your task is to implement the CalculateDueDate method, which takes the submit date and turnaround time as an input and returns the date and time when the issue is to be resolved.  
You can use the standard date time type or library that is part of the given language.
