#!/bin/bash
MYSQL_USER=root
MYSQL_PASS=5tartQu3ry1ng!
MYSQL_SO_DB=stackoverflow_march

echo "Creating tables and indexes (be patient, it does take a while...)"
mysql -u "$MYSQL_USER" --password="$MYSQL_PASS" --database="$MYSQL_SO_DB" < setup.sql

echo "Creating CSV files  (be patient, this also takes a while...)"
mysql -u "$MYSQL_USER" --password="$MYSQL_PASS" --database="$MYSQL_SO_DB" < csv.sql

MAX_USER_ID=$(mysql -u "$MYSQL_USER" --password="$MYSQL_PASS" --database="$MYSQL_SO_DB" -e "select max id from Users")


# Question_Answer_? the '?' is 2,4 

java -jar Ordinator_asc.jar Question_Answer.csv 2 "$MAX_USER_ID"
mv new_file.csv Question_Answer_2_asc.csv

java -jar Ordinator_desc.jar Question_Answer.csv 2 "$MAX_USER_ID"
mv new_file.csv Question_Answer_2_desc.csv

java -jar Ordinator_asc.jar Question_Answer.csv 4 "$MAX_USER_ID"
mv new_file.csv Question_Answer_4_asc.csv

java -jar Ordinator_desc.jar Question_Answer.csv 4 "$MAX_USER_ID"
mv new_file.csv Question_Answer_4_desc.csv

# Post_Votes? the '?' is 1-4
java -jar Ordinator_asc.jar Post_Votes1.csv 1 "$MAX_USER_ID"
mv new_file.csv Post_Votes1_asc.csv
java -jar Ordinator_asc.jar Post_Votes2.csv 1 "$MAX_USER_ID"
mv new_file.csv Post_Votes2_asc.csv
java -jar Ordinator_asc.jar Post_Votes3.csv 1 "$MAX_USER_ID"
mv new_file.csv Post_Votes3_asc.csv
java -jar Ordinator_asc.jar Post_Votes4.csv 1 "$MAX_USER_ID"
mv new_file.csv Post_Votes4_asc.csv

java -jar Ordinator_desc.jar Post_Votes1.csv 1 "$MAX_USER_ID"
mv new_file.csv Post_Votes1_desc.csv
java -jar Ordinator_desc.jar Post_Votes2.csv 1 "$MAX_USER_ID"
mv new_file.csv Post_Votes2_desc.csv
java -jar Ordinator_desc.jar Post_Votes3.csv 1 "$MAX_USER_ID"
mv new_file.csv Post_Votes3_desc.csv
java -jar Ordinator_desc.jar Post_Votes4.csv 1 "$MAX_USER_ID"
mv new_file.csv Post_Votes4_desc.csv

echo "done."