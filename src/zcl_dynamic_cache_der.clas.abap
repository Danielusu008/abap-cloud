CLASS zcl_dynamic_cache_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dynamic_cache_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

get time stamp field data(lv_timestamp_begin).


    SELECT FROM ztab_invoice_der
        FIELDS comp,
                currency_key,
                SUM( amount ) AS totalAmount

                GROUP BY comp, currency_key
                INTO TABLE @DATA(lt_invoices).

if sy-subrc = 0.

    get time STAMP FIELD data(lv_timestamp_end).


  data(lv_dif_sec) = cl_abap_tstmp=>subtract( exporting
                                                            tstmp1 = lv_timestamp_end
                                                            tstmp2 = lv_timestamp_begin ).
     out->write( |Numero de registros: { lines(  lt_invoices ) } | ).
        out->write( lt_invoices ).
        out->write( |timepo de ejecucion total: { lv_dif_sec }| ).
endif.


  ENDMETHOD.

ENDCLASS.
