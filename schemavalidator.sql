\set VERBOSITY terse
\pset footer off
select 'SchemaValidationReport_' || :'ora_schema' || '_' ||to_char(now(),'YYYYDDMMHH24MISS') || '.html' as htmlfile
\gset
set search_path=oracle_schema_compare,public;
\pset tuples_only on
\o :htmlfile
\qecho <head>
\qecho <meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
\qecho <meta name="generator" content="PSQL">
\qecho  <style type='text/css'> body {font:10pt Arial,Helvetica,sans-serif; color:black; background:White;} p {font:10pt Arial,Helvetica,sans-serif; color:black; background:White;} table,tr,td {font:10pt Arial,Helvetica,sans-serif; color:Black; background:#f7f7e7; padding:0px 0px 0px 0px; margin:0px 0px 0px 0px;} th {font:bold 10pt Arial,Helvetica,sans-serif; color:#336699; background:#cccc99; padding:0px 0px 0px 0px;} h1 {font:16pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background color:White; border-bottom:1px solid #cccc99; margin-top:0pt; margin-bottom:0pt; padding:0px 0px 0px 0px;- } h2 {font:bold 10pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; margin-top:4pt; margin-bottom:0pt;} a {font:9pt Arial,Helvetica,sans-serif; color:#663300; background:#ffffff; margin-top:0pt; margin-bottom:0pt; vertical-align:top;}</style>
\qecho </head>
\qecho <h1 style="font-family:verdana"align="center">:ora_schema Schema Validation Report for Oracle to PostgreSQL Migration</h1>
\qecho <div class="table-content">
\qecho <p style="font-family:verdana"><strong>Contents</strong></p>
\qecho <ol>
\qecho <li><a href="#Overview">Overview</a>
\qecho </li>
\qecho <li><a href="#DatabaseConfiguration">Database Configuration</a>
      \qecho <ol>
      \qecho <li><a href="#DatabaseConfiguration1">Database</a></li>
      \qecho <li><a href="#DatabaseConfiguration2">Schema Size</a></li>
      \qecho <li><a href="#DatabaseConfiguration3">Character Encoding and Collation</a></li>
      \qecho </ol>
      \qecho <li><a href="#Databaseobjects">Database Objects</a>
      \qecho <ol>
                \qecho <li><a href="#Databaseobjects1">Objects Summary</a></li>
                \qecho <li><a href="#Databaseobjects2">Objects Mismatch</a></li>
                \qecho <ol>
                      \qecho <li><a href="#ObjectMismatch1">Tables</a></li>
					  \qecho <li><a href="#ObjectMismatch1A">Tables Partition</a></li>
                      \qecho <li><a href="#ObjectMismatch2">Indexes By Table</a></li>
					  \qecho <li><a href="#ObjectMismatch2A">Partition Indexes</a></li>
                      \qecho <li><a href="#ObjectMismatch2B">Indexes</a></li>
                      \qecho <li><a href="#ObjectMismatch3">Table columns</a></li>
                      \qecho <li><a href="#ObjectMismatch4">Sequence</a></li>
                      \qecho <li><a href="#ObjectMismatch5">Sequence maxval</a></li>
                      \qecho <li><a href="#ObjectMismatch6">Constraints</a></li>
                      \qecho <ol>
                              \qecho <li><a href="#Constraints1">Primary key</a></li>
                              \qecho <li><a href="#Constraints2A">Foreign Reference</a></li>

                              \qecho <li><a href="#Constraints2">Unique</a></li>
                              \qecho <li><a href="#Constraints3">Check</a></li>
                              \qecho <li><a href="#Constraints4">Not Null</a></li>
                              \qecho <li><a href="#Constraints5">Default</a></li>
                      \qecho </ol>
                      \qecho <li><a href="#ObjectMismatch7">Materialized View</a></li>
                      \qecho <li><a href="#ObjectMismatch8">Type</a></li>
                      \qecho <li><a href="#ObjectMismatch9">View</a></li>
                      \qecho <li><a href="#ObjectMismatch10">Trigger</a></li>
                \qecho </ol>
                SELECT '<li><a href="#Databaseobjects3">Oracle Package as PostreSQL Schema comparision</a></li>' where :{?code_compare};
                SELECT '<li><a href="#Databaseobjects4">Procedures and Functions</a></li>' where :{?code_compare};
      \qecho </ol>
      \qecho <li><a href="#DataType">Data Type</a></li>
        \qecho <ol>
          \qecho <li><a href="#DataType1">Data Type Mapping Matrix</a></li>
		  \qecho <li><a href="#DataType2">Data Type Mapping on Primary and Foreign key columns</a></li>
         \qecho </ol>
        \qecho <li><a href="#MigrationAnomalies">Migration anomalies</a></li>
          \qecho <ol>
          \qecho <li><a href="#MigrationAnomalies1">Partition column not part of Primary key</a></li>
          \qecho <li><a href="#MigrationAnomalies2">Unique index as composite indexes with nullable constraint on column</a></li>
          \qecho <li><a href="#MigrationAnomalies3">User Created Extended Statistics</a></li>
          \qecho <li><a href="#MigrationAnomalies4">Default on NULLs</a></li>
		  \qecho <li><a href="#MigrationAnomalies5">Database Identifier length > 63</a></li>
          \qecho </ol>
\qecho </ol>
\qecho </li>
\qecho </div>
\qecho <title>Schema Validation Report for Oracle to PostgreSQL Migration</title>
\qecho <hr>
\qecho <p id="Overview" class="anchor"></p>
\qecho <h2 style="font-family:verdana">Overview</h2>
\qecho <br>
\qecho <h4 style="font-family:verdana;list-style-type:none">
\qecho   <li>This is the output from the Schema Validation script on Oracle to PostgreSQL Migration.</li>
\qecho </h4>
\t
\pset tuples_only on
select 'Current Database Time : <b>' || date_trunc('second', clock_timestamp()::timestamp) || '</b>';
\qecho <br>
select 'Oracle Database User : <b> '||:'ora_schema'||'</b>';
\qecho <br>
select 'PostgreSQL Database Schema: <b> '||:'pg_schema'||'</b>';
\qecho <br>
\pset format html
\qecho <hr>
\qecho <p id="DatabaseConfiguration" class="anchor"></p>
\qecho <h2 style="font-family:verdana">Database Configuration</h2>
\qecho <p id="DatabaseConfiguration1" class="anchor"></p>
\qecho <h2>Database Details</h2>
\qecho <br>
\qecho  <li><a href="#Top">Previous : </a><a href="#Top">Top : </a><a href="#DatabaseConfiguration2">Next</a></li>
\qecho <br>

\pset footer off
\pset tuples_only
\echo Comparing Database Configuration.
-- Database Name SQL Start
select 'Oracle' "Engine", global_NAME "Database Name", a.banner "Version" from GLOBAL_NAME, (SELECT Banner FROM v_$version WHERE banner LIKE 'Oracle%') a
union all
select 'PostgreSQL' "Engine", current_database() "Database Name", version() "Version";

-- Database Name SQL End

\qecho <br>
\qecho <br>
\qecho <p id="DatabaseConfiguration2" class="anchor"></p>
\qecho <h2>Schema Size</h2>
\qecho <br>

\qecho <li><a href="#DatabaseConfiguration1">Previous : </a><a href="#Top">Top : </a><a href="#DatabaseConfiguration3">Next</a></li>
\qecho <br>


-- Schema size SQL start
SELECT COALESCE(src.schema_name,tgt.schema_name) "schema Name", src.size_in_gb "Oracle Size(GB)", COALESCE(tgt.size_in_gb ,0)"PostgreSQL Size(GB)"
  FROM (select owner schema_name, round(sum(bytes::bigint)/1024/1024/1024,0) size_in_gb from dba_segments where owner=upper(:'ora_schema') group by owner) src
       FULL OUTER JOIN
       (select schemaname schema_name, round(sum(pg_total_relation_size(schemaname||'.'||tablename))/1024/1024/1024,0) size_in_gb from pg_tables where schemaname=lower(:'pg_schema') group by schemaname) tgt
       ON lower(src.schema_name)=tgt.schema_name;
-- Schema size SQL End



\qecho <br>
\qecho <br>
\qecho <p id="DatabaseConfiguration3" class="anchor"></p>
\qecho <h2>Character Encoding and Collation </h2>
\qecho <br>

\qecho <li><a href="#DatabaseConfiguration2">Previous : </a><a href="#Top">Top : </a><a href="#Databaseobjects">Next</a></li>
\qecho <br>

-- Character Collate SQL start
select 'Oracle' "Engine", value "Characterset/Encoding/Collation" from v_$nls_parameters where parameter='NLS_CHARACTERSET'
union all
select 'PostgreSQL' "Engine", 'Encoding = '||pg_encoding_to_char(encoding)||', Collation = '||datcollate "Characterset/Encoding" FROM pg_database WHERE datname = current_database();

-- Character Collate SQL End
\echo Comparing Database Schema.
\qecho <hr>
\qecho <p id="Databaseobjects" class="anchor"></p>
\qecho <h2 style="font-family:verdana">Database Objects</h2>
\qecho <p id="Databaseobjects1" class="anchor"></p>
\qecho <h2>Database Object Summary </h2>
\qecho <br>
\qecho <li><a href="#DatabaseConfiguration3">Previous : </a><a href="#Top">Top : </a><a href="#Databaseobjects2">Next</a></li>
\qecho <h4>This section shows the count of objects in Oracle and PostgreSQL Database with source Oracle as reference.</h4>
-- Objects Summary SQL start
SELECT * FROM
(select src.owner "Schema Name", src.object_type "Object Type", src.cnt "Oracle Object Count", coalesce(tgt.cnt,0) "PostgreSQL Object Count"
  from (select owner, case when object_type = 'PACKAGE' then 'PACKAGE/SCHEMA' else object_type end object_type, count(*) cnt from dba_objects
		 where owner=upper(:'ora_schema')
		   and (OBJECT_name not like 'DR%' and OBJECT_name not like 'BIN$%' and OBJECT_name not like 'MLOG$%' and object_name not like 'I_SNAP$%')
		   and (OBJECT_name not in (select mview_name from dba_mviews where owner=upper(:'ora_schema') and object_type='TABLE'))
		   and TEMPORARY!='Y'
		   and object_name not in (select index_name from dba_indexes where owner=upper(:'ora_schema')
		                              and index_type='LOB' or (table_name in (select mview_name from dba_mviews where owner=upper(:'ora_schema')) and generated='Y'))
		   and object_type in ('TABLE', 'INDEX', 'MATERIALIZED_VIEW', 'SEQUENCE', 'VIEW', 'TYPE', 'TRIGGER')
		 GROUP BY owner, object_type) src
		left outer join
	   (select object_type, count(*) cnt
	      from (
				select  case
							when (cls.relkind = 'r' and relispartition='no') then 'TABLE'
							when (cls.relkind = 'r' and relispartition='yes') then 'TABLE PARTITION'
							when (cls.relkind = 'p') then 'TABLE'
							when (cls.relkind = 'f') then 'FOREIGN TABLE'
							when (cls.relkind = 'm') then 'MATERIALIZED_VIEW'
							when (cls.relkind = 'i' and relispartition='no') then (select case when ctb.relispartition = 'yes' then 'INDEX PARTITION' else 'INDEX' end
																					 from pg_class ctb
																					 join pg_index ix on ctb.oid = ix.indrelid
																					 join pg_class cix on cix.oid = ix.indexrelid
																					 join pg_namespace nsp on nsp.oid = ctb.relnamespace
																				    where nsp.nspname = lower(:'pg_schema')
																					  and cix.relname = cls.relname)
							when (cls.relkind = 'i' and relispartition='yes') then 'INDEX PARTITION'
							when (cls.relkind = 'I') then 'INDEX'
							when (cls.relkind = 'S') then 'SEQUENCE'
							when (cls.relkind = 'v') then 'VIEW'
							when (cls.relkind = 'c') then 'TYPE'
							ELSE cls.relkind::varchar
					    end as object_Type, *
				  from pg_class cls
				  join pg_namespace nsp
					ON nsp.oid = cls.relnamespace
				 where nsp.nspname = lower(:'pg_schema')
				   and nsp.nspname not like 'pg_toast%') a
	     GROUP BY object_type
		 union all
		select 'TRIGGER' object_type, count(distinct action_statement)
		   from information_schema.triggers
		  where event_object_schema=lower(:'pg_schema')) tgt
		ON src.OBJECT_type=tgt.object_type
UNION ALL
(select src.owner "Schema Name", src.object_type "Object Type", count(src.object_name) "Oracle Object Count", count(tgt.object_name) "PostgreSQL Object Count"
  from
(select distinct owner, case when object_type = 'PACKAGE' then 'PACKAGE/SCHEMA'
               when object_type in ('PROCEDURE','FUNCTION') then 'PROCEDURE-FUNCTION' else object_type end object_type , object_name from dba_objects
 where owner=upper(:'ora_schema')
    and :{?code_compare}
   and (OBJECT_name not like 'DR%' and OBJECT_name not like 'BIN$%' and OBJECT_name not like 'MLOG$%' and object_name not like 'I_SNAP$%')
   and (OBJECT_name not in (select mview_name from dba_mviews where owner=upper(:'ora_schema') and object_type='TABLE'))
   and TEMPORARY!='Y'
   and object_name not in (select index_name from dba_indexes where owner=upper(:'ora_schema')
                              and index_type='LOB' or (table_name in (select mview_name from dba_mviews where owner=upper(:'ora_schema')) and generated='Y'))
   and object_type in ('PACKAGE','PROCEDURE','FUNCTION')) src  left outer join
(select distinct case when pr.prokind='p' then 'PROCEDURE-FUNCTION' else 'PROCEDURE-FUNCTION' end as object_type , proname object_name
  from pg_proc pr
  join pg_namespace nsp on nsp.oid = pr.pronamespace
 where nsp.nspname = lower(:'pg_schema')
 union all
select 'PACKAGE/SCHEMA' object_type,  nspname
 from pg_namespace
         where nspname not like 'pg_toast%'
      and nspname not like 'pg_temp_%'
         and nspname not in ('pg_toast','pg_catalog','information_schema','public','oracle_schema_compare',lower(:'pg_schema'))) tgt
         on (upper(src.object_name) = upper(tgt.object_name) and :{?code_compare} )
         group by src.owner ,src.object_type  )) alias1
 order BY "Schema Name", CASE "Object Type" when 'TABLE' then 1
                            when 'INDEX' then 2
							when 'MATERIALIZED_VIEW' then 5
							when 'SEQUENCE' then 3
							when  'VIEW' then 6
							when 'TYPE' then 4
							when  'TRIGGER' then 7 else 8 end;
-- Objects Summary SQL End


\qecho <hr>
\qecho <p id="Databaseobjects2" class="anchor"></p>
\qecho <h2 style="font-family:verdana">Database Schema Objects Mismatch</h2>

\qecho <p id="ObjectMismatch1" class="anchor"></p>
\qecho <h2>Missing Target Database Table Details</h2>
\qecho <br>
\qecho <li><a href="#Databaseobjects1">Previous : </a><a href="#Top">Top : </a><a href="#ObjectMismatch2">Next</a></li>
\qecho <h4>This section provides the tables that exist in Oracle but are missing in PostgreSQL Database.</h4>
-- Tables SQL start
select src.owner "Schema Name",
       src.object_name as "Table Name" ,
	src.partitioned  as "Partitioned"
  from (select t.owner, t.table_name as object_name,'TABLE'as object_type,
			   t.table_name table_name , t.partitioned
		  from dba_tables t
		 where t.owner=upper(:'ora_schema')
		   and (t.table_name not like 'DR%' and t.table_name not like 'BIN$%' and t.table_name not like 'MLOG$%')
		   and t.table_name not in (select mview_name from dba_mviews where owner=upper(:'ora_schema'))
		   and t.TEMPORARY!='Y') src
		left outer join
	   (select  nsp.nspname object_owner, cls.relname object_name,
				case
					when (cls.relkind = 'r' and relispartition='no') then 'TABLE'
					when (cls.relkind = 'r' and relispartition='yes') then 'TABLE PARTITION'
					when (cls.relkind = 'p') then 'TABLE'
					ELSE cls.relkind::varchar
				end as object_Type
		from pg_class cls
		join pg_namespace nsp ON nsp.oid = cls.relnamespace
	   where nsp.nspname = lower(:'pg_schema')
		 and nsp.nspname not like 'pg_toast%'
	     and cls.relkind in ('r','p')) tgt
	   on lower(src.OBJECT_name)=tgt.object_name and src.OBJECT_type=tgt.object_type
 where src.object_name IS NULL OR tgt.object_name IS NULL
   and src.object_type like 'TABLE'
 order BY 1,2;
-- Tables SQL End

\qecho <p id="ObjectMismatch1A" class="anchor"></p>
\qecho <h2>Missing Target Database Table Partition Details</h2>
\qecho <br>
\qecho <li><a href="#Databaseobjects1A">Previous : </a><a href="#Top">Top : </a><a href="#Databaseobjects1">Next</a></li>
\qecho <h4>This section provides the table partitions that exist in Oracle but are missing in PostgreSQL Database.</h4>
select src.owner "Schema Name", src.table_name as "Table Name" ,
COUNT(CASE WHEN src.object_type = 'TABLE PARTITION' then 1 else null end) as "Oracle Table Partition Count" ,
COUNT(CASE WHEN tgt.object_type = 'TABLE PARTITION' then 1 else null end) as "PostgreSQL Table Partition Count"
  from (select t.owner,
               case
				   when partition_name is not null THEN t.table_name||'_'||partition_name
				   ELSE t.table_name
			   end as object_name,
			   case
				   when partition_name is not null THEN 'TABLE PARTITION'
				   ELSE 'TABLE'
			   end as object_type,
			   t.table_name table_name,
			   tp.partition_name
		  from dba_tables t
		  left outer join dba_tab_partitions tp on t.owner=tp.table_owner and t.table_name=tp.table_name
		 where t.owner=upper(:'ora_schema')
		   and (t.table_name not like 'DR%' and t.table_name not like 'BIN$%' and t.table_name not like 'MLOG$%')
		   and t.table_name not in (select mview_name from dba_mviews where owner=upper(:'ora_schema'))
		   and t.TEMPORARY!='Y') src
		left outer join
	   (select  nsp.nspname object_owner, cls.relname object_name,
				case
					when (cls.relkind = 'r' and relispartition='no') then 'TABLE'
					when (cls.relkind = 'r' and relispartition='yes') then 'TABLE PARTITION'
					when (cls.relkind = 'p') then 'TABLE'
					ELSE cls.relkind::varchar
				end as object_Type
		from pg_class cls
		join pg_namespace nsp ON nsp.oid = cls.relnamespace
	   where nsp.nspname = lower(:'pg_schema')
		 and nsp.nspname not like 'pg_toast%'
	     and cls.relkind in ('r','p')) tgt
	   on lower(src.OBJECT_name)=tgt.object_name and src.OBJECT_type=tgt.object_type
 where src.object_name IS NULL OR tgt.object_name IS NULL
   and src.object_type like 'TABLE PARTITION' group by src.owner , src.table_name order by 1,2;

\qecho <br>
\qecho <br>

-- Tables Partition SQL start
select src.owner "Schema Name", src.table_name as "Table Name" , src.partition_name as "Partition Name"
  from (select t.owner,
               case
				   when partition_name is not null THEN t.table_name||'_'||partition_name
				   ELSE t.table_name
			   end as object_name,
			   case
				   when partition_name is not null THEN 'TABLE PARTITION'
				   ELSE 'TABLE'
			   end as object_type,
			   t.table_name table_name,
			   tp.partition_name
		  from dba_tables t
		  left outer join dba_tab_partitions tp on t.owner=tp.table_owner and t.table_name=tp.table_name
		 where t.owner=upper(:'ora_schema')
		   and (t.table_name not like 'DR%' and t.table_name not like 'BIN$%' and t.table_name not like 'MLOG$%')
		   and t.table_name not in (select mview_name from dba_mviews where owner=upper(:'ora_schema'))
		   and t.TEMPORARY!='Y') src
		left outer join
	   (select  nsp.nspname object_owner, cls.relname object_name,
				case
					when (cls.relkind = 'r' and relispartition='no') then 'TABLE'
					when (cls.relkind = 'r' and relispartition='yes') then 'TABLE PARTITION'
					when (cls.relkind = 'p') then 'TABLE'
					ELSE cls.relkind::varchar
				end as object_Type
		from pg_class cls
		join pg_namespace nsp ON nsp.oid = cls.relnamespace
	   where nsp.nspname = lower(:'pg_schema')
		 and nsp.nspname not like 'pg_toast%'
	     and cls.relkind in ('r','p')) tgt
	   on lower(src.OBJECT_name)=tgt.object_name and src.OBJECT_type=tgt.object_type
 where src.object_name IS NULL OR tgt.object_name IS NULL
   and src.object_type like 'TABLE PARTITION'
 order BY 1,2,3;
-- Tables Partition SQL End

\qecho <br>
\qecho <br>
\qecho <p id="ObjectMismatch2" class="anchor"></p>
\qecho <h2>Database Indexes Comparison Based on Table</h2>
\qecho <br>

\qecho <li><a href="#ObjectMismatch1A">Previous : </a><a href="#Top">Top : </a><a href="#ObjectMismatch2A">Next</a></li>
\qecho <h4>This section identifies those tables, where the number of indexes does not match between Oracle and PostgreSQL Database.</h4>

-- Index Count Differences per table
--select src.owner "Schema Name", src.table_name "Table Name", coalesce(src.cnt,0) "Oracle Index Count", coalesce(tgt.cnt,0) "PostgreSQL Index Count"
select coalesce(src.owner,upper(tgt.nspname)) "Schema Name", coalesce(src.table_name,upper(tgt.table_name)) "Table Name", coalesce(src.cnt,0) "Oracle Index Count", coalesce(tgt.cnt,0) "PostgreSQL Index Count"
  from (select owner, table_name, count(*) cnt
		  from dba_indexes
		 where owner=upper(:'ora_schema')
		   and index_type!='LOB'
		   and index_name not like 'I_SNAP$%'
		   and index_name not in (select index_name from dba_indexes where owner=upper(:'ora_schema')
		                             and (table_name in (select mview_name from dba_mviews where owner=upper(:'ora_schema'))
                                 and generated='Y'))
		   and table_name not in (select table_name from dba_tables where table_name like 'DR$%' or table_name like 'BIN$%' or table_name like 'MLOG$%' or temporary='Y')
	     group by owner, table_name) src
       left outer join
       (select nsp.nspname, ctb.relname table_name, count(*) cnt
		 from pg_class ctb
		 join pg_index ix on ctb.oid = ix.indrelid
		 join pg_class cix on cix.oid = ix.indexrelid
		 join pg_namespace nsp on nsp.oid = ctb.relnamespace
		where nsp.nspname = lower(:'pg_schema')
		  and ctb.relispartition=false
		  and cix.relispartition=false
		 group by nsp.nspname, ctb.relname order by 1) tgt
       ON lower(src.table_name)=tgt.table_name
 where (src.table_name IS NULL or tgt.table_name IS NULL or src.cnt>tgt.cnt)
 order BY 1,3 desc;
-- Index Count Differences per table

\qecho <br>
\qecho <br>
\qecho <p id="ObjectMismatch2A" class="anchor"></p>
\qecho <h2>Missing Target Database Indexes Details</h2>
\qecho <br>

\qecho <li><a href="#ObjectMismatch2">Previous : </a><a href="#Top">Top : </a><a href="#ObjectMismatch2B">Next</a></li>

\qecho <h4>This section identifies those indexes that exist in Oracle but are missing in PostgreSQL Database, for non-partitioned tables.</h4>

-- Indexes SQL start
select src.owner "Schema Name", src.table_name "Table Name", src.index_name "Index Name" ,  src.index_type "Oracle Index Type"
  from (select i.owner, i.table_name, i.index_name, i.generated, i.index_type, STRING_AGG(coalesce(tc.column_id,0)::text, ' ' order by ic.column_position) indkey
		  from dba_indexes i
		  join dba_tables t on t.owner=i.owner and t.table_name=i.table_name and t.partitioned='NO' and t.temporary='N'
		  left outer join dba_ind_columns ic on i.owner = ic.index_owner and i.index_name = ic.index_name
		  left outer join dba_tab_columns tc on ic.table_owner = tc.owner and ic.table_name = tc.table_name and ic.column_name = tc.column_name
		 where i.owner=upper(:'ora_schema')
		   and i.index_type!='LOB'
		   and i.index_name not like 'I_SNAP$%'
		   and (t.table_name not like 'DR$%' and t.table_name not like 'BIN$%' and t.table_name not like 'MLOG$%')
		   and i.index_name not in (select index_name from dba_indexes where owner=upper(:'ora_schema')
		                               and table_name in (select mview_name from dba_mviews where owner=upper(:'ora_schema')) and generated='Y')
		 group by i.owner, i.table_name, i.index_name, i.generated, i.index_type) src
	   left outer join
	   (
       select ctb.relname as table_name,
			   cix.relname as index_name,
			   ix.indkey::text indkey
		  from pg_class ctb
		  join pg_index ix on ctb.oid = ix.indrelid
		  join pg_class cix on cix.oid = ix.indexrelid
		  join pg_namespace nsp on nsp.oid = ctb.relnamespace
		 where nsp.nspname = lower(:'pg_schema')
		   and ctb.relispartition='no') tgt
	   ON lower(src.table_name)=tgt.table_name
     and src.indkey = tgt.indkey
	   and ((src.generated='N' and src.index_type='FUNCTION-BASED NORMAL' and lower(src.index_name)=tgt.index_name)
		 or (src.generated='N' and src.index_type!='FUNCTION-BASED NORMAL')
		 or (src.generated='Y'))
 where tgt.table_name IS NULL
 order BY 1,2;
-- Indexes SQL End


\qecho <br>
\qecho <br>
\qecho <p id="ObjectMismatch2B" class="anchor"></p>
\qecho <h2>Missing Table Partition Indexes</h2>
\qecho <br>

\qecho <li><a href="#ObjectMismatch2A">Previous : </a><a href="#Top">Top : </a><a href="#ObjectMismatch3">Next</a></li>

\qecho <h4>This section identifies those indexes that exist in Oracle but are missing in PostgreSQL Database, for Partitioned tables.</h4>

-- Partition Indexes SQL start
select src.owner "Schema Name", src.table_name "Table Name", src.index_name "Index Name"
  from (select t.owner, ic.table_name, ic.index_name, STRING_AGG(coalesce(tc.column_id,0)::text, ' ' order by ic.column_position) indkey
		  from dba_ind_columns ic
		  join dba_tables t on ic.index_owner=t.owner and ic.table_name=t.table_name and t.partitioned='YES' and t.temporary='N'
		  left outer join dba_tab_columns tc on ic.table_owner = tc.owner and ic.table_name = tc.table_name and ic.column_name = tc.column_name
		 where ic.index_owner=upper(:'ora_schema')
		   and (t.table_name not like 'DR$%' and t.table_name not like 'BIN$%' and t.table_name not like 'MLOG$%')
		   and ic.index_name not like 'I_SNAP$%'
		   and ic.index_name not in (select index_name from dba_indexes where owner=upper(:'ora_schema')
		                                and table_name in (select mview_name from dba_mviews where owner=upper(:'ora_schema')) and generated='Y')
		 group by t.owner, ic.table_name, ic.index_name) src
	   left outer join
	   (select ctb.relname as table_name,
			   cix.relname as index_name,
			   ix.indkey::text indkey,
			   ctb.relispartition
		  from pg_class ctb
		  join pg_index ix on ctb.oid = ix.indrelid
		  join pg_class cix on cix.oid = ix.indexrelid
		  join pg_namespace nsp on nsp.oid = ctb.relnamespace
		 where nsp.nspname = lower(:'pg_schema')) tgt
	   ON lower(src.table_name)=tgt.table_name
      and src.indkey=tgt.indkey
 where tgt.table_name IS NULL
 order BY 1,2;

-- Partition Indexes SQL End
\qecho <br>
\qecho <br>
\qecho <p id="ObjectMismatch3" class="anchor"></p>
\qecho <h2>Missing Target Database Table Column details</h2>
\qecho <br>

\qecho <li><a href="#ObjectMismatch2B">Previous : </a><a href="#Top">Top : </a><a href="#ObjectMismatch4">Next</a></li>

\qecho <h4>This section identifies the columns of a table that exist in Oracle but are missing in PostgreSQL Database.</h4>

-- Table columns SQL start
select src.owner "Schema Name", src.table_name "Table Name", src.column_name "Column Name"
  from (select tc.owner, tc.table_name, tc.column_name, tc.column_id
		  from dba_tab_columns tc
		  join dba_tables t on tc.owner=t.owner and tc.table_name=t.table_name and t.temporary='N'
		 where tc.owner=upper(:'ora_schema')
	       and (tc.table_name not like 'DR$%' and tc.table_name not like 'BIN$%' and tc.table_name not like 'MLOG$%')
		   and t.table_name not in (select mview_name from dba_mviews where owner=upper(:'ora_schema'))) src
       left outer join
       (select ctb.relname as table_name,
			   att.attname as column_name,
			   att.attnum as column_id
		  from pg_class ctb
		  join pg_attribute att on att.attrelid = ctb.oid
		  join pg_namespace nsp on nsp.oid = ctb.relnamespace
		 where nsp.nspname = lower(:'pg_schema')
		   and att.attnum>=1) tgt
       ON lower(src.table_name)=tgt.table_name and lower(src.column_name)=tgt.column_name
 where tgt.column_name IS NULL
   and lower(src.table_name) in (select tb.relname from pg_class tb join pg_namespace ns on ns.oid = tb.relnamespace where ns.nspname = lower(:'pg_schema'))
 order BY 1,2;

-- Table columns SQL End

\qecho <br>
\qecho <br>
\qecho <p id="ObjectMismatch4" class="anchor"></p>
\qecho <h2>Missing Target Database Sequence</h2>
\qecho <br>

\qecho <li><a href="#ObjectMismatch3">Previous : </a><a href="#Top">Top : </a><a href="#ObjectMismatch5">Next</a></li>

\qecho <h4>This section identifies the sequences that exist in Oracle but are missing in PostgreSQL Database.</h4>

-- Sequence SQL start
select src.sequence_owner "Schema Name", src.sequence_name "Sequence Name", src.last_number "Last Sequence Value"
  from (select sequence_owner, sequence_name, last_number
		  from dba_sequences
		 where sequence_owner=upper(:'ora_schema')) src
       left outer join
       (select sequencename sequence_name, coalesce(last_value, start_value) last_number
		  from pg_sequences
		 where schemaname = lower(:'pg_schema')) tgt
       ON lower(src.sequence_name)=tgt.sequence_name
 where tgt.sequence_name IS NULL
 order BY 1,2;

-- Sequence SQL End


\qecho <br>
\qecho <br>
\qecho <p id="ObjectMismatch5" class="anchor"></p>
\qecho <h2>Sequence MAXVAL Comparision</h2>
\qecho <br>

\qecho <li><a href="#ObjectMismatch4">Previous : </a><a href="#Top">Top : </a><a href="#ObjectMismatch6">Next</a></li>

\qecho <h4>This section provides the last value of the sequence in Oracle Database when it is greater than the sequence value in PostgreSQL Database.</h4>

-- Sequence maxval SQL start
select src.sequence_owner "Schema Name", src.sequence_name "Sequence Name", src.last_number "Oracle Last Sequence Value",
       tgt.last_number "PostgreSQL Last Sequence Value"
  from (select sequence_owner, sequence_name, last_number
		  from dba_sequences
		 where sequence_owner=upper(:'ora_schema')) src
       join
       (select sequencename sequence_name, coalesce(last_value, start_value) last_number
		  from pg_sequences
		 where schemaname = lower(:'pg_schema')) tgt
       ON lower(src.sequence_name)=tgt.sequence_name
 where src.last_number>tgt.last_number
   and :{?seq_max_val_compare}
   -- and :'seq_max_val_compare' = 'Y'
 order BY 1,2;


-- Sequence maxval SQL End

\qecho <hr>
\qecho <p id="ObjectMismatch6" class="anchor"></p>
\qecho <h2 style="font-family:verdana">Database Constraint Details</h2>
\qecho <p id="Constraints1" class="anchor"></p>
\qecho <h2>Missing Target Database Primary key</h2>
\qecho <br>
\qecho <li><a href="#ObjectMismatch5">Previous : </a><a href="#Top">Top : </a><a href="#Constraints2">Next</a></li>

\qecho <h4>This section identifies the Primary Key constraint that exist in Oracle but are missing in PostgreSQL Database.</h4>


-- Primary key SQL start
select src.owner "Schema Name", src.table_name "Table Name", src.constraint_name "Primary Key", src.cons_col as "Constraint Column"
  from (select c.owner, c.table_name table_name,
		       c.constraint_name, '{'||STRING_AGG(coalesce(t.column_id,0)::text, ',' order by c.position)||'}' conkey,
			   '{'||STRING_AGG(coalesce(t.column_name,'')::text, ',' order by c.position)||'}' cons_col
		  from (select cl.owner, cl.table_name, cl.constraint_name, cs.constraint_type, cl.column_name, cl.position
				  from dba_constraints cs, dba_cons_columns cl
			     where cs.owner=upper(:'ora_schema')
				   and cs.CONSTRAINT_TYPE IN ('P')
				   and cl.owner = cs.owner
				   and cl.constraint_name = cs.constraint_name) c,
			   (select tc.owner, tc.table_name, tc.column_name, tc.column_id
			      from dba_tables t, dba_tab_columns tc
			     where t.owner=upper(:'ora_schema')
				   and t.owner=tc.owner and t.table_name=tc.table_name and t.temporary='N'
			       and (t.table_name not like 'DR$%' and t.table_name not like 'BIN$%' and t.table_name not like 'MLOG$%')
			       and t.table_name not in (select mview_name from dba_mviews where owner=upper(:'ora_schema'))) t
		  where t.owner=c.owner and t.table_name=c.table_name and c.column_name=t.column_name
		 group by c.owner, c.table_name, c.constraint_name) src
       left outer join
       (select cls.relname table_name, cons.conname constraint_name, cons.conkey::text conkey
		  from pg_constraint cons
		  join pg_class cls on cons.conrelid = cls.oid
		  join pg_namespace nsp on nsp.oid = cls.relnamespace
		 where nsp.nspname = lower(:'pg_schema')) tgt
       ON lower(src.table_name)=tgt.table_name and src.conkey=tgt.conkey
 where tgt.constraint_name IS NULL
   and lower(src.table_name) in (select tb.relname from pg_class tb join pg_namespace ns on ns.oid = tb.relnamespace where ns.nspname = lower(:'pg_schema'))
 order BY 1,2;

-- Primary key  SQL End



\qecho <br>
\qecho <br>
\qecho <p id="Constraints2A" class="anchor"></p>
\qecho <h2>Missing Target Database Foreign Reference</h2>
\qecho <br>
\qecho <li><a href="#Constraints1">Previous : </a><a href="#Top">Top : </a><a href="#Constraints2">Next</a></li>
\qecho <h4>This section identifies the Foreign Key constraint that exist in Oracle but are missing in PostgreSQL Database.</h4>

-- Foreign Reference SQL start
select src.owner "Schema Name", src.table_name "Table Name", src.constraint_name "Foreign Key", src.cons_col as "Constraint Column"
  from (select c.owner, c.table_name table_name,
		       c.constraint_name, '{'||STRING_AGG(coalesce(t.column_id,0)::text, ',' order by c.position)||'}' conkey,
			   '{'||STRING_AGG(coalesce(t.column_name,'')::text, ',' order by c.position)||'}' cons_col
		  from (select cl.owner, cl.table_name, cl.constraint_name, cs.constraint_type, cl.column_name, cl.position
				  from dba_constraints cs, dba_cons_columns cl
			     where cs.owner=upper(:'ora_schema')
				   and cs.CONSTRAINT_TYPE IN ('R')
				   and cl.owner = cs.owner
				   and cl.constraint_name = cs.constraint_name) c,
			   (select tc.owner, tc.table_name, tc.column_name, tc.column_id
			      from dba_tables t, dba_tab_columns tc
			     where t.owner=upper(:'ora_schema')
				   and t.owner=tc.owner and t.table_name=tc.table_name and t.temporary='N'
			       and (t.table_name not like 'DR$%' and t.table_name not like 'BIN$%' and t.table_name not like 'MLOG$%')
			       and t.table_name not in (select mview_name from dba_mviews where owner=upper(:'ora_schema'))) t
		  where t.owner=c.owner and t.table_name=c.table_name and c.column_name=t.column_name
		 group by c.owner, c.table_name, c.constraint_name) src
       left outer join
       (select cls.relname table_name, cons.conname constraint_name, cons.conkey::text conkey
		  from pg_constraint cons
		  join pg_class cls on cons.conrelid = cls.oid
		  join pg_namespace nsp on nsp.oid = cls.relnamespace
		 where nsp.nspname = lower(:'pg_schema')) tgt
       ON lower(src.table_name)=tgt.table_name and src.conkey=tgt.conkey
 where tgt.constraint_name IS NULL
   and lower(src.table_name) in (select tb.relname from pg_class tb join pg_namespace ns on ns.oid = tb.relnamespace where ns.nspname = lower(:'pg_schema'))
 order BY 1,2;




-- Foreign Reference SQL End


\qecho <br>
\qecho <br>
\qecho <p id="Constraints2" class="anchor"></p>
\qecho <h2>Missing Target Database Unique Constraint</h2>
\qecho <br>
\qecho <li><a href="#Constraints2A">Previous : </a><a href="#Top">Top : </a><a href="#Constraints3">Next</a></li>
\qecho <h4>This section identifies the Unique Key constraint that exist in Oracle but are missing/mismatch in PostgreSQL Database.</h4>

-- Unique SQL start
select src.owner "Schema Name", src.table_name "Table Name", src.constraint_name "Unique Key", src.cons_col as "Constraint Column"
  from (select c.owner, c.table_name table_name,
		       c.constraint_name, '{'||STRING_AGG(coalesce(t.column_id,0)::text, ',' order by c.position)||'}' conkey,
			   '{'||STRING_AGG(coalesce(t.column_name,'')::text, ',' order by c.position)||'}' cons_col
		  from (select cl.owner, cl.table_name, cl.constraint_name, cs.constraint_type, cl.column_name, cl.position
				  from dba_constraints cs, dba_cons_columns cl
			     where cs.owner=upper(:'ora_schema')
				   and cs.CONSTRAINT_TYPE IN ('U')
				   and cl.owner = cs.owner
				   and cl.constraint_name = cs.constraint_name) c,
			   (select tc.owner, tc.table_name, tc.column_name, tc.column_id
			      from dba_tables t, dba_tab_columns tc
			     where t.owner=upper(:'ora_schema')
				   and t.owner=tc.owner and t.table_name=tc.table_name and t.temporary='N'
			       and (t.table_name not like 'DR$%' and t.table_name not like 'BIN$%' and t.table_name not like 'MLOG$%')
			       and t.table_name not in (select mview_name from dba_mviews where owner=upper(:'ora_schema'))) t
		  where t.owner=c.owner and t.table_name=c.table_name and c.column_name=t.column_name
		 group by c.owner, c.table_name, c.constraint_name) src
       left outer join
       (select cls.relname table_name, cons.conname constraint_name, cons.conkey::text conkey
		  from pg_constraint cons
		  join pg_class cls on cons.conrelid = cls.oid
		  join pg_namespace nsp on nsp.oid = cls.relnamespace
		 where nsp.nspname = lower(:'pg_schema')) tgt
       ON lower(src.table_name)=tgt.table_name and src.conkey=tgt.conkey
 where tgt.constraint_name IS NULL
   and lower(src.table_name) in (select tb.relname from pg_class tb join pg_namespace ns on ns.oid = tb.relnamespace where ns.nspname = lower(:'pg_schema'))
 order BY 1,2;


-- Unique SQL End


\qecho <br>
\qecho <br>
\qecho <p id="Constraints3" class="anchor"></p>
\qecho <h2>Missing Target Database Check Constraints</h2>
\qecho <br>
\qecho <li><a href="#Constraints2">Previous : </a><a href="#Top">Top : </a><a href="#Constraints4">Next</a></li>
\qecho <h4>This section identifies the Foreign Key constraint that exist in Oracle but are missing/mismatch in PostgreSQL Database.</h4>

-- Check SQL start
select distinct src.owner "Schema Name", src.table_name "Table Name",  coalesce(src.cnt,0) "Oracle Check Constraint Count", coalesce(tgt.cnt,0) "PostgreSQL Check Constraint Count"
  from (select c.owner, c.table_name, c.constraint_name, count(*) over (partition by c.table_name) cnt
		  from dba_constraints c
		  join dba_tables t on c.owner=t.owner and c.table_name=t.table_name and t.temporary='N'
		 where c.owner=upper(:'ora_schema')
		   and c.constraint_type='C'
		   and upper(c.search_condition) not like '%IS NOT NULL' -- Research
		   and (t.table_name not like 'DR$%' and t.table_name not like 'BIN$%' and t.table_name not like 'MLOG$%')
		   and t.table_name not in (select mview_name from dba_mviews where owner=upper(:'ora_schema'))) src
       full outer join
       (select cls.oid::regclass::text table_name,
			   pgc.conname as constraint_name,
			   count(*) over (partition by cls.oid) cnt
		  from pg_constraint pgc
		  join pg_namespace nsp on nsp.oid = pgc.connamespace
		  join pg_class  cls on pgc.conrelid = cls.oid
		 where nsp.nspname = lower(:'pg_schema')
		   and pgc.contype = 'c') tgt
       ON lower(src.owner|| '.'||src.table_name)=tgt.table_name and (lower(src.constraint_name)=tgt.constraint_name)
 where coalesce(tgt.cnt,0) <> coalesce(src.cnt,0)
   and lower(src.table_name) in (select tb.relname from pg_class tb join pg_namespace ns on ns.oid = tb.relnamespace where ns.nspname = lower(:'pg_schema'))
 order BY 1,2;

-- Check SQL End


\qecho <br>
\qecho <br>
\qecho <p id="Constraints4" class="anchor"></p>
\qecho <h2>Missing Nullable Constraints</h2>
\qecho <br>
\qecho <li><a href="#Constraints3">Previous : </a><a href="#Top">Top : </a><a href="#Constraints5">Next</a></li>
\qecho <h4>This section identifies the Null Column constraint that exist in Oracle but are missing/mismatch in PostgreSQL Database.</h4>

-- Not Null SQL start
select src.owner "Schema Name", src.table_name "Table Name", src.column_name "Column Name", src.nullable "Column Nullable"
  from (select tc.owner, tc.table_name, tc.column_name, case when tc.nullable='Y' then 'Yes' else 'No' end as nullable
		  from dba_tab_columns tc
		  join dba_tables t on tc.owner=t.owner and tc.table_name=t.table_name and t.temporary='N'
		 where tc.owner=upper(:'ora_schema')
	       and (tc.table_name not like 'DR$%' and tc.table_name not like 'BIN$%' and tc.table_name not like 'MLOG$%')
		   and t.table_name not in (select mview_name from dba_mviews where owner=upper(:'ora_schema'))) src
       left outer join
       (select ctb.relname as table_name,
			   att.attname as column_name,
			   case when att.attnotnull then 'No' else 'Yes' end as nullable
		  from pg_class ctb
		  join pg_attribute att on att.attrelid = ctb.oid
		  join pg_namespace nsp on nsp.oid = ctb.relnamespace
		 where nsp.nspname = lower(:'pg_schema')
		   and att.attnum>=1) tgt
       ON lower(src.table_name)=tgt.table_name and lower(src.column_name)=tgt.column_name
 where src.nullable!=tgt.nullable
   and lower(src.table_name) in (select tb.relname from pg_class tb join pg_namespace ns on ns.oid = tb.relnamespace where ns.nspname = lower(:'pg_schema'))
 order BY 1,2;

-- Not Null SQL End


\qecho <br>
\qecho <br>
\qecho <p id="Constraints5" class="anchor"></p>
\qecho <h2>Mismatch Default Constraints</h2>
\qecho <br>
\qecho <li><a href="#Constraints4">Previous : </a><a href="#Top">Top : </a><a href="#ObjectMismatch7">Next</a></li>
\qecho <h4>This section identifies count of Columns with default constraint for a table, that exist in Oracle Database but do not match with the table in PostgreSQL Database.</h4>

-- Default SQL start
select src.owner "Schema Name", src.table_name "Table Name", coalesce(src.cnt,0) "Oracle Default Columns Count"
, coalesce(tgt.cnt,0) "PostgreSQL Default Columns Count"
  from (select tc.owner, tc.table_name, count(*) cnt
		  from dba_tab_columns tc
		  join dba_tables t on tc.owner=t.owner and tc.table_name=t.table_name and t.temporary='N'
		 where tc.owner=upper(:'ora_schema')
		   and (tc.table_name not like 'DR$%' and tc.table_name not like 'BIN$%' and tc.table_name not like 'MLOG$%')
		   and t.table_name not in (select mview_name from dba_mviews where owner=upper(:'ora_schema'))
		   and tc.data_default is not null
		 group by tc.owner, tc.table_name) src
       left outer join
       (select table_schema, table_name, count(*) cnt
		  from information_schema.columns
		 where table_schema=lower(:'pg_schema')
		   and column_default is not null
		 group by table_schema, table_name) tgt
       ON lower(src.table_name)=tgt.table_name --and src.cnt!=tgt.cnt
 where 1=1--tgt.table_name is null
	and coalesce(src.cnt,0) <> coalesce(tgt.cnt,0)
   and lower(src.table_name) in (select tb.relname from pg_class tb join pg_namespace ns on ns.oid = tb.relnamespace where ns.nspname = lower(:'pg_schema'))
 order BY 1,2;

-- Default SQL End


\qecho <br>
\qecho <br>
\qecho <p id="ObjectMismatch7" class="anchor"></p>
\qecho <h2>Materialized View</h2>
\qecho <br>

\qecho <li><a href="#ObjectMismatch6">Previous : </a><a href="#Top">Top : </a><a href="#ObjectMismatch8">Next</a></li>
\qecho <h4>This section identifies Materilized Views in Oracle Database that do not exist/match in PostgreSQL Database.</h4>

-- MView SQL start
select src.owner "Schema Name", src.mview_name "MView Name",
	   src.refresh_method "Refresh Method"
  from (select owner, mview_name, refresh_method
		  from dba_mviews
		 where owner=upper(:'ora_schema')) src
	   left outer join
	   (select matviewname mview_name, 'COMPLETE' refresh_method
		  from pg_matviews
		 where schemaname=lower(:'pg_schema')) tgt
		on lower(src.mview_name)=tgt.mview_name and src.refresh_method=tgt.refresh_method
 where tgt.mview_name IS NULL
 order BY 1,2;

-- MView SQL End


\qecho <br>
\qecho <br>
\qecho <p id="ObjectMismatch8" class="anchor"></p>
\qecho <h2>Type</h2>
\qecho <br>

\qecho <li><a href="#ObjectMismatch7">Previous : </a><a href="#Top">Top : </a><a href="#ObjectMismatch9">Next</a></li>
\qecho <h4>This section identifies Type in Oracle Database that do not exist/match in PostgreSQL Database.</h4>

-- Type SQL start
select src.owner "Schema Name", src.object_name "Type Name",
	   src.status "Type Status"
  from (select owner, object_name,
			   status
		  from dba_objects
		 where owner=upper(:'ora_schema')
		   and object_type='TYPE') src
		left outer join
	   (select cls.relname object_name
		  from pg_class cls
		  join pg_namespace nsp ON nsp.oid = cls.relnamespace
		 where nsp.nspname = lower(:'pg_schema')
		   and cls.relkind = 'c') tgt
		on lower(src.OBJECT_name)=tgt.object_name
 where tgt.object_name IS NULL
 order BY 1,2;

-- Type SQL End



\qecho <br>
\qecho <br>
\qecho <p id="ObjectMismatch9" class="anchor"></p>
\qecho <h2>View</h2>
\qecho <br>

\qecho <li><a href="#ObjectMismatch8">Previous : </a><a href="#Top">Top : </a><a href="#ObjectMismatch10">Next</a></li>
\qecho <h4>This section identifies Views in Oracle Database that do not exist/match in PostgreSQL Database.</h4>

-- View SQL start
SELECT src.owner "Schema Name", src.object_name "View Name",
	   src.status "View Status"
  FROM (SELECT owner, object_name,
			   status
		  FROM dba_objects
		 WHERE owner=upper(:'ora_schema')
		   AND object_type='VIEW') src
		LEFT OUTER join
	   (SELECT viewname object_name
		  FROM pg_views
		 WHERE schemaname=lower(:'pg_schema')) tgt
		on lower(src.OBJECT_name)=tgt.object_name
 WHERE tgt.object_name IS NULL
 ORDER BY 1,2;


-- View SQL End


\qecho <br>
\qecho <br>
\qecho <p id="ObjectMismatch10" class="anchor"></p>
\qecho <h2>Trigger</h2>
\qecho <br>

\qecho <li><a href="#ObjectMismatch9">Previous : </a><a href="#Top">Top : </a><a href="#Databaseobjects3">Next</a></li>
\qecho <h4>This section identifies Triggers in Oracle Database that do not exist/match in PostgreSQL Database.</h4>

-- Trigger SQL start
select src.owner "Schema Name", src.object_name "Trigger Name",
	   src.status "Trigger Status"
  from (select owner, object_name,
			   status
		  from dba_objects
		 where owner=upper(:'ora_schema')
		   and object_type='TRIGGER') src
		left outer join
	   (select trigger_name object_name
		  from information_schema.triggers
		 where event_object_schema=lower(:'pg_schema')) tgt
		on lower(src.OBJECT_name)=tgt.object_name
 where tgt.object_name IS NULL
 order BY 1,2;

-- Trigger SQL End


\qecho <br>
\qecho <br>
\qecho <p id="Databaseobjects3" class="anchor"></p>
\qecho <h2>Oracle Package as PostreSQL Schema comparision </h2>
\qecho <br>
\qecho <li><a href="#Databaseobjects2">Previous : </a><a href="#Top">Top : </a><a href="#Databaseobjects4">Next</a></li>
\qecho <h4>During Oracle to PostgreSQL conversion, Packages in Oracle are converted to Schemas in PostgreSQL Database.</h4>
\qecho <h4>This section identifies those Packages in Oracle Database that do not have a schema in PostgreSQL Database.</h4>

-- Package to Schema names SQL start
SELECT src.owner "Schema Name", src.object_name "Package Name"
  FROM (SELECT owner, object_name
		  FROM dba_objects
		 WHERE owner=upper(:'ora_schema')
	       and object_type in ('PACKAGE')) src
       LEFT OUTER JOIN
       (select nspname object_name
		  from pg_namespace) tgt
       ON lower(src.object_name)=tgt.object_name
 WHERE tgt.object_name IS NULL
   AND :{?code_compare}
   -- and :'code_compare' = 'Y'
 ORDER BY 1,2;
-- Package to Schema names SQL End

\qecho <br>
\qecho <h2>Package body object comparision </h2>
\qecho <h4>This section identifies public procedures and functions defined in Package specification of an Oracle Database that do not exist in the schema of a PostgreSQL Database.</h4>

SELECT src.owner "Schema Name", src.object_type "Object Type", src.object_name "Package Name", src.procedure_name "Object Name"
FROM (select owner , object_name , 'PACKAGE-OBJ' as object_type , procedure_name  , NULL
 from all_procedures
 where owner = :'ora_schema'
 and object_name IN
 (SELECT  object_name
		  FROM dba_objects
		 WHERE owner=upper(:'ora_schema')
	       and object_type in ('PACKAGE')) and procedure_name is not null) src
		   LEFT OUTER JOIN
		   (select nsp.nspname as owner, case when pr.prokind='p' then 'procedure' else 'function' end as object_type, pr.proname object_name
		  from pg_proc pr
		  join pg_namespace nsp on nsp.oid = pr.pronamespace
		 where nsp.nspname IN (SELECT lower(object_name)
		  FROM dba_objects
		 WHERE owner=upper(:'ora_schema')
	       and object_type in ('PACKAGE'))) tgt
		on lower(src.procedure_name)=tgt.object_name
		and lower(src.object_name)=tgt.owner
		where :{?code_compare};
		-- and :'code_compare' = 'Y';

\qecho <br>
\qecho <br>
\qecho <p id="Databaseobjects4" class="anchor"></p>
\qecho <h2>Procedures and Functions </h2>
\qecho <br>
\qecho <li><a href="#Databaseobjects3">Previous : </a><a href="#Top">Top : </a><a href="#DataType1">Next</a></li>
\qecho <h4>This section identifies procedures and functions in Oracle Database that do not exist in PostgreSQL Database.<h4>
-- Procedures and Functions SQL start
select src.owner "Schema Name", src.object_type "Object Type", src.object_name "Object Name", src.status "Object Status"
  from (select owner, object_type, object_name, status
		  from dba_objects
		 where owner=upper(:'ora_schema')
	       and object_type in ('FUNCTION', 'PROCEDURE')) src
       left outer join
       (select case when pr.prokind='p' then 'procedure' else 'function' end as object_type, pr.proname object_name
		  from pg_proc pr
		  join pg_namespace nsp on nsp.oid = pr.pronamespace
		 where nsp.nspname = lower(:'pg_schema')) tgt
       ON lower(src.object_name)=tgt.object_name
 where tgt.object_name IS NULL
   and :{?code_compare}
   -- and :'code_compare' = 'Y'
 order BY 1,2;

-- Procedures and Functions SQL End

\qecho <hr>
\qecho <p id="DataType" class="anchor"></p>
\qecho <h2 style="font-family:verdana">Data Type</h2>
\qecho <p id="DataType1" class="anchor"></p>
\qecho <h2>Data Type Mapping Matrix </h2>
\qecho <br>
\qecho <li><a href="#Databaseobjects4">Previous : </a><a href="#Top">Top : </a><a href="#Data1">Next</a></li>
\qecho <h4>This section display of Column data type Matrix for Tables in Oracle and PostgreSQL Database.<h4>

-- Data Type Mapping Matrix SQL start
WITH ORACLE AS
(SELECT lower(OWNER) as owner , lower(TABLE_NAME) as table_name , lower(COLUMN_NAME) as column_name, DATA_TYPE ,
CASE WHEN DATA_TYPE IN ('VARCHAR2','CHAR','BLOB','LONG','DATE') THEN NULL ELSE DATA_LENGTH END AS DATA_LENGTH,
DATA_PRECISION ,
DATA_SCALE
FROM dba_tab_columns
WHERE OWNER = UPPER(:'ora_schema')
and table_name not in (select dba_objects.OBJECT_NAME from dba_objects where  object_type = 'VIEW' AND dba_objects.owner = UPPER(:'ora_schema'))
 ORDER BY DATA_TYPE) ,
 postgresql as
 ( select table_schema , table_name , column_name ,
 case when data_type like 'numeric' then (SELECT (select pg_catalog.format_type(a.atttypid, a.atttypmod) from pg_catalog.pg_attribute a WHERE a.attrelid = c.oid AND a.attname = column_name )
FROM pg_catalog.pg_class c LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
WHERE c.relname = table_name
  AND n.nspname = table_schema) else data_type end as data_type
    from information_schema.columns where table_schema = lower(:'pg_schema'))
 SELECT distinct ORACLE.DATA_TYPE ||
 CASE WHEN ORACLE.DATA_PRECISION IS NOT NULL AND  ORACLE.DATA_SCALE IS NOT NULL THEN '(' || ORACLE.DATA_PRECISION ||  ',' ||  ORACLE.DATA_SCALE || ')'
 WHEN ORACLE.DATA_PRECISION IS NOT NULL AND  ORACLE.DATA_SCALE IS  NULL THEN '(' || ORACLE.DATA_PRECISION || ')'
  WHEN ORACLE.DATA_PRECISION IS  NULL AND  ORACLE.DATA_SCALE IS  NOT NULL THEN '(' || '*' ||  ',' ||  ORACLE.DATA_SCALE || ')'
 ELSE '' END as "Oracle Data Type",
postgresql.data_type  as "PostgreSQL Data Type"
 FROM ORACLE inner join postgresql
 on  ORACLE.table_name = postgresql.table_name
 and oracle.column_name = postgresql.column_name;

-- Data Type Mapping Matrix SQL End

\qecho <p id="DataType2" class="anchor"></p>
\qecho <h2>Data Type Mapping Matrix for Primary and Foreign key </h2>
\qecho <br>
\qecho <li><a href="#DataType1">Previous : </a><a href="#Top">Top : </a><a href="#Data1">Next</a></li>
\qecho <h4>This section shows the data type mismatch between Parent(Primary/Unique Key) and Child keys(Foreign Key) in PostgreSQL Database.</h4>

-- Data Type Mapping PK\FK Matrix SQL start
select upper(pa.table_schema) "Parent Schema", upper(pa.table_name) "Parent Table Name", upper(pa.column_name) "Parent Column name", format_type(paa.atttypid, paa.atttypmod) "PostgreSQL Parent Data type",
       upper(ch.table_schema) "Child Schema",  upper(ch.table_name) "Child Table Name",  upper(ch.column_name) "Child Column name",  format_type(cha.atttypid, cha.atttypmod) "PostgreSQL Child Data type"
  from information_schema.columns ch, pg_attribute cha, pg_class chc, pg_namespace chn,
       information_schema.columns pa, pg_attribute paa, pg_class pac, pg_namespace pan,
       (select chc.owner chc_owner, chc.table_name chc_table_name, chc.column_name chc_column_name, pac.owner pac_owner, pac.table_name pac_table_name, pac.column_name pac_column_name
          from (select ch.owner, ch.constraint_name, ch.table_name, ch_cc.column_name, ch_cc.position, ch.r_owner, ch.r_constraint_name
                  from dba_constraints ch, dba_cons_columns ch_cc
                 where ch.owner=UPPER(:'ora_schema') and ch.constraint_type='R'
                   and ch.owner=ch_cc.owner and ch.constraint_name=ch_cc.constraint_name and ch.table_name=ch_cc.table_name) chc,
               (select pa.owner, pa.constraint_name, pa.table_name, pa_cc.column_name, pa_cc.position
                  from dba_constraints pa, dba_cons_columns pa_cc
                 where pa.owner=UPPER(:'ora_schema') and pa.constraint_type in ('P','U')
                   and pa.owner=pa_cc.owner and pa.constraint_name=pa_cc.constraint_name and pa.table_name=pa_cc.table_name) pac
         where chc.r_owner=pac.owner and chc.r_constraint_name=pac.constraint_name and chc.position=pac.position) ora_tbl
 where ch.table_name=lower(ora_tbl.chc_table_name) and ch.column_name=lower(ora_tbl.chc_column_name)
   and pa.table_name=lower(ora_tbl.pac_table_name) and pa.column_name=lower(ora_tbl.pac_column_name)
   and chc.oid = cha.attrelid and chc.relname = ch.table_name and cha.attname=ch.column_name
   and paa.attrelid = pac.oid and pac.relname = pa.table_name and paa.attname=pa.column_name
   and chn.oid = chc.relnamespace and chn.nspname=lower(:'pg_schema')
   and pan.oid = pac.relnamespace and pan.nspname=lower(:'pg_schema')
   and format_type(paa.atttypid, paa.atttypmod)!=format_type(cha.atttypid,cha.atttypmod)
order by 1,2,3;

-- Data Type Mapping PK\FK Matrix SQL End

\echo Running Database Migration special consideration.
\qecho <hr>
\qecho <p id="MigrationAnomalies" class="anchor"></p>
\qecho <h2 style="font-family:verdana">Migration Anomalies</h2>
\qecho <p id="MigrationAnomalies1" class="anchor"></p>
\qecho <h2>Partition column not part of Primary key </h2>
\qecho <br>
\qecho <li><a href="#Data1">Previous : </a><a href="#Top">Top : </a><a href="#MigrationAnomalies2">Next</a></li>
\qecho <h4>This section identifies Primary keys that is missing Partition key column for Partitioned tables in Oracle Database.</h4>

-- Partition column not part of Primary key SQL start
WITH ALIAS1 AS
(SELECT TABS.OWNER , TABS.TABLE_NAME , PCOLS.COLUMN_NAME AS PART_COLS ,
STRING_AGG(PK_CONS.column_name,',' ORDER BY PK_CONS.position) AS PK_SET  FROM dba_tables TABS, dba_part_key_columns PCOLS ,
(
select
   all_cons_columns.owner as schema_name,
   all_cons_columns.table_name,
   all_cons_columns.column_name,
   all_cons_columns.position,
   all_constraints.status
from dba_constraints all_constraints, dba_cons_columns all_cons_columns
where
   all_constraints.constraint_type = 'P'
   and all_constraints.constraint_name = all_cons_columns.constraint_name
   and all_constraints.owner = all_cons_columns.owner
order by
   all_cons_columns.owner,
   all_cons_columns.table_name,
   all_cons_columns.position) PK_CONS
WHERE
TABS.PARTITIONED = 'YES' AND TABS.OWNER = upper(:'ora_schema')
AND PCOLS.NAME = TABS.TABLE_NAME
AND PK_CONS.schema_name = TABS.OWNER
AND PK_CONS.table_name = TABS.TABLE_NAME
GROUP BY TABS.OWNER , TABS.TABLE_NAME , PCOLS.COLUMN_NAME)
SELECT OWNER as "Schema Name" ,TABLE_NAME as "Table Name" , PART_COLS as "Partition Column" ,
PK_SET as "Primary Column" FROM ALIAS1 WHERE  strpos(PK_SET,PART_COLS) = 0;


-- Partition column not part of Primary key SQL End

\qecho <br>
\qecho <br>
\qecho <p id="MigrationAnomalies2" class="anchor"></p>
\qecho <h2>Unique on Composite column with nullable constraint on either </h2>
\qecho <br>
\qecho <li><a href="#MigrationAnomalies1">Previous : </a><a href="#Top">Top : </a><a href="#MigrationAnomalies3">Next</a></li>
\qecho <h4>This section identifies Unique index as composite indexes with nullable constraint in Oracle Database.</h4>

-- https://aws.amazon.com/blogs/database/how-to-solve-some-common-challenges-faced-while-migrating-from-oracle-to-postgresql/#:~:text=Null%20behavior%20in%20composite%20unique%20index

-- Unique index as composite indexes with nullable constraint on column SQL start
WITH ALIAS1 AS
(SELECT TABS.OWNER , TABS.TABLE_NAME  , constraint_name ,
STRING_AGG(UK_CONS.column_name,',' ORDER BY UK_CONS.position) AS COMPOSITE_UNIQUE_COLUMN ,
STRING_AGG(CASE WHEN TABS.NULLABLE = 'Y' THEN UK_CONS.column_name END , ',' ORDER BY UK_CONS.position) AS NULLABLE_UNIQUE_COLUMN
FROM dba_tab_columns TABS,
(
select
all_cons_columns.owner as schema_name,
all_cons_columns.table_name,
all_cons_columns.column_name,
all_cons_columns.position,
all_constraints.status,
all_constraints.constraint_name
from dba_constraints all_constraints, dba_cons_columns all_cons_columns
where
all_constraints.constraint_type = 'U'
and all_constraints.constraint_name = all_cons_columns.constraint_name
and all_constraints.owner = all_cons_columns.owner
order by
all_cons_columns.owner,
all_cons_columns.table_name,
all_cons_columns.position) UK_CONS
WHERE  TABS.OWNER = upper(:'ora_schema')
AND UK_CONS.schema_name = TABS.OWNER
AND UK_CONS.table_name = TABS.TABLE_NAME
AND UK_CONS.column_name = TABS.COLUMN_NAME
GROUP BY TABS.OWNER , TABS.TABLE_NAME , constraint_name )
SELECT OWNER as "Schema Name" , TABLE_NAME as "Table Name" , constraint_name as "Constraint Name" ,
COMPOSITE_UNIQUE_COLUMN as "Unique Columns" , NULLABLE_UNIQUE_COLUMN as "Nullable Column" FROM ALIAS1 WHERE  strpos(COMPOSITE_UNIQUE_COLUMN,NULLABLE_UNIQUE_COLUMN) > 0;


-- Unique index as composite indexes with nullable constraint on column SQL End


\qecho <br>
\qecho <br>
\qecho <p id="MigrationAnomalies3" class="anchor"></p>
\qecho <h2>User Created Extended Statistics </h2>
\qecho <br>
\qecho <li><a href="#MigrationAnomalies2">Previous : </a><a href="#Top">Top : </a><a href="#MigrationAnomalies2">Next</a></li>
\qecho <h4>This section identifies those tables in Oracle Database that have extended statistics.</h4>

-- User Created Extended Statistics SQL start
select OWNER as "Schema Name", TABLE_NAME as "Table Name", EXTENSION_NAME as "Statistics Extension Name", EXTENSION as "Extended Stat Details" from DBA_STAT_EXTENSIONS where owner = upper(:'ora_schema') AND CREATOR <> 'SYSTEM';

-- User Created Extended Statistics SQL End

\qecho <br>
\qecho <br>
\qecho <p id="MigrationAnomalies4" class="anchor"></p>
\qecho <h2>Default on NULLs </h2>
\qecho <br>
\qecho <li><a href="#MigrationAnomalies3">Previous : </a><a href="#Top">Top : </a><a href="#MigrationAnomalies3">Next</a></li>
\qecho <h4>This section identifies tables column that have default Values on Null Constraint in Oracle Database.</h4>

-- Default on NULLs SQL start
WITH ORACLE AS
(SELECT OWNER as "Schema Name", TABLE_NAME as "Table Name", COLUMN_NAME as "Column Name", DEFAULT_ON_NULL as "Default on Null", NULLABLE as "Null Detail", DATA_DEFAULT as "Data on Null"
FROM dba_tab_columns
WHERE OWNER = upper(:'ora_schema')
and DEFAULT_ON_NULL = 'YES'
and table_name not in (select dba_objects.OBJECT_NAME from dba_objects where  object_type = 'VIEW' AND dba_objects.owner = UPPER(:'ora_schema')))
SELECT * FROM ORACLE;

-- Default on NULLs SQL End

\qecho <br>
\qecho <br>
\qecho <p id="MigrationAnomalies5" class="anchor"></p>
\qecho <h2>Database Identifiers Greater length > 63</h2>
\qecho <br>
\qecho <li><a href="#MigrationAnomalies4">Previous : </a><a href="#Top">Top : </a></li>
\qecho <h4>This section identifies Oracle Database objects, with identifier name length greater than 63 characters.</h4>

-- Identifiers greater then 63 Start
SELECT Upper(object_type) as "Object Type",
       Upper(owner) AS "Schema Name",
       object_name as "Object Name",
       '' AS "Table Name",
       Length(object_name) as "Identifier Length"
FROM   dba_objects
WHERE  Length(object_name) > 63
       AND owner =  upper(:'ora_schema')
UNION ALL
SELECT CASE Lower(object_type)  WHEN 'table' THEN 'TABLE-COLUMN' ELSE
                                       'VIEW-COLUMN' END ,
       Upper(dba_objects.owner),
       column_name,
       table_name,
       Length(column_name)
FROM   dba_tab_columns , dba_objects
WHERE object_name = dba_tab_columns.table_name and dba_objects.owner = dba_tab_columns.owner
 and Length(column_name) > 63
       AND dba_tab_columns.owner =  upper(:'ora_schema') ;

-- Identifiers greater then 63 End

\qecho <h1 style="font-family:verdana"align="center"><u>End Report </u></h1>
\echo :htmlfile Validation report can be found in current directory
\echo
\echo
