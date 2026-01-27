/*
====================================
Creating Database and Schema
====================================
Script purpose:

The script creates a new database called the 'DataWharehouse"

*/

use master;
go

--drop and recreate the datawarehouse database

if exists(select 1 from sys.databases where name= 'DataWarehouse')
begin
	drop database DataWarehouse;
end;
go
create database DataWarehouse;
go

use DataWarehouse;
go

--create schemas

create schema bronze;
go
create schema silver;
go
create schema gold;
