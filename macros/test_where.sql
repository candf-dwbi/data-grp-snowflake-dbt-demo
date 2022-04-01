{% test where(model, column_name, where_stm) %}

    select *
    from {{ model }}
    where {{ column_name }} {{ where_stm }}

{% endtest %}