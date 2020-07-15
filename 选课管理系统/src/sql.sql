DROP DATABASE IF EXISTS ccmsdb;
CREATE DATABASE ccmsdb DEFAULT CHARACTER SET utf8;

use ccmsdb;

create table checkpeople (
                             id int not null primary key  auto_increment,
                             type varchar(20) not null,
                             name varchar(20) not null,
                             username varchar(11) not null,
                             password varchar(11) not null

);

create table admin (
                       id int not null primary key  auto_increment,
                       name varchar(20) not null,
                       username varchar(11) not null,
                       password varchar(11) not null,
                       telephone varchar(11),
                       email varchar(20),
                       date varchar(20),
                       sex varchar(2),
                       quest1 varchar(50),
                       ans1 varchar(50),
                       quest2 varchar(50),
                       ans2 varchar(50),
                       quest3 varchar(50),
                       ans3 varchar(50),
                       signature varchar(100)
);
insert into admin(name,username,password) value('老王','wang','123');
insert into admin(name,username,password) value('老李','li','123');
insert into admin(name,username,password) value('老赵','zhao','123');

create table student(
                        id int not null primary key  auto_increment,
                        name varchar(20) not null,
                        username varchar(11) not null,
                        password varchar(11) not null,
                        telephone varchar(11),
                        email varchar(20),
                        date varchar(20),
                        sex varchar(2),
                        quest1 varchar(50),
                        ans1 varchar(50),
                        quest2 varchar(50),
                        ans2 varchar(50),
                        quest3 varchar(50),
                        ans3 varchar(50),
                        signature varchar(100)
);
insert into student(name,username,password) value('小明','ming','123');
insert into student(name,username,password) value('小红','hong','123');
insert into student(name,username,password) value('小蓝','lan','123');

create table teacher(
                        id int not null primary key  auto_increment,
                        name varchar(20) not null,
                        username varchar(11) not null,
                        password varchar(11) not null,
                        telephone varchar(11),
                        email varchar(20),
                        date varchar(20),
                        sex varchar(2),
                        quest1 varchar(50),
                        ans1 varchar(50),
                        quest2 varchar(50),
                        ans2 varchar(50),
                        quest3 varchar(50),
                        ans3 varchar(50),
                        signature varchar(100)
);
insert into teacher(name,username,password) value('张三','san','123');
insert into teacher(name,username,password) value('李四','si','123');
insert into teacher(name,username,password) value('王五','wu','123');

create table course(
                       id int not null primary key auto_increment,
                       c_name varchar(20) not null,
                       time_start varchar(20) not null,
                       time_end varchar(20)  not null,
                       t_id int ,
                       t_name varchar(20),
                       selectable int,
                       num int ,
                       choice bool

);
insert into  course value(null,'c语言','2020-03-01','2020-07-01',1,'张三',200,0,true);
insert into  course value(null,'java','2020-03-01','2020-07-01',2,'李四',200,0,true);
insert into  course value(null,'paython','2020-03-01','2020-07-01',3,'王五',200,0,true);

create table sc(
                   id int not null primary key auto_increment,
                   c_name varchar(20) not null,
                   time_start varchar(20)  not null,
                   time_end varchar(20)  not null,
                   t_id int not null,
                   t_name varchar(20 ) not null,
                   s_id int not null,
                   s_name varchar(20) not null

);

create table apply(
                      id int not null primary key auto_increment,
                      a_id int ,
                      a_name varchar(20),
                      c_name varchar(20) not null,
                      time_start varchar(20) not null,
                      time_end varchar(20)  not null,
                      mold varchar(50),
                      reason varchar(100)

);

create table log(
                    id int not null primary key auto_increment,
                    admin_id int not null,
                    admin_name varchar(20) not null ,
                    type varchar(20) not null ,
                    time varchar(50) not null ,
                    text varchar(100)

);

insert into log value (null,1,'admin','添加','2020-06-24','加了个寂寞');
insert into log value (null,1,'admin','修改','2020-06-24','改了个寂寞');
insert into log value (null,1,'admin','删除','2020-06-24','删了个寂寞');
insert into log value (null,1,'admin','通过','2020-06-24','过了个寂寞');
insert into log value (null,1,'admin','拒绝','2020-06-24','拒绝个寂寞');




