create database test DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
create table msgs(id integer auto_increment primary key, name varchar(120) default 'Anonymous', content varchar(2048), `createTime` datetime NOT NULL);
