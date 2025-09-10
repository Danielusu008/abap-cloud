CLASS zcl_implementacion_metodos_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_implementacion_metodos_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


    DATA(lo_contract) = NEW zcl_metodos_atributos_der(  ).
    DATA lv_process TYPE string.


    IF lo_contract IS BOUND.


      lo_contract->set_client(
        EXPORTING
          iv_client   = 'Experis'
          iv_location =  space          "space es una constante predefinida de ABAP.
       IMPORTING
          ev_status   = DATA(lv_status)
        CHANGING
          cv_process  = lv_process ).


      lo_contract->get_client(
        IMPORTING
          ev_client =  DATA(lv_client) ).


      lo_contract->region = 'EU' .

*      lo_contract->get_client_name(
*        EXPORTING
*          iv_client_id   = '01'
*        RECEIVING
*          rv_client_name = data(lv_client_name)
*      ).

      data(lv_client_name) = lo_contract->get_client_name( EXPORTING iv_client_id = '01' ).


    ENDIF.
    zcl_metodos_atributos_der=>set_cntr_type( EXPORTING iv_cntr_type = 'Construction'  ).

    zcl_metodos_atributos_der=>get_cntr_type( IMPORTING ev_cntr_type = DATA(lv_cntr_type) ).


    out->write( |{ lv_client }-{ lv_status }-{ lv_process }-{ lo_contract->region }| ).

    out->write(  lv_cntr_type  ).


  ENDMETHOD.

ENDCLASS.
