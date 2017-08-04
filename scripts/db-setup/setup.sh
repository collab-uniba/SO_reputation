#!/bin/bash
MYSQL_USER=root
MYSQL_PASS=5tartQu3ry1ng!
MYSQL_SO_DB=stackoverflow_2016_01

echo "Creating tables and indexes (be patient, it does take a while...)"
mysql -u "$MYSQL_USER" --password="$MYSQL_PASS" --database="$MYSQL_SO_DB" < setup.sql

echo "Creating CSV files  (be patient, this also takes a while...)"
mysql -u "$MYSQL_USER" --password="$MYSQL_PASS" --database="$MYSQL_SO_DB" < csv.sql
mv /tmp/Users.csv .

MAX_USER_ID=$(mysql -u "$MYSQL_USER" --password="$MYSQL_PASS" --database="$MYSQL_SO_DB" -e "select max(Id) from Users;")
stringarray=($MAX_USER_ID)
MAX_USER_ID=${stringarray[1]}

echo "MAX_USER_ID=$MAX_USER_ID"

# Question_Answer_? the '?' is 2,4 
java -jar Ordinator_asc.jar /tmp/Question_Answer.csv 1 "$MAX_USER_ID"
mv new_file.csv Question_Answer_2_asc.csv
java -jar Ordinator_desc.jar /tmp/Question_Answer.csv 1 "$MAX_USER_ID"
mv new_file.csv Question_Answer_2_desc.csv
java -jar Ordinator_asc.jar /tmp/Question_Answer.csv 3 "$MAX_USER_ID"
mv new_file.csv Question_Answer_4_asc.csv
java -jar Ordinator_desc.jar /tmp/Question_Answer.csv 3 "$MAX_USER_ID"
mv new_file.csv Question_Answer_4_desc.csv

# Post_Votes? the '?' is 1-4
java -Xms5g -Xmx7g -jar Ordinator_asc.jar /tmp/Posts_Votes1.csv 0 "$MAX_USER_ID"
mv new_file.csv Posts_Votes1_asc.csv
java -Xms5g -Xmx7g -jar Ordinator_asc.jar /tmp/Posts_Votes2.csv 0 "$MAX_USER_ID"
mv new_file.csv Posts_Votes2_asc.csv
java -Xms5g -Xmx7g -jar Ordinator_asc.jar /tmp/Posts_Votes3.csv 0 "$MAX_USER_ID"
mv new_file.csv Posts_Votes3_asc.csv
java -Xms5g -Xmx7g -jar Ordinator_asc.jar /tmp/Posts_Votes4.csv 0 "$MAX_USER_ID"
mv new_file.csv Posts_Votes4_asc.csv

java -Xms5g -Xmx7g -jar Ordinator_desc.jar /tmp/Posts_Votes1.csv 0 "$MAX_USER_ID"
mv new_file.csv Posts_Votes1_desc.csv
java -Xms5g -Xmx7g -jar Ordinator_desc.jar /tmp/Posts_Votes2.csv 0 "$MAX_USER_ID"
mv new_file.csv Posts_Votes2_desc.csv
java -Xms5g -Xmx7g -jar Ordinator_desc.jar /tmp/Posts_Votes3.csv 0 "$MAX_USER_ID"
mv new_file.csv Posts_Votes3_desc.csv
java -Xms5g -Xmx7g -jar Ordinator_desc.jar /tmp/Posts_Votes4.csv 0 "$MAX_USER_ID"
mv new_file.csv Posts_Votes4_desc.csv

echo "done."
