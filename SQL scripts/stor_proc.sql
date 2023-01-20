select * from information_schema.TABLES
where TABLE_SCHEMA like 'demo'
-----------------------------------------------------------------------------------------------------------------------
--stored_procedure
/*
SQL Server stored procedure is a batch of statements grouped as a logical unit and stored in the database.
The stored procedure accepts the parameters and executes the T-SQL statements in the procedure, returns the result set if any.
*/

--Creating two tables and inserting some values in it for stored procedure demo
create table demo.demo_product(
    productid int,
    product_name    varchar(100)
)
-----------------------------------------------------------------------------------------------------------------------
create table demo.demo_productdesc(
    productid int,
    product_desc varchar(800)
)
-----------------------------------------------------------------------------------------------------------------------
insert into demo.demo_productdesc values (680,'Replacement mountain wheel for entry-level rider.'),
(706,'Sturdy alloy features a quick-release hub.'),
 (707,'Aerodynamic rims for smooth riding.')
GO
-----------------------------------------------------------------------------------------------------------------------
INSERT INTO demo.demo_product VALUES (707,'Sport-100 Helmet, Red'),(706,'HL Road Frame - Red, 58'),(707,'Sport-100 Helmet, Red')
GO
-----------------------------------------------------------------------------------------------------------------------
select * from demo.demo_productdesc
select * from demo.demo_product
-----------------------------------------------------------------------------------------------------------------------
--Creating a simple stored procedure
/*
create procedure demo_join
as 
BEGIN
set NOCOUNT ON

select p.productid,p.product_name,d.product_desc 
from demo_product p join demo_productdesc d 
on p.productid=d.productid

END
*/
-----------------------------------------------------------------------------------------------------------------------
--To execute the stored procedure
exec demo_join
-----------------------------------------------------------------------------------------------------------------------
--To drop the stored procedure
drop PROCEDURE demo_join 
-----------------------------------------------------------------------------------------------------------------------
--Creating a stored procedure with parameters
/*
create procedure demo_with_param
(@PID int)
AS
BEGIN
set NOCOUNT ON

select p.productid,p.product_name,d.product_desc
from demo_product p inner join demo_productdesc d
on p.productid=d.productid
where p.productid=@PID

END
*/
-----------------------------------------------------------------------------------------------------------------------
exec demo_with_param 706
-----------------------------------------------------------------------------------------------------------------------
drop procedure demo_with_param
-----------------------------------------------------------------------------------------------------------------------
--Creating a stored procedure with default parameters
/*
create procedure demo_default_param
(@PID int= 706)
AS
BEGIN 
set NOCOUNT ON

select p.productid,p.product_name,d.product_desc
from demo_product p inner join demo_productdesc d
on p.productid=d.productid
where p.productid=@PID

END
*/
-----------------------------------------------------------------------------------------------------------------------
drop procedure demo_default_param
-----------------------------------------------------------------------------------------------------------------------
exec demo_default_param
-----------------------------------------------------------------------------------------------------------------------
--creating a stored procedure with output parameter
--For this we will create another table in "demo" schema
create table demo.emp(
    id int identity(1,1),
name varchar(200))
-----------------------------------------------------------------------------------------------------------------------
create procedure demo_output_param
(@ename varchar(50),
@eid int output)
AS
begin 
set nocount on 

insert into emp(name) values (@ename)
select @eid=SCOPE_IDENTITY()

END

