# SO_reputation

## Sequential version 

### Requirements  
*	Python 3	
	* PyMySQL version 0.7.9
	
### Usage
From comand line digit python reputation.py

## Parallel version 

### Requirements
*	Java 8
	* Akka version 2.1.4
	* OpenCSV version 3.9

### Akka-script-final usage
From comand line: 
```
java -jar Akka-script-final.jar [UserId1] [date1] (...[UserIdN] [dateN]) -1 
```
where:
* `UserIdX` is an integer representing a user id
* `dateX` is a string representing a date in the format YYYY-mm-dd

### Akka-script-test usage
From comand line:
```
java -jar Akka-script-test.jar [n] [date].
```
where:
* `n` is an integer representing the first n users in the dump
* `date` is a string representing a date in the format YYYY-mm-dd

## WebService version

### Requirements
*	Java 8
	* OpenCSV version 3.9
	* Jersey version 1.17.1
	* Jackson version 1.9.10

 
