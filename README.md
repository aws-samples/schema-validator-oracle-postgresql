## Schema and code validator for Oracle to Amazon RDS for PostgreSQL or Amazon Aurora PostgreSQL migration

The solution uses the oracle_fdw extension, available with Aurora PostgreSQL or Amazon RDS for PostgreSQL, to query Oracle metadata tables or views and compare them with PostgreSQL. The oracle_fdw PostgreSQL extension provides a Foreign Data Wrapper for easy and efficient access to Oracle databases. For additional details, refer to Connect to Oracle from Amazon RDS for PostgreSQL using the oracle_fdw. In this post, we perform the following high-level implementation steps:

## Installation and Execution

1. Install the oracle_fdw extension and configure foreign tables for Oracle metadata views or tables (installer_ora_fdw.sql).

Using the psql command line, we initiate installation with the following command:
```
PGPASSWORD=<pg_password>

psql -h <postgresql endpoint> -d <postgresql database> -U <postgresql user> -v pgdbuser=<postgresql mapping user> -v oracledetails=//<oracle hostname>:<oracleport>/<sid> -v oracledbuser=<oracle username> -v oracledbpwsd=<oracle password> -f installer_ora_fdw.sql
```
For Example:
psql -h demoapg.cluster-abcdefg123456.us-west-2.rds.amazonaws.com -d dms_sample -U postgres -v pgdbuser=postgres -v oracledetails=//10.1.1.178:1521/oradev -v oracledbuser=dms_sample -v oracledbpwsd=dms_sample -f installer_ora_fdw.sql

We use the following parameters:
```
* <postgresql user> – RDS for PostgreSQL primary user
* <pg_password> – Password for PostgreSQL user
* <postgresql endpoint> – Writer endpoint for PostgreSQL cluster
* <postgresql database> – PostgreSQL database that is used to create the objects required by schema and code validator
* <postgresql mapping user> – Same as <postgresql user>
* <oracle hostname> – IP address or DNS of the host containing Oracle Database
* <oracle port> – Port for Oracle Database (default 1521)
* <sid> – SID of the Oracle Database
* <oracle username> – User name that is used to connect to Oracle Database
* <oracle password> – Password for the Oracle user
```

2. Run the schema validator script (schemavalidator.sql) using the psql command line from a bastion host and generate mismatch reports between source and target as an HTML file. The script accepts four input parameters that control the validation of database objects. 

```
* ora_schema : Oracle source schema (ora_schema="DMS_SAMPLE")
* pg_schema : PostgreSQL target schema (pg_schema="dms_sample") 
* seq_max_val_comp : Validates sequence max value (seq_max_val_compare="Y")
* code_compare : Validate procedural objects including packages as schema, procedure, and functions (code_compare="Y")
```

 
You can choose from two different options to run the script.

The first option involves validating all objects, including sequence max value and code objects:

```
PGPASSWORD=<pgpassword>

psql -h <hostname> -p 5432 -d dms_sample -U <pgmasteruser> -f schemavalidator.sql -v ora_schema=DMS_SAMPLE -v pg_schema=dms_sample -v seq_max_val_compare=Y -v code_compare=Y
```
For Example:
psql -h demoapg.cluster-abcdefg123456.us-west-2.rds.amazonaws.com -p 5432 -d dms_sample -U postgres -f schemavalidator.sql -v ora_schema=DMS_SAMPLE -v pg_schema=dms_sample -v seq_max_val_compare=Y -v code_compare=Y

The second option validates only schema objects:

```
PGPASSWORD=<pgpassword>

psql -h <hostname> -p 5432 -d dms_sample -U <pgmasteruser> -f schemavalidator.sql -v ora_schema=DMS_SAMPLE -v pg_schema=dms_sample
```
For Example:
psql -h demoapg.cluster-abcdefg123456.us-west-2.rds.amazonaws.com -p 5432 -d dms_sample -U postgres -f schemavalidator.sql -v ora_schema=DMS_SAMPLE -v pg_schema=dms_sample

During the conversion phase, we can use validator scripts post-schema conversion or post-procedural code conversion. We can also use them to identify schema object changes applied to Oracle Database during migration. By default, the validator script provides only schema object comparison that includes mismatch details for the following database objects:

```
> Database configuration:
  o Size
  o Collation, encoding
  o Versions

> Schema and code objects summary:
  o Tables
  o Table partitions
  o Indexes
  o Table columns
  o Sequence
  o Sequence max values (controlled with seq_max_val_compare)
  o Constraints (primary key, foreign key, unique, check, not NULL, and default)
  o Views and materialized views
  o Triggers
  o Oracle packages and its public object only (controlled with code_compare)
  o Functions and procedures (controlled with code_compare)

> Data type matrix:
  o Data type comparison between primary and foreign keys
```

## Oracle vs. PostgreSQL special cases
The validator script also highlights some of the special cases between Oracle and PostgreSQL that are usually identified at later stages during the functional testing of the migration. The validator script helps us be proactive and highlights cases that need additional consideration on solutioning or approaches. These special cases include the following:

```
* Oracle partitioned tables with primary keys that don’t include partition keys
* Composite unique indexes having either of the columns as nullable
* Oracle identifiers with length greater than 63
* User-created extended statistics that might influence execution plans
* Oracle default on NULL features as part of 12c
```
A migration engineer can identify the aforementioned special cases at an earlier stage of project by running the validation script and planning the solutioning accordingly.


## Clean up
After you complete schema validation, clean up the objects created by the scripts with the following command. Note that pgdbuser mentioned in following command was passed as a parameter while running the script installer_ora_fdw.sql. 

```
DROP SCHEMA IF EXISTS oracle_schema_compare cascade;
DROP SERVER IF EXISTS oradb CASCADE;
DROP USER MAPPING IF EXISTS FOR :pgdbuser SERVER oradb;

# Drop the extension if it is not required post validation.
DROP EXTENSION IF EXISTS oracle_fdw;
```

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

