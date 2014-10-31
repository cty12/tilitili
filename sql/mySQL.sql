drop database tilitili;
create database tilitili;
use tilitili;
SET NAMES 'utf8';
SET character_set_database='utf8';
SET character_set_server='utf8';

create table video (
    id int unsigned auto_increment primary key,
    title char(20) not null,
    path char(200) not null,
    icon char(200) not null,
    type enum('others', 'news', 'study', 'life', 'entertainment') not null,
    time datetime not null,
    recent datetime not null,
    introduction char(200),
    click int unsigned not null,
    praise int unsigned not null,
    comment int unsigned not null,
    nextcomment int unsigned not null,
    INDEX(type),
    INDEX(recent)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table admin (
	num int unsigned primary key
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table comment(
	id int unsigned not null,
	seq int unsigned not null,
	content char(200) not null,
    time datetime not null,
	INDEX(seq),
    INDEX(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试1', 'testvideo/1.flv', 'testimg/1.jpeg', 'entertainment', '2014-09-01 20:00', '2014-09-02 20:00', 10, 0, 0, 1);
insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试2', 'testvideo/2.flv', 'testimg/2.jpeg', 'news', '2014-09-02 20:00', '2014-10-02 20:00', 50, 1, 0, 1);
insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试3', 'testvideo/3.flv', 'testimg/3.jpeg', 'study', '2014-09-03 20:00', '2014-09-04 20:00', 1000, 13, 0, 1);
insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试4', 'testvideo/4.flv', 'testimg/4.jpeg', 'entertainment', '2014-09-04 21:00', '2014-11-02 20:00', 100, 3, 0, 1);
insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试5', 'testvideo/5.flv', 'testimg/5.jpeg', 'life', '2014-09-05 20:00', '2014-10-02 20:00', 600, 7, 0, 1);
insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试6', 'testvideo/6.flv', 'testimg/6.jpeg', 'others', '2014-09-06 20:00', '2014-10-04 20:00', 9000, 56, 0, 1);
insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试7', 'testvideo/7.flv', 'testimg/7.jpeg', 'entertainment', '2014-09-07 20:00', '2014-10-07 20:00', 15000, 410, 0, 1);
insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试8', 'testvideo/8.flv', 'testimg/8.jpeg', 'entertainment', '2014-09-08 20:00', '2014-10-12 20:00', 750, 76, 0, 1);
