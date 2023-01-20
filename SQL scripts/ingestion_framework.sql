---------------------------------------------------------------------------------------------------------------------
create table demo.demo_tb_1(
    id int not null IDENTITY(1,1),
    name varchar(100),
    mail_id varchar(100),
    last_updated DATETIME
)
---------------------------------------------------------------------------------------------------------------------
create table demo.demo_tb_2(
    id int not null IDENTITY(1,1),
    name varchar(100),
    address varchar(200),
    last_updated DATETIME
)
---------------------------------------------------------------------------------------------------------------------
select * from demo.demo_tb_1
select * from demo.demo_tb_2
---------------------------------------------------------------------------------------------------------------------
delete from demo.demo_tb_1
delete from demo.demo_tb_2
---------------------------------------------------------------------------------------------------------------------
TRUNCATE table demo.demo_tb_1
TRUNCATE table demo.demo_tb_2
---------------------------------------------------------------------------------------------------------------------
DECLARE @hid int;
SET @hid=1;
WHILE @hid<10
BEGIN
    INSERT demo.demo_tb_1(name,mail_id,last_updated)
    VALUES('abc'+LTRIM(STR(@hid)),'abc'+ltrim(str(@hid))+'gmail.com',getdate())
    set @hid=@hid+1;
END
---------------------------------------------------------------------------------------------------------------------
DECLARE @one int;
set @one=1;
WHILE @one<10
BEGIN
    insert  demo.demo_tb_2(name,address,last_updated)
    VALUES('XYZ'+LTRIM(STR(@one)),'XYZadress'+LTRIM(STR(@one)),getdate())
    SET @one=@one+1;
END
---------------------------------------------------------------------------------------------------------------------
create table demo.metadata_tb(
    id int IDENTITY(1,1),
    table_name VARCHAR(20),
    last_updated_date DATETIME
)
---------------------------------------------------------------------------------------------------------------------
select * from demo.metadata_tb
---------------------------------------------------------------------------------------------------------------------
delete from demo.metadata_tb
---------------------------------------------------------------------------------------------------------------------
truncate table demo.metadata_tb
---------------------------------------------------------------------------------------------------------------------
