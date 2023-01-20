-----------------------------------------------------------------------------------------------------------------
select distinct(rw.request_id)
from sys.dm_workload_management_workload_groups_stats s
join sys.dm_pdw_exec_requests r on r.group_name = s.name collate SQL_Latin1_General_CP1_CI_AS
join sys.dm_pdw_resource_waits rw on rw.request_id = r.request_id
where rw.State='Queued'
-----------------------------------------------------------------------------------------------------------------
SELECT pdw_node_id, count( distinct request_id) 
FROM sys.dm_pdw_sql_requests 
WHERE status ='running'
group by pdw_node_id
order by 2 DESC
-----------------------------------------------------------------------------------------------------------------
select top 20 * from sys.dm_pdw_exec_requests
where [status]='Running'
order by total_elapsed_time DESC
-----------------------------------------------------------------------------------------------------------------
select * from sys.dm_pdw_exec_requests
where session_id='SID225367640'
-----------------------------------------------------------------------------------------------------------------
select * from sys.dm_pdw_request_steps
where request_id='QID275742194'
-----------------------------------------------------------------------------------------------------------------
select * from sys.dm_pdw_sql_requests
where request_id = 'QID275951902'
and  step_index = '19'
-----------------------------------------------------------------------------------------------------------------
SELECT * FROM sys.dm_pdw_dms_workers
WHERE request_id = 'QID275951902' AND step_index = 14;
-----------------------------------------------------------------------------------------------------------------
SELECT * FROM sys.dm_pdw_lock_waits w
JOIN sys.dm_pdw_exec_requests r ON w.request_id = r.request_id
where r.session_id='SID225039808'
-----------------------------------------------------------------------------------------------------------------
SELECT pdw_node_id, count( distinct request_id) 
FROM sys.dm_pdw_sql_requests 
WHERE status = 'running'
group by pdw_node_id
order by 2 DESC
-----------------------------------------------------------------------------------------------------------------
SELECT * FROM sys.dm_pdw_lock_waits w
JOIN sys.dm_pdw_exec_requests r ON w.request_id = r.request_id
where w.session_id='SID502993969'
-----------------------------------------------------------------------------------------------------------------
select count(*) from sys.dm_pdw_sql_requests  --106141
-----------------------------------------------------------------------------------------------------------------
select request_id, session_id, submit_time, start_time, end_compile_time, end_time, command from sys.dm_pdw_exec_requests
where session_id = 'SID503146481'
-----------------------------------------------------------------------------------------------------------------
exec [troubleshooting].[usp_first_half_update_Stats_for_defined_tables]
-----------------------------------------------------------------------------------------------------------------
select request_id,session_id,total_elapsed_time,command,resource_class,importance,group_name,classifier_name,resource_allocation_percentage
from sys.dm_pdw_exec_requests
where [status] in ('Running','suspended') and resource_class is not NULL
order by total_elapsed_time DESC
-----------------------------------------------------------------------------------------------------------------
select sum(resource_allocation_percentage) as total_resource_consumption
from sys.dm_pdw_exec_requests
where [status] in ('Running','suspended') and resource_class is not NULL
-----------------------------------------------------------------------------------------------------------------
