
drop schema if exists oracle_schema_compare cascade;

create schema if not exists oracle_schema_compare;

create extension if not exists oracle_fdw;

DROP SERVER IF EXISTS oradb CASCADE;

DROP USER MAPPING IF EXISTS FOR :pgdbuser SERVER oradb;

CREATE SERVER oradb FOREIGN DATA WRAPPER oracle_fdw OPTIONS (dbserver:'oracledetails');

CREATE USER MAPPING FOR :pgdbuser SERVER oradb OPTIONS (user:'oracledbuser', password :'oracledbpwsd');

IMPORT FOREIGN SCHEMA "SYS" LIMIT TO (DBA_SEGMENTS, DBA_OBJECTS, DBA_INDEXES, DBA_IND_COLUMNS, DBA_CONSTRAINTS, DBA_CONS_COLUMNS, GLOBAL_NAME, DBA_TABLES, DBA_IND_EXPRESSIONS,
DBA_IND_PARTITIONS, DBA_TAB_COLUMNS, DBA_SEQUENCES, DBA_TAB_PARTITIONS, DBA_PART_KEY_COLUMNS, DBA_MVIEWS, V_$NLS_PARAMETERS, DBA_STAT_EXTENSIONS, V_$VERSION, ALL_PROCEDURES, 
ALL_ARGUMENTS) FROM SERVER oradb INTO oracle_schema_compare;

