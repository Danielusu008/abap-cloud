CLASS zcl_crador_objeto_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_crador_objeto_der IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*
*    DATA(lo_contract) = NEW zcl_clase_creadora_der(  ).
*    DATA(lo_contract2) = NEW zcl_clase_creadora_der(  ).
    zcl_clase_creadora_der=>get_instance( IMPORTING er_instance = DATA(lo_contract) ).
    zcl_clase_creadora_der=>get_instance( IMPORTING er_instance = DATA(lo_contract2) ).

    DATA lv_process TYPE string.

    DATA: lt_address TYPE zcl_clase_creadora_der=>tty_address,
          ls_address TYPE zcl_clase_creadora_der=>ty_address.

    IF lo_contract IS BOUND.


      " ejemplo tablas y estructuras llamadas directamente desde un objeto
      DATA(lt_prueba) =  lo_contract->lt_prueba.
      DATA(ls_prueba) =  lo_contract->ls_prueba.

      ls_prueba-city = 'Madrid'.
      "-----------------------------------------------

      DATA(blabla) =  zcl_clase_creadora_der=>company .

      out->write( zcl_clase_creadora_der=>company ).
      out->write( blabla ).
      "----------------------------------------------------------


      "--------------------------------
      lo_contract->set_client(
        EXPORTING
          iv_client   =  'Experis'
          iv_location =   space
        IMPORTING
          ev_status   =  DATA(lv_status)
        CHANGING
          cv_process  = lv_process
      ).
      "lo_contract->set_address( it_address = VALUE #( ( country = 'ES' ) ) ).

      lo_contract->get_client(
        IMPORTING
          ev_client = DATA(lv_client)
      ).

      lo_contract->region = 'EU'  .

    ENDIF.

*        lo_contract->get_client_name(
*          EXPORTING
*            iv_client_id   = '01'
*          RECEIVING
*            rv_client_name = data(lv_client_name)
*        ).

    DATA(lv_client_name) = lo_contract->get_client_name( EXPORTING iv_client_id = '01' ).

    out->write( lv_client_name ).

*        if not lo_contract->get_client_name( iv_client_id = '01' ) is initial.
*            out->write( lo_contract->get_client_name( iv_client_id = '01' ) ).
*        endif.

    zcl_clase_creadora_der=>currency = 'USD'.

    zcl_clase_creadora_der=>set_cntr_type( EXPORTING iv_cntr_type = 'Contruction'  ).

    zcl_clase_creadora_der=>get_cntr_type( IMPORTING ev_cntr_type = DATA(lv_cntr_type) ).


    out->write( |{ lv_client }-{ lv_status }-{ lv_process }-{ lo_contract->region }| ).

    out->write( lv_cntr_type ).
    out->write( lo_contract->currency ).
    out->write( lo_contract2->currency ).
    out->write( zcl_clase_creadora_der=>currency   ).





  ENDMETHOD.


ENDCLASS.
