# SO_reputation

A script that computes an approximation of the reputation gained by a StackOverflow user until a give date.
The script can be tried online at this [address](http://ugres.di.uniba.it:9090/StackOverflowClient/)

## Sequential version 

### Requirements  
*	Python 3	
	* PyMySQL version 0.7.9
	
### Usage
From comand line run:
```
python reputation.py
```

## Parallel version 

### Requirements
*	Java 8
	* Akka version 2.1.4
	* OpenCSV version 3.9

### Usage Akka-script
From comand line: 
```
java -jar Akka-script-final.jar [UserId1] [date1] (...[UserIdN] [dateN]) -1 
```
where:
* `UserIdX` is an integer representing a user id
* `dateX` is a string representing a date in the format YYYY-mm-dd

### Test Akka-script
From comand line:
```
java -jar Akka-script-test.jar [n] [date].
```
where:
* `n` is an integer representing the first n users in the dump
* `date` is a string representing a date in the format YYYY-mm-dd

## WebService version

###
API documentation is available here.

### Requirements
*	Java 8
	* OpenCSV version 3.9
	* Jersey version 1.17.1
	* Jackson version 1.9.10

 
