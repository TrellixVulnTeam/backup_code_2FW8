CREATE TABLE users (
    id integer unsigned primary key auto_increment,
    name varchar(128) not null,
    password varchar(32) not null
);