select * 
  from {% if var('is_test') == 'true' %}
       {{source("test_db", "CUSTOMER")}}
       {% else %}
       {{source("customer_db", "CUSTOMER")}}
       {% endif %} 
 where C_MKTSEGMENT not in ('MACHINERY', 'FURNITURE')
   and c_acctbal > 1000
