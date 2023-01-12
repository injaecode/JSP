

----게시판(질문 답변형 게시판)
create table freeboard(
id number constraint PK_freeboard_id primary key,
name varchar2(100) not null,
password varchar2(100) not null,
email varchar2(100) null,
subject varchar2(100) not null,
content varchar2(2000) not null,
inputdate varchar2(100) not null,

----답변글을 처리하는 컬럼
masterid number default 0,
readcount number default 0,
replynum number default 0,
step number default 0

);
/*MSSQL(MySQL) DB(myDB)용*/

create table freeboard(
id int constraint PK_freeboard_id primary key,
name varchar(100) not null,
password varchar(100) not null,
email varchar(100) null,
subject varchar(100) not null,
content varchar(2000) not null,
inputdate varchar(100) not null,

----답변글을 처리하는 컬럼
masterid int default 0,
readcount int default 0,
replynum int default 0,
step int default 0

);