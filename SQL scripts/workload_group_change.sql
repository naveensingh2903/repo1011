--DMVs for user, wg and classifiers
select * from sys.workload_management_workload_groups
select * from sys.workload_management_workload_classifiers
select * from sys.workload_management_workload_classifier_details
select * from sys.database_role_members
select * from sys.database_principals

select * from sys.sysusers
where name like '%hflr_fin_mec%'

resource_class: wg_hflr_myntrapoc

SELECT *
FROM sys.workload_management_workload_groups  
WHERE [name] = 'wgDataLoads'
----------------------------------------------------------------------
Alter WORKLOAD GROUP wg_hflr_myntrapoc
 WITH
 (   MIN_PERCENTAGE_RESOURCE = 0 
   , CAP_PERCENTAGE_RESOURCE = 18
   , REQUEST_MIN_RESOURCE_GRANT_PERCENT =3 
 ,  REQUEST_MAX_RESOURCE_GRANT_PERCENT = 3 
  ,  IMPORTANCE =  ABOVE_NORMAL
   ,  QUERY_EXECUTION_TIMEOUT_SEC = 3600  )
----------------------------------------------------------------------
Alter WORKLOAD GROUP myntra_etl
 WITH
 (   MIN_PERCENTAGE_RESOURCE = 0 
   , CAP_PERCENTAGE_RESOURCE = 40
   , REQUEST_MIN_RESOURCE_GRANT_PERCENT =4 
 ,  REQUEST_MAX_RESOURCE_GRANT_PERCENT = 4 
  ,  IMPORTANCE =  NORMAL)
----------------------------------------------------------------------
ALTER WORKLOAD GROUP wg_hflr_myntrapoc WITH
( MIN_PERCENTAGE_RESOURCE            = 0
 ,CAP_PERCENTAGE_RESOURCE            = 80
 ,REQUEST_MIN_RESOURCE_GRANT_PERCENT = 10 )
----------------------------------------------------------------------

  
