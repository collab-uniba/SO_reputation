/* use stackoverflow_march; */

drop table if exists Question;
create table Question as select Id 'QId', AcceptedAnswerId 'QAcceptedAnswerId', OwnerUserId 'QOwnerUserId' from Posts where Posts.PostTypeId = 1 and Posts.AcceptedAnswerId is not null and Posts.CommunityOwnedDate is null;
alter table Question add primary key(QId);
alter table Question modify QId integer not null auto_increment;

drop table if exists Answer;
create table Answer as select Id 'AId', OwnerUserId 'AOwnerUserId', CreationDate 'ACreationDate' from Posts where PostTypeId = 2 and Posts.CommunityOwnedDate is null;
alter table Answer add primary key(AId);
alter table Answer modify AId integer not null auto_increment;

drop table if exists Question_Answer;
create table Question_Answer as select * from Question inner join Answer on Question.QAcceptedAnswerId = Answer.AId;
create index i1Question_Answer on Question_Answer (ACreationDate, AOwnerUserId);
create index i2Question_Answer on Question_Answer (ACreationDate, QOwnerUserId);

drop table if exists Posts_Votes1;
create table Posts_Votes1 as select Posts.OwnerUserId, Votes.CreationDate from Posts inner join Votes on Posts.Id = Votes.PostId where Posts.PostTypeId = 1 and Posts.CommunityOwnedDate is null and Votes.VoteTypeId = 2;
create index iPosts_Votes1 on Posts_Votes1 (CreationDate, OwnerUserId);

drop table if exists Posts_Votes2;
create table Posts_Votes2 as select Posts.OwnerUserId, Votes.CreationDate from Posts inner join Votes on Posts.Id = Votes.PostId where Posts.PostTypeId = 1 and Posts.CommunityOwnedDate is null and Votes.VoteTypeId = 3;
create index iPosts_Votes2 on Posts_Votes2 (CreationDate, OwnerUserId);

drop table if exists Posts_Votes3;
create table Posts_Votes3 as select Posts.OwnerUserId, Votes.CreationDate from Posts inner join Votes on Posts.Id = Votes.PostId where Posts.PostTypeId = 2 and Posts.CommunityOwnedDate is null and Votes.VoteTypeId = 2;
create index iPosts_Votes3 on Posts_Votes3 (CreationDate, OwnerUserId);

drop table if exists Posts_Votes4;
create table Posts_Votes4 as select Posts.OwnerUserId, Votes.CreationDate from Posts inner join Votes on Posts.Id = Votes.PostId where Posts.PostTypeId = 2 and Posts.CommunityOwnedDate is null and Votes.VoteTypeId = 3;
create index iPosts_Votes4 on Posts_Votes4 (CreationDate, OwnerUserId);
