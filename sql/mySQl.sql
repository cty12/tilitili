create database tilitili;
use tilitili;
SET NAMES 'utf8';
SET character_set_database='utf8';
SET character_set_server='utf8';

create table video (
    id int unsigned auto_increment primary key,
    title char(20) not null,
    path char(200) not null,
    introduction char(200)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;