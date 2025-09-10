CLASS zcl_modify_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_modify_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    "--------------modificacion de un unico registro con el modify---------------------

    DATA(ls_airline) = VALUE ztab_carrier_der( carrier_id = 'WZ'
                                               name       =  'Wizz Air'
                                               currency_code = 'USD' ).


    MODIFY ztab_carrier_der FROM @ls_airline.

    IF sy-subrc = 0.
      out->write( 'El registro ha sido introducido/modificado ').

    ELSE.
      out->write( 'El registro ha sido introducido/modificado ').
    ENDIF.
    "-----------------------------Modificar/actualizar multiples registros----------


*    CONSTANTS lc_currency TYPE c LENGTH 3 VALUE 'EUR'.
*
*    SELECT FROM ztab_carrier_der
*       FIELDS *
*          WHERE carrier_id = 'LH'
*          OR carrier_id = 'AF'
*          INTO TABLE @DATA(lt_airlines).
*
*    IF sy-subrc = 0.
*
*      LOOP AT lt_airlines ASSIGNING FIELD-SYMBOL(<fs_airline>).
*        <fs_airline>-currency_code = lc_currency.
*      ENDLOOP.
*      APPEND VALUE #( carrier_id  = 'AV'
*                      name        =  'AVIANCA'
*                      currency_code = 'EUR') TO lt_airlines.
*
*      MODIFY ztab_carrier_der FROM TABLE @lt_airlines.
*
*      IF sy-subrc = 0.
*
*        out->write(  'los registros se han modificado/creado ' ).
*      ELSE.
*        out->write(  'los registros NO se han modificado/creado ' ).
*
*      ENDIF.
*    ELSE.
*      SELECT FROM /dmo/I_carrier
*       FIELDS AirlineID AS carrier_id,
*       Name,
*       CurrencyCode AS currency_code
*       WHERE AirlineID = 'AF' OR AirlineID  = 'LH'
*       INTO CORRESPONDING FIELDS OF TABLE  @lt_airlines.
*
*      IF sy-subrc = 0.
*
*        MODIFY ztab_carrier_der FROM TABLE @lt_airlines.
*
*        IF sy-subrc = 0.
*
*          out->write(  'los registros se han modificado/creado 2 ' ).
*        ELSE.
*          out->write(  'los registros NO se han modificado/creado  2 ' ).
*
*        ENDIF.
*      ENDIF.
*    ENDIF.




  ENDMETHOD.

ENDCLASS.
