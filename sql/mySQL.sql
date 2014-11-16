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

create table user (
    num int unsigned primary key,
    nickname char(8) not null,
    INDEX(nickname),
    mail char(30)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table comment(
	id int unsigned not null,
	seq int unsigned not null,
	content char(200) not null,
    time datetime not null,
    authorid int unsigned not null,
	INDEX(seq),
    INDEX(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table praise(
    video int unsigned not null,
    student int unsigned not null,
    INDEX(video),
    INDEX(student)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table carousel(
    id int unsigned auto_increment primary key,
    path char(255) not null,
    link char(255) not null
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table collect(
    video int unsigned not null,
    student int unsigned not null,
    INDEX(video),
    INDEX(student)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试1', 'testvideo/1.flv', 'testimg/1.jpeg', 'entertainment', '2014-11-11 20:00', '2014-11-12 20:00', 10, 0, 0, 1);
insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment, introduction) values ('测试2', 'testvideo/2.flv', 'testimg/2.jpeg', 'news', '2014-11-12 20:00', '2014-11-13 20:00', 50, 1, 0, 1, '自制 这次用日常参加TIM就是为了贯彻下真爱，尽管是去跑个龙套但是还是很满足了；日常动画完结已经好一阵子了，虽然很期待第二季但是八成是没戏了，总之希望看过的不要淡忘，没看过的一定要去补；最后希望各位去看看内帮大触的狂欢，虽然已经完事了。');
insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试3', 'testvideo/3.flv', 'testimg/3.jpeg', 'study', '2014-11-13 20:00', '2014-11-14 20:00', 1000, 13, 0, 1);
insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试4', 'testvideo/4.flv', 'testimg/4.jpeg', 'entertainment', '2014-11-14 21:00', '2014-11-19 20:00', 100, 3, 0, 1);
insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试5', 'testvideo/5.flv', 'testimg/5.jpeg', 'life', '2014-11-15 20:00', '2014-11-18 20:00', 600, 7, 0, 1);
insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试6', 'testvideo/6.flv', 'testimg/6.jpeg', 'others', '2014-11-06 20:00', '2014-11-14 20:00', 9000, 56, 0, 1);
insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试7', 'testvideo/7.flv', 'testimg/7.jpeg', 'entertainment', '2014-11-07 20:00', '2014-11-17 20:00', 15000, 410, 0, 1);
insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试8', 'testvideo/8.flv', 'testimg/8.jpeg', 'entertainment', '2014-11-08 20:00', '2014-11-12 20:00', 750, 76, 0, 1);
insert into admin (num) values (2012011333);
insert into admin (num) values (2012011348);
insert into admin (num) values (2012011338);
insert into user (num, nickname, mail) values (2012011333, '俞寒轩', 'yuhx402@gmail.com');
insert into user (num, nickname, mail) values (2012011348, '陈天昱', 'chentianyu@outlook.com'); 
insert into user (num, nickname) values (2012011338, '李心田');  
insert into carousel(path, link) values ('img/slide1.jpg', 'http://nozakikun.tv/');
insert into carousel(path, link) values ('img/slide2.jpg', 'http://nozakikun.tv/onair.html');
insert into carousel(path, link) values ('img/slide3.jpg', 'http://nozakikun.tv/staff.html');
