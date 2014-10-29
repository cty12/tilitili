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
    INDEX(type),
    INDEX(recent)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table admin (
	num int unsigned primary key
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table comment(
	id int unsigned primary key,
	seq int unsigned not null,
	content char(200) not null,
	INDEX(seq)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into video (title, path, icon, type, time, recent) values ('测试1', 'test/test1.flv', 'test/test1.jpeg', 'entertainment', '2014-09-01 20:00', '2014-09-02 20:00');
insert into video (title, path, icon, type, time, recent) values ('测试2', 'test/test2.flv', 'test/test2.jpeg', 'news', '2014-09-02 20:00', '2014-10-02 20:00');
insert into video (title, path, icon, type, time, recent) values ('测试3', 'test/test3.flv', 'test/test3.jpeg', 'study', '2014-09-03 20:00', '2014-09-04 20:00');
insert into video (title, path, icon, type, time, recent) values ('测试4', 'test/test4.flv', 'test/test4.jpeg', 'entertainment', '2014-09-04 21:00', '2014-11-02 20:00');
insert into video (title, path, icon, type, time, recent) values ('测试5', 'test/test5.flv', 'test/test5.jpeg', 'life', '2014-09-05 20:00', '2014-10-02 20:00');