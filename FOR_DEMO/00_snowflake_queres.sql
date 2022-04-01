
select distinct C_MKTSEGMENT
  from snowflake_sample_data.TPCH_SF1.CUSTOMER 
;

--
--SELEECT only customers that have car and home
--
CREATE OR REPLACE TABLE DEMO_DB.DEMO_DB.MARKETING_CUSTOMER AS
select * 
  from snowflake_sample_data.TPCH_SF1.CUSTOMER 
  --
  --Customers that have car and home
  --
 where C_MKTSEGMENT not in ('MACHINERY', 'FURNITURE')
 --
 --their account balance is bigger than 1000
 --
   and c_acctbal > 1000
 ;
  
 
 --
 --TESTS
 --
 
--
--unique
--
select c_custkey, count(1) from DEMO_DB.DEMO_DB.MARKETING_CUSTOMER  group by c_custkey having count(1)>1;
 
--
--not null
--
select c_custkey, count(1) from DEMO_DB.DEMO_DB.MARKETING_CUSTOMER
 where c_name is null group by c_custkey;
 
--
--marketing segment
--

select * from DEMO_DB.DEMO_DB.MARKETING_CUSTOMER 
 where c_mktsegment not in ('BUILDING', 'AUTOMOBILE', 'HOUSEHOLD')
 ;
 
 
 
--
--account ballance
--
select * from DEMO_DB.DEMO_DB.MARKETING_CUSTOMER 
 where c_acctbal <= 1000;
 




--
--TEST add Segment that is not expected by marketing
--



CREATE OR REPLACE TABLE DEMO_DB.TEST.TEST_CUSTOMER AS

SELECT C_CUSTKEY*1000 as C_CUSTKEY,
       'CustomerTest#'||to_char(C_CUSTKEY*1000) C_NAME,
       C_ADDRESS,
       C_NATIONKEY,
       C_PHONE,
       C_ACCTBAL,
       'TEST' AS C_MKTSEGMENT,
       C_COMMENT
  FROM snowflake_sample_data.TPCH_SF1.CUSTOMER
 LIMIT 3;
 
 
  
 --check if view contains test data 
 
select *
  from demo_db.TEST.CUSTOMER
 where c_name like 'CustomerTest%'; 
 
 
 
 CREATE OR REPLACE VIEW demo_db.TEST.CUSTOMER AS
 SELECT * from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER
 union all 
 SELECT * FROM DEMO_DB.TEST.TEST_CUSTOMER;
 

 --
 --switch customer table to test
 --
 -- with test data
 CREATE OR REPLACE TABLE DEMO_DB.DEMO_DB.MARKETING_CUSTOMER AS
select * 
  from demo_db.test.customer
 where C_MKTSEGMENT not in ('MACHINERY', 'FURNITURE')
   and c_acctbal > 1000
 ;
 
 --without test data
 
 CREATE OR REPLACE TABLE DEMO_DB.DEMO_DB.MARKETING_CUSTOMER AS
select * 
  from snowflake_sample_data.TPCH_SF1.CUSTOMER 
  --
  --Customers that have car and home
  --
 where C_MKTSEGMENT not in ('MACHINERY', 'FURNITURE')
 --
 --their account balance is bigger than 1000
 --
   and c_acctbal > 1000
 ;
  
 
 