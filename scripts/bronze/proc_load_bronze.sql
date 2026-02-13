IF OBJECT_ID('bronze.load_bronze','P') IS NOT NULL
DROP PROCEDURE bronze.load_bronze;
go
CREATE procedure bronze.load_bronze AS
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime
	set @batch_start_time=getdate()
	print '--------------------';
	PRINT 'LOADING BRONZE LAYER';
	print '====================';

	print '--------------------';
	PRINT 'LOADING CRM ';
	print '====================' ;

	set @start_time=GETDATE();
	TRUNCATE table bronze.crm_cust_info;
	bulk insert bronze.crm_cust_info
	from 'C:\UCD\Self- Projects\SQL DataWarehousing Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			set @end_time=getdate()
			PRINT 'LOADING TIME of crm_cust_info is' +cast(DATEDIFF(second,@start_time,@end_time) as varchar) +'seconds'

	TRUNCATE table bronze.crm_prd_info;
	bulk insert bronze.crm_prd_info
	from 'C:\UCD\Self- Projects\SQL DataWarehousing Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	with (
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	);

	TRUNCATE table [bronze].[crm_sales_details];
	bulk insert [bronze].[crm_sales_details]
	from 'C:\UCD\Self- Projects\SQL DataWarehousing Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	with (
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	);

	PRINT '-------------------------'
	PRINT 'LOADING CRM TABLES'
	PRINT '========================='
	TRUNCATE table [bronze].[erp_cust_az12];;
	bulk insert [bronze].[erp_cust_az12]
	from 'C:\UCD\Self- Projects\SQL DataWarehousing Project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	with (
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	);

	TRUNCATE table [bronze].[erp_loc_a101];
	bulk insert [bronze].[erp_loc_a101]
	from 'C:\UCD\Self- Projects\SQL DataWarehousing Project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	with (
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	);

	TRUNCATE table [bronze].[erp_px_cat_g1v2];
	bulk insert [bronze].[erp_px_cat_g1v2]
	from 'C:\UCD\Self- Projects\SQL DataWarehousing Project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	with(
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	);
END

EXEC bronze.load_bronze

/*
select * from sys.procedures

select * from sys.schemas

SELECT 
    s.name AS schema_name, 
    p.name AS procedure_name
FROM sys.procedures p
JOIN sys.schemas s ON p.schema_id = s.schema_id
WHERE p.name LIKE '%load__bronze%';
*/
