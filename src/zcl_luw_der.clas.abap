CLASS zcl_luw_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_luw_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*"---------------- Commit work y rollback work  !!NO ejecutar para que no se os borren los datos-----
*    UPDATE ztab_carrier_der
*     SET currency_code = 'EUR'
*     WHERE carrier_id = 'AA'.
*
*    IF sy-subrc = 0.
*
*      SELECT SINGLE FROM ztab_carrier_der
*          FIELDS *
*          WHERE carrier_id = 'AA'
*          INTO @DATA(ls_airline).
*
*      IF sy-subrc = 0.
*
*        out->write( ls_airline-currency_code ).
*
*
*      ENDIF.
*
*
*    ENDIF.
*    delete from ztab_carrier_der.
*    commit work.
*
*    CONSTANTS lc_currency TYPE c LENGTH 3 VALUE 'USD'.
*
*    SELECT FROM Ztab_carrier_der
*            FIELDS *
*            INTO TABLE @DATA(lt_airlines).
*
*    IF sy-subrc = 0.
*
*      LOOP AT lt_airlines ASSIGNING FIELD-SYMBOL(<ls_airlines>).
*
*        "CLEAR <ls_airlines>-name.
*        <ls_airlines>-currency_code = lc_currency.
*      ENDLOOP.
*
*      UPDATE ztab_carrier_der FROM TABLE @lt_airlines.
*
*      IF sy-subrc = 0.
*        out->write(  |Todos los registros han sido actualizados con el nuevo currency { lc_currency }| ).
*      ENDIF.
*    ENDIF.
*
*
*    ROLLBACK WORK.


  ENDMETHOD.

ENDCLASS.
