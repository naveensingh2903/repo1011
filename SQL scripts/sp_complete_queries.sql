-----------------------------------------------------------------------------------------------------------------
select session_id,request_id,submit_time,start_time,end_time,command into test_queries
from sys.dm_pdw_exec_requests
where 1=2
-----------------------------------------------------------------------------------------------------------------
select * from test_queries
-----------------------------------------------------------------------------------------------------------------
insert into test_queries
select session_id,request_id,submit_time,start_time,end_time,command from sys.dm_pdw_exec_requests 
where status='completed' and datediff(s,start_time,end_time)>60 and request_id not in (select request_id from test_queries)
-----------------------------------------------------------------------------------------------------------------
select datediff(mi,start_time,end_time),* from test_queries
order by 1 desc
-----------------------------------------------------------------------------------------------------------------
truncate table test_queries
-----------------------------------------------------------------------------------------------------------------
create procedure sp_complete_queries
as 
begin
insert into test_queries
select session_id,request_id,submit_time,start_time,end_time,command from sys.dm_pdw_exec_requests 
where status='completed' and datediff(s,start_time,end_time)>60 and request_id not in (select request_id from test_queries)
end
-----------------------------------------------------------------------------------------------------------------
--This doesn't work in ADW
begin
waitfor delay '00:03:00'
exec sp_complete_queries
end
-----------------------------------------------------------------------------------------------------------------
drop procedure sp_complete_queries
-----------------------------------------------------------------------------------------------------------------
select count(*) from test_queries

truncate table test_queries

select * from test_queries

select datediff(mi,start_time,end_time),* from test_queries
order by 1 desc
-----------------------------------------------------------------------------------------------------------------



