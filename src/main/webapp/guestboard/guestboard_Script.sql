
/*oracle에서 table 생성*/
create table guestboard(
    name varchar2(100),
    email varchar2(100),
    inputdat varchar2(100) primary key,
    subject varchar2(100),
    content varchar2(2000)
    );
    
desc guestboard;

/*===============================*/
use myDB;

/*MSSQL에서 table 생성*/
create table guestboard(
    name varchar(100),
    email varchar(100),
    inputdat varchar(100) primary key,
    subject varchar(100),
    content varchar(2000)
    );
 
 /*===============================*/
/*MySQL에서 table 생성*/
create table guestboard(
    name varchar(100),
    email varchar(100),
    inputdat varchar(100) primary key,
    subject varchar(100),
    content varchar(2000)
    );