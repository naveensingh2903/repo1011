CREATE TABLE dev.sp(
    ProductID		INT,
    ProductName		VARCHAR(50),
    Price			DECIMAL(9,2)
)
with 
(
distribution=hash(productid))
GO
    
INSERT INTO dev.sp(ProductID,ProductName, Price) VALUES(1,'Table',100)
INSERT INTO dev.sp(ProductID,ProductName, Price) VALUES(2,'Desk',80)
INSERT INTO dev.sp(ProductID,ProductName, Price) VALUES(3,'Chair',50)
INSERT INTO dev.sp(ProductID,ProductName, Price) VALUES(4,'Computer',300)
GO
    
CREATE TABLE dev.tp(
    ProductID		INT,
    ProductName		VARCHAR(50),
    Price			DECIMAL(9,2)
) with
(distribution=hash(productid))
GO
    
INSERT INTO dev.tp(ProductID,ProductName, Price) VALUES(1,'Table',100)
INSERT INTO dev.tp(ProductID,ProductName, Price) VALUES(2,'Desk',180)
INSERT INTO dev.tp(ProductID,ProductName, Price) VALUES(5,'Bed',50)
INSERT INTO dev.tp(ProductID,ProductName, Price) VALUES(6,'Cupboard',300)
GO
    
    
SELECT * FROM dev.sp
SELECT * FROM dev.tp

merge dev.tp as target
using dev.sp as source
on target.ProductID=source.ProductID
when not matched by target then
insert (ProductID,ProductName,Price) 
values (source.productid,source.productname,source.price);


merge dev.tp as target using dev.sp as source
on source.productid=target.productid
when not matched by target then 
insert (productid,productname,price)
values (source.productid,source.productname,source.price);

merge dev.tp as target using dev.sp as source
on source.productid=target.productid
when matched then update set
target.productid=source.productid,
target.productname=source.productname,
target.price=source.price

when not matched by source then
delete;

drop table dev.tp
drop table dev.sp


