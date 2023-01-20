--------------------------------------------------------------------------------------------
--Run this in master
--for master 
--servername - bi-azure-synapse-workspace.sql.azuresynapse.net
--username - sqladminuser
--PASSWORD - 3knfFb9D3XKGJA9h
create login smallrc_user with password='Myntra@2021'
create login mediumrc_user with password='Myntra@2021#'
create login largerc_user with password='Myntra@2021#'
--------------------------------------------------------------------------------------------
--Run this in respective database
create user smallrc_user for login smallrc_user
GRANT CONTROL ON DATABASE::CommerceDB TO smallrc_user;
--------------------------------------------------------------------------------------------
create user mediumrc_user for login mediumrc_user
GRANT CONTROL ON DATABASE::CommerceDB TO mediumrc_user;
--------------------------------------------------------------------------------------------
create user largerc_user for login largerc_user
GRANT CONTROL ON DATABASE::CommerceDB TO largerc_user;
--------------------------------------------------------------------------------------------
--usefull DMVs
select * from sys.database_role_members
select * from sys.database_principals
select * from sys.sysusers
--DMV to see the role name 
SELECT DP1.name AS DatabaseRoleName,   
   isnull (DP2.name, 'No members') AS DatabaseUserName   
 FROM sys.database_role_members AS DRM  
 RIGHT OUTER JOIN sys.database_principals AS DP1  
   ON DRM.role_principal_id = DP1.principal_id  
 LEFT OUTER JOIN sys.database_principals AS DP2  
   ON DRM.member_principal_id = DP2.principal_id  
WHERE DP1.type = 'R'
ORDER BY DP1.name; 
--------------------------------------------------------------------------------------------
EXEC sp_addrolemember 'smallrc', 'smallrc_user';
EXEC sp_addrolemember 'mediumrc', 'mediumrc_user';
EXEC sp_addrolemember 'largerc', 'largerc_user';
--------------------------------------------------------------------------------------------



