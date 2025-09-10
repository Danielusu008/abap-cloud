CLASS zcl_00_main_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_00_main_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*    DATA(lo_employee) = NEW zcl_01_class_der( iv_employee_id = '01' ).
*    out->write( lo_employee->get_employee_id(  ) ).




    DATA(lo_conctract) = NEW zcl_ejemplos_der(  ).
    DATA lv_process TYPE string.


    IF lo_conctract IS BOUND.



      lo_conctract->get_client(
           IMPORTING
             ev_client = DATA(lv_client)
         ).

      out->write( |{ lv_client }| ).




      lo_conctract->set_client(
        EXPORTING
          iv_client   = 'Daniel'
          iv_location =  '    '
        IMPORTING
          ev_status   = DATA(lv_status)
        CHANGING
          cv_process  = lv_process
      ).


      lo_conctract->get_client(
      IMPORTING
        ev_client = lv_client
    ).

      out->write( |-{ lv_status }-{ lv_process }-{ lv_client }| ).








    ENDIF.
























  ENDMETHOD.

ENDCLASS.
