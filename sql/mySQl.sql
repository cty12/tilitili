create database tilitili;
use tilitili;
SET NAMES 'utf8';
SET character_set_database='utf8';
SET character_set_server='utf8';

create table video (
    id int unsigned auto_increment primary key,
    int unsigned type not null,
    title char(20) not null,
    path char(200) not null,
    introduction char(200),
    INDEX(type)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table admin (
	int num primary key
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table comment(
	id int unsigned primary key,
	int unsigned seq not null,
	content char(200) not null,
	INDEX(seq)
)
