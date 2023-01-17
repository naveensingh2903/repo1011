-----------------------------------------------------------------------------------------------------------------
--TO GET CLUSTER UTILIZATION, TOTAL QUERIES, RUNNING QUERIES AND QUEUED QUERIES ON CLUSTER
SELECT SUM(COALESCE(resource_allocation_percentage,0)) as cluster_utilization, 
	count(*) as total_queries,
	SUM(CASE WHEN start_time IS NOT NULL THEN 1 ELSE 0 END) as running_queries, 
	SUM(CASE WHEN start_time IS NULL THEN 1 ELSE 0 END) as queued_queries
FROM sys.dm_pdw_exec_requests 
where status not in ('completed','cancelled','failed') and resource_class is not null
order by 2 desc
-----------------------------------------------------------------------------------------------------------------
--TO GET EACH RESOURCE_CLASS CURRENT AND MAX RUNNABLE QUERIES
select a.name,a.importance,cast(a.cap_percentage_resource/a.request_min_resource_grant_percent as int) max_queries,
b.queries_run,a.cap_percentage_resource,b.total_resource_consumption,cast(((b.total_resource_consumption/a.cap_percentage_resource)*100) as int) efficiency
from sys.workload_management_workload_groups a
left join datasturdy.view_resource b on a.name=b.resource_class
--where a.group_id>12
order by 6 desc
-----------------------------------------------------------------------------------------------------------------
--TO GET EACH RESOURCE_CLASS CURRENT AND MAX RUNNABLE QUERIES
select a.name,a.importance,(case when a.group_id>12 then cast(a.cap_percentage_resource/a.request_min_resource_grant_percent as int) 
when name='staticrc10' then 64 when name='staticrc20' then 60 
when name='staticrc20' then 60
when name='staticrc30' then 30
when name='staticrc40' then 15
when name='staticrc50' then 7
when name='staticrc60' then 3
when name='staticrc70' then 1
when name='staticrc80' then 1
when name='smallrc' then 32
when name='mediumrc' then 10
when name='largerc' then 4
when name='xlargerc' then 1
end )max_queries,
b.queries_run,a.cap_percentage_resource,b.total_resource_consumption,cast(((b.total_resource_consumption/a.cap_percentage_resource)*100) as int) efficiency
from sys.workload_management_workload_groups a
left join datasturdy.view_resource b on a.name=b.resource_class
--where a.group_id>12
order by 6 desc
-----------------------------------------------------------------------------------------------------------------
--DMV to see what all logins are running what all queries
select login_name,count(*) queries_running,sum(resource_allocation_percentage) total_resource_allocated from 
(
select datediff(mi,start_time,getdate()) mins_running,login_name,resource_allocation_percentage from sys.dm_pdw_exec_sessions s join sys.dm_pdw_exec_requests r
on s.session_id=r.session_id where r.status='running' and r.resource_class is not null
) s
group by login_name
order by 3 desc
-----------------------------------------------------------------------------------------------------------------
--Added new line first change 1
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
--Queries running from which login 
select datediff(mi,start_time,getdate()),login_name,r.* from sys.dm_pdw_exec_sessions s join sys.dm_pdw_exec_requests r
on s.session_id=r.session_id where r.status='running' and r.resource_class is not null
order by total_elapsed_time desc
-----------------------------------------------------------------------------------------------------------------
--DMV TO SEE ALL THE QUERIES WHICH ARE EXECUTED FROM SAME SESSION_ID
select * from sys.dm_pdw_exec_requests
where request_id='QID391464231'
-----------------------------------------------------------------------------------------------------------------
select * from sys.dm_pdw_exec_requests
where session_id='SID21465957'
-----------------------------------------------------------------------------------------------------------------
--DMV TO SEE BREAKDOWN OF THE QUERY
select * from sys.dm_pdw_request_steps
where request_id='QID276412486'
-----------------------------------------------------------------------------------------------------------------
select * from sys.dm_pdw_sql_requests
where request_id = 'QID275951902'
and  step_index = '19'
-----------------------------------------------------------------------------------------------------------------
select pdw_node_id,count(*) from sys.dm_pdw_sql_requests
where status ='running' 
group by pdw_node_id 
order by 2 desc
-----------------------------------------------------------------------------------------------------------------
select distribution_id,count(*) from sys.dm_pdw_sql_requests
where status='running'
group by distribution_id
order by 2 desc
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
