import pymysql # library to access MySQL
import datetime # library to manage date

# RULES:
# Votes for posts marked “community wiki” do not generate any reputation
# You can earn a maximum of 200 reputation per day
# Bounty awards, accepted answers, and association bonuses are not subject to the daily reputation limit

# You gain reputation when:
#   - question is voted up: +5
#   - answer is voted up: +10
#   - answer is marked “accepted”: +15 (+2 to acceptor)
#   - suggested edit is accepted: +2 (up to +1000 total per user)
#   - bounty awarded to your answer: + full bounty amount
#   - one of your answers is awarded a bounty automatically: + half of the bounty amount (see more details about how bounties work)
#   - site association bonus: +100 on each site (awarded a maximum of one time per site)
#   - example you contributed to is voted up: +5
#   - proposed change is approved: +2
#   - first time an answer that cites documentation you contributed to is upvoted: +5

# If you are an experienced Stack Exchange network user with 200 or more reputation on at least one site,
# you will receive a starting +100 reputation bonus to get you past basic new user restrictions.
# This will happen automatically on all current Stack Exchange sites where you have an account, and on any other Stack Exchange sites at the time you log in.

# You lose reputation when:
#   - your question is voted down: −2
#   - your answer is voted down: −2
#   - you vote down an answer: −1
#   - you place a bounty on a question: − full bounty amount
#   - one of your posts receives 6 spam or offensive flags: −100

# All users start with one reputation point, and reputation can never drop below 1
# Accepting your own answer does not increase your reputation
# Deleted posts do not affect reputation, for voters, authors or anyone else involved, in most cases
# If a user reverses a vote, the corresponding reputation loss or gain will be reversed as well
# Vote reversal as a result of voting fraud will also return lost or gained reputation

def RepresentsInt(s):
    try:
        int(s)
        return True
    except ValueError:
        return False

database_name = "stackoverflow_march" 

badges_table = "Badges"
comments_table = "Comments"
post_history_table = "PostHistory"
post_links_table = "PostLinks"
posts_table = "Posts"
tags_table = "Tags"
users_table = "Users"
votes_table = "Votes"

conn = pymysql.connect(host='localhost', user='root', password='5tartQu3ry1ng!') # create a connection to MySQL with arguments: host, username and password
main_cursor = conn.cursor() # create a cursor to execute query
main_cursor.execute("use " + database_name) # access to database

ris = []

while True:
    user_name = input("Insert user name and press Enter: ")
    main_cursor.execute("select Id from " + users_table + "  where DisplayName = '" + user_name + "'")
    x = main_cursor.fetchone()
    while x != None:
        x = int(x[0])
        ris.append(x)
        x = main_cursor.fetchone()

    if len(ris) > 0:
        break

    else:
        print("Sorry, there's no user with that name!")

if len(ris) > 1:
    while True:
        i = 0
        for item in ris:
            print(str(i) + " - " + str(item))
            i = i + 1
        user_id = input("Select the user's id: ")
        if RepresentsInt(user_id) == True:
            user_id = int(user_id)
            if user_id >= 0 and user_id <= len(ris):
                break

    user_id = ris[user_id]

else:
    user_id = ris[0]

main_cursor.execute("select CreationDate from " + users_table + " where id = " + str(user_id))
beginDate = main_cursor.fetchone()
beginDate = beginDate[0].date()
while True:
    try:
        endDate = input("Enter a date >= " + str(beginDate) + " in YYYY-MM-DD format: ")
        year, month, day = map(int, endDate.split('-'))
        endDate = datetime.date(year, month, day)
        if endDate >= beginDate:
            break
        else:
            print("Sorry, the user was not registered on " + str(endDate) + " yet!")
    except ValueError as e:
        print(e)

cursor = conn.cursor() 

start = datetime.datetime.now()

print("There will be considered days from " + str(beginDate) + " to " + str(endDate))

estimated_reputation = 1 # starting reputation (can't be below 1)
edit_limit = 0
bonus_flag = True

main_cursor.execute("select reputation from " + users_table + " where Id = " + str(user_id))
real_reputation = main_cursor.fetchone()
real_reputation = real_reputation[0]

while beginDate <= endDate: 
    print(str(beginDate) + " - " + str(endDate) + " - " + str(estimated_reputation) + " - " + str(real_reputation))
    searchDay1 = beginDate.strftime('%Y-%m-%d') + " 00:00:00"
    searchDay2 = beginDate.strftime('%Y-%m-%d') + " 23:59:59"
    daily_points = 0 # (You can earn a maximum of 200 reputation per day)
    bounty_awards = 0
    acceptedAnswers = 0

    main_cursor.execute("select count(*) from Question_Answer_index where ACreationDate between '" + searchDay1 + "' and '" + searchDay2 + "' and AOwnerUserId = " + str(user_id) + " and QOwnerUserId <> " + str(user_id))
    result = main_cursor.fetchone()
    result = result[0]
    acceptedAnswers = acceptedAnswers + result * 15 #answer is marked “accepted”: +15

    main_cursor.execute("select count(*) from Question_Answer_index where ACreationDate between '" + searchDay1 + "' and '" + searchDay2 + "' and QOwnerUserId = " + str(user_id) + " and AOwnerUserId <> " + str(user_id))
    result = main_cursor.fetchone()
    result = result[0]
    acceptedAnswers = acceptedAnswers + result * 2 #(+2 to acceptor)

    main_cursor.execute("select count(*) from Posts_Votes1_index where CreationDate = '" + str(beginDate) + "' and OwnerUserId = " + str(user_id))
    upVotes = main_cursor.fetchone()
    upVotes = upVotes[0]
    daily_points = daily_points + upVotes * 5 #question is voted up: +5

    main_cursor.execute("select count(*) from Posts_Votes2_index where CreationDate = '" + str(beginDate) + "' and OwnerUserId = " + str(user_id))
    downVotes = main_cursor.fetchone()
    downVotes = downVotes[0]
    daily_points = daily_points + downVotes * -2 #your question is voted down: -2

    main_cursor.execute("select count(*) from Posts_Votes3_index where CreationDate = '" + str(beginDate) + "' and OwnerUserId = " + str(user_id))
    upVotes = main_cursor.fetchone()
    upVotes = upVotes[0]
    daily_points = daily_points + upVotes * 10 #answer is voted up: +10

    main_cursor.execute("select count(*) from Posts_Votes4_index where CreationDate = '" + str(beginDate) + "' and OwnerUserId = " + str(user_id))
    downVotes = main_cursor.fetchone()
    downVotes = downVotes[0]
    daily_points = daily_points + downVotes * -2 #your answer is voted down: -2

    main_cursor.execute("select count(*) from PostHistory_24_index where CreationDate between '" + searchDay1 + "' and '" + searchDay2 + "' and UserId = " + str(user_id))
    edits_accepted = main_cursor.fetchone()
    edits_accepted = edits_accepted[0]
    temp = edit_limit
    edit_limit = edit_limit + edits_accepted * 2
    if edit_limit <= 1000:
        daily_points = daily_points + edits_accepted * 2 #suggested edit is accepted: +2 (up to +1000 total per user)
    elif temp < 1000:
        daily_points = daily_points + (1000 - temp)
        
    main_cursor.execute("select AcceptedAnswerId, BountyAmount from Posts_Votes5_index where CreationDate = '" + str(beginDate) + "' and UserId <> " + str(user_id))
    result_set = main_cursor.fetchone()
    while result_set != None:
        answer_id, bounty_amount = result_set 
        cursor.execute("select OwnerUserId from " + posts_table + " where Id = " + str(answer_id))
        author_id = cursor.fetchone()
        if author_id != None:
            author_id = author_id[0]
            if author_id == user_id and bounty_amount != None:
                bounty_awards = bounty_awards + bounty_amount #bounty awarded to your answer: + full bounty amount
        result_set = main_cursor.fetchone()

    main_cursor.execute("select Id, BountyAmount from Posts_Votes6_index where CreationDate = '" + str(beginDate) + "' and UserId <> " + str(user_id))
    result_set = main_cursor.fetchone()
    while result_set != None:
        question_id, bounty_amount = result_set 
        cursor.execute("select OwnerUserId, Score from Posts_2_index where ParentId = " + str(question_id) + " and Score = (select max(Score) from Posts_2 where ParentId = " + str(question_id) + ") order by CreationDate asc")                                      
        result_set2 = cursor.fetchone()
        if result_set2 != None:
            author_id, score = result_set2
            if author_id == user_id and score >= 2 and bounty_amount != None:
                bounty_awards = bounty_awards + bounty_amount / 2 #one of your answers is awarded a bounty automatically: + half of the bounty amount
        result_set = main_cursor.fetchone()

    main_cursor.execute("select sum(BountyAmount) from Votes_8_index where CreationDate = '" + str(beginDate) + "' and UserId = " + str(user_id))
    bounty = main_cursor.fetchone()
    bounty = bounty[0]
    if bounty != None:
        daily_points = daily_points - bounty #you place a bounty on a question: − full bounty amount

    if daily_points > 200: #You can earn a maximum of 200 reputation per day
        daily_points = 200

    daily_points = daily_points + acceptedAnswers #accepted answers are not subject to the daily reputation limit

    daily_points = daily_points + bounty_awards #bounty awards are not subject to the daily reputation limit 

    estimated_reputation = estimated_reputation + daily_points

    if estimated_reputation >= 200 and bonus_flag:
        estimated_reputation = estimated_reputation + 100
        bonus_flag = False        

    if estimated_reputation < 1: #reputation can never drop below 1
        estimated_reputation = 1

    beginDate = beginDate + datetime.timedelta(days = 1) #vado al giorno successivo

main_cursor.execute("select DownVotes from " + users_table + " where Id = " + str(user_id))
downVotes = main_cursor.fetchone()
downVotes = downVotes[0]
estimated_reputation = estimated_reputation + downVotes * -1 #you vote down an answer: −1
main_cursor.execute("select count(VoteTypeId) from Posts_Votes7_index where OwnerUserId = " + str(user_id) + " group by PostId")
offensive = main_cursor.fetchone()
while offensive != None:
    offensive = offensive[0]
    if offensive >= 6:
        estimated_reputation = estimated_reputation - 100 #one of your posts receives 6 offensive flags: −100
    offensive = main_cursor.fetchone()
    
main_cursor.execute("select count(VoteTypeId) from Posts_Votes8_index where OwnerUserId = " + str(user_id) + " group by PostId")
spam = main_cursor.fetchone()
while spam != None:
    spam = spam[0]
    if spam >= 6:
        estimated_reputation = estimated_reputation - 100 #one of your posts receives 6 spam flags: −100
    spam = main_cursor.fetchone()

if estimated_reputation < 1:
    estimated_reputation = 1

print("The estimated reputation on " + str(endDate) + " is: " + str(estimated_reputation) + " while the real reputation is : " + str(real_reputation))
main_cursor.close()
cursor.close()
conn.close()

end = datetime.datetime.now()
print(end - start)


# http://meta.stackexchange.com/questions/2677/database-schema-documentation-for-the-public-data-dump-and-sede
# http://stackoverflow.com/help/whats-reputation
# http://meta.stackexchange.com/questions/7237/how-does-reputation-work
# http://meta.stackexchange.com/questions/16065/how-does-the-bounty-system-work/16067#16067
