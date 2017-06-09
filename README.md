# SO_reputation

A script that computes an approximation of the reputation gained by a Stack Overflow user up to a given date.

The script can be tested online at this [address](http://ugres.di.uniba.it:9090/StackOverflowClient/StackOverflowReputation.jsp) (**Be patient, it may take a few seconds**). Furthermore, you can use it as a web service in your own app. Check the [RESTful API documentation page](https://github.com/collab-uniba/SO_reputation/wiki/RESTful-API-Doc) for more.


**NOTE**: You will need to install [Git LFS](https://git-lfs.github.com) extension to check out this project.

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

## Fair Use Policy
Please, cite the following works if you intend to use our tool for your own research:
> F. Calefato, F. Lanubile, N. Novielli. “[Moving to Stack Overflow: Best-Answer Prediction in Legacy Developer Forums.](http://collab.di.uniba.it/fabio/wp-content/uploads/sites/5/2014/05/a13-calefato.pdf)” In *Proc. 10th Int’l Symposium on Empirical Softw. Eng. and Measurement (ESEM’16)*, Ciudad Real, Spain, Sept. 8-9, 2016, DOI:[10.1145/2961111.2962585](https://doi.org/10.1145/2961111.2962585).
```latex
@inproceedings{Calefato:2016:MSO:2961111.2962585,
 author = {Calefato, Fabio and Lanubile, Filippo and Novielli, Nicole},
 title = {Moving to Stack Overflow: Best-Answer Prediction in Legacy Developer Forums},
 booktitle = {Proc. 10th ACM/IEEE Int'l Symposium on Empirical Software Engineering and Measurement}, 
 series = {ESEM '16},
 year = {2016},
 isbn = {978-1-4503-4427-2},
 location = {Ciudad Real, Spain},
 pages = {13:1--13:10},
 articleno = {13},
 numpages = {10},
 url = {http://doi.acm.org/10.1145/2961111.2962585},
 doi = {10.1145/2961111.2962585},
 publisher = {ACM},
} 
```

>F. Calefato, F. Lanubile, M.C. Marasciulo, N. Novielli. MSR Challenge: “[Mining Successful Answers in Stack Overflow.](http://collab.di.uniba.it/fabio/wp-content/uploads/sites/5/2014/05/MSR_2015_calefato_et_al.pdf)” In *Proc. 12th IEEE Working Conf. on Mining Software Repositories (MSR 2015)*, Florence, Italy, May 16-17, 2015.
```latex
@inproceedings{Calefato:2015:MSA:2820518.2820579,
 author = {Calefato, Fabio and Lanubile, Filippo and Marasciulo, Maria Concetta and Novielli, Nicole},
 title = {Mining Successful Answers in Stack Overflow},
 booktitle = {Proc. 12th Working Conf. on Mining Software Repositories},
 series = {MSR '15},
 year = {2015},
 isbn = {978-0-7695-5594-2},
 location = {Florence, Italy},
 pages = {430--433},
 numpages = {4},
 url = {http://dl.acm.org/citation.cfm?id=2820518.2820579},
 publisher = {IEEE Press},
} 
```
## DB Setup
If you want to run your script locally or deploy the web service on your own server, you need to setup a MySQL database.
From this point forward, we assume that you have already imported the [SO dump](https://archive.org/download/stackexchange) to a local MySQL db (there are several scripts that you can easily adapt to your purpose; see [here](https://gist.github.com/megansquire/877e028504c92e94192d) and [here](https://gist.github.com/tundo91/1e074af39d90629252a7df3fc1066397), for example).

Then, go to the `db-setup/` folder and run in batch mode the sql script `setup.sql`:

**NOTE**: edit the first line of the .sql files to change the db name

```bash
shell> mysql -h host -u user -p < setup.sql
Enter password: ********

shell> mysql -h host -u user -p < csv.sql
Enter password: ********

**TODO** create script
shell>java -jar Ordinator_asc.jar Question_Answer.csv 2 MAX_USER_ID
shell> mv new_file.csv Question_Answer_2_asc.csv
shell>java -jar Ordinator_desc.jar Question_Answer.csv 2 MAX_USER_ID
shell> mv new_file.csv Question_Answer_2_desc.csv
shell>java -jar Ordinator_asc.jar Question_Answer.csv 4 MAX_USER_ID
shell> mv new_file.csv Question_Answer_4_asc.csv
shell>java -jar Ordinator_desc.jar Question_Answer.csv 4 MAX_USER_ID
shell> mv new_file.csv Question_Answer_4_desc.csv
shell>java -jar Ordinator_asc.jar Post_Votes?.csv 1 MAX_USER_ID
shell> mv new_file.csv Post_Votes?_asc.csv
shell>java -jar Ordinator_desc.jar Post_Votes?.csv 1 MAX_USER_ID
shell> mv new_file.csv Post_Votes?_desc.csv
```

This will create several table/views to speed up the querying process, plus some CSV files, named `Question_Answer_?_(asc|desc).csv` and `Posts_Votes?_(asc|desc).csv`. 

These CSV files are needed by the web service, therefore, whenever you create or update the SO database, you should copy/move them to the subfolder `webservice/StackOverflowRESTfulWebService/WebContent/WEB-INF` where you deployed the reputation web service.

## How to Run
The scripts referenced in this section must be edited prior to execution, in order to customize the following variables:
   * MySQL username
   * MySQL password
   * SO database name

#### Script: Sequential version 

##### Requirements  
*	Python 3	
	* PyMySQL version 0.7.9
	
##### Usage
From comand line run:
```
python reputation.py
```

#### Script: Parallel Version 
Need CSV files
##### Requirements
*	Java 8
	* Akka version 2.1.4
	* OpenCSV version 3.9

##### Usage Akka-script
From comand line: 
```
java -jar Akka-script-final.jar [UserId1] [date1] (...[UserIdN] [dateN]) -1 
```
where:
* `UserIdX` is an integer representing a user id
* `dateX` is a string representing a date in the format YYYY-mm-dd

##### Test Akka-script
From comand line:
```
java -jar Akka-script-test.jar [n] [date].
```
where:
* `n` is an integer representing the first n users in the dump
* `date` is a string representing a date in the format YYYY-mm-dd

#### Web Service

##### API
Documentation is available [here](https://github.com/collab-uniba/SO_reputation/wiki/RESTful-API-Doc).

##### Requirements
*	Java 8
	* OpenCSV version 3.9
	* Jersey version 1.17.1
	* Jackson version 1.9.10
*	Tomcat 8+

 
