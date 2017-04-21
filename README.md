# SO_reputation

A script that computes an approximation of the reputation gained by a StackOverflow user until a give date.

The script can be test online at this [address](http://ugres.di.uniba.it:9090/StackOverflowClient/StackOverflowReputation.jsp).

Furthermore, you can use our webservice in your own app. Check the [RESTful API documentation page](https://github.com/collab-uniba/SO_reputation/wiki/RESTful-API-Doc) for more.
*-- NOTE*: You will need to install [Git LFS](https://git-lfs.github.com) extension to check out this project.

## DISCLAIMER

The extracted reputation is only an estimate (with a ~10% error). The following rules are not considered:

*   _Suggested edit is accepted:_ +2 (up to +1000 total per user)
*   _Bounty awarded to your answer:_ + full bounty amount
*   _One of your answers is awarded a bounty automatically:_ + half of the bounty amount (see more details about how bounties work)
*   _Example you contributed to is voted up:_ +5
*   _Proposed change is approved:_ +2
*   _First time an answer that cites documentation you contributed to is upvoted:_ +5
*   _You place a bounty on a question:_ - full bounty amount
*   _One of your posts receives 6 spam or offensive flags:_ -100

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
API documentation is available [here](https://github.com/collab-uniba/SO_reputation/wiki/RESTful-API-Doc).

### Requirements
*	Java 8
	* OpenCSV version 3.9
	* Jersey version 1.17.1
	* Jackson version 1.9.10

 
