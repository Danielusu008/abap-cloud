CLASS zcl_insert_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_insert_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    "inserrcion de un unico registro.
*
*    DATA ls_airline TYPE ztab_carrier_der.
*
*    ls_airline = VALUE #(  carrier_id = 'AA'
*                            name = 'American Airlines'
*                            currency_code = 'USD'    ).
*
*   " INSERT into ztab_carrier_der values @ls_airline. " esta mejor no usarla
*     INSERT ztab_carrier_der FROM @ls_airline. "Usar esta preferentemente
*
*     if sy-subrc = 0.
*        out->write( 'Registro introducido correctamente' ).
*        else.
*       out->write( 'El registro no se ha introducido' ).
*       endif.


    "----------------------------------Inserccion de multiples registros----------------------------------------


*    DELETE FROM ztab_carrier_der.
*
*    DATA lt_ddbb TYPE STANDARD TABLE OF ztab_carrier_der.
*
*    SELECT FROM /dmo/I_Carrier
*     FIELDS *
*     WHERE currencyCode = 'USD'
*     INTO TABLE @DATA(lt_airlines).
*
*    IF sy-subrc = 0.
*
*      lt_ddbb = CORRESPONDING #( lt_airlines MAPPING carrier_id = AirlineID
*                                                     currency_code = CurrencyCode ).
*
*      INSERT ztab_carrier_der FROM TABLE @lt_ddbb.
*
*      IF sy-subrc = 0.
*        out->write( |El numero de lineas insertadas es: { sy-dbcnt }| ).
*      ENDIF.
*
*    ENDIF.


    "-------------- lo de arriba pero mas "eficiente"-----------------------------


*
*   DELETE FROM ztab_carrier_der.
*
*    DATA lt_ddbb TYPE STANDARD TABLE OF ztab_carrier_der.
*
*    SELECT FROM /dmo/I_Carrier
*    FIELDS AirlineID AS carrier_id,
*           name,
*           CurrencyCode AS currency_code
*    WHERE CurrencyCode = 'USD'
*    INTO CORRESPONDING FIELDS OF TABLE @lt_ddbb.
*
*    IF sy-subrc = 0.
*
*    try.
*
*      INSERT ztab_carrier_der FROM TABLE @lt_ddbb.
*
*catch cx_sy_open_sql_db into data(lx_sql_db).
*            out->write( lx_sql_db->get_text( ) ).
*            return.
*        endtry.
*
*
*      IF sy-subrc = 0.
*        out->write( |El numero de lineas insertadas es: { sy-dbcnt }| ).
*        else.
*         out->write( |la inserccion no se ha ejecutado correctamente| ).
*      ENDIF.
*
*    ENDIF.
    "-------------------------------
*
*    DATA lt_flights TYPE STANDARD TABLE OF ztab_flight_der.
*
*    SELECT FROM /DMO/I_Flight
*     FIELDS *
*     INTO CORRESPONDING FIELDS OF TABLE @lt_flights.
*
*    IF sy-subrc = 0.
*      INSERT ztab_flight_der FROM TABLE @lt_flights.
*      IF sy-subrc = 0.
*        out->write( |Insercciones: { sy-dbcnt } filas | ).
*      ENDIF.
*    ENDIF.
 ENDMETHOD.

ENDCLASS.
