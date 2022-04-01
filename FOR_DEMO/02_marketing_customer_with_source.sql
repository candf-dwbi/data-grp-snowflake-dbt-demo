select * 
  from 
       {{source("customer_db", "CUSTOMER")}}
        
 where C_MKTSEGMENT not in ('MACHINERY', 'FURNITURE')
   and c_acctbal > 1000

--dbt run
--dbt run --select marketing_customer