CLASS zcl_update_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_update_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    " ---------------------Actualización de un unico campo/registro -------------------------------------
*    DATA ls_airline TYPE ztab_carrier_der.
*
*    SELECT SINGLE FROM ztab_carrier_der
*                  FIELDS *
*                  WHERE carrier_id = 'AA'
*                  INTO @ls_airline.
*
*    IF sy-subrc = 0.
*      out->write(  |Current Currency: { ls_airline-currency_code }| ).
*    ENDIF.
*
*    ls_airline-currency_code = 'EUR'.
*
*    update ztab_carrier_der from @ls_airline.
*      IF sy-subrc = 0.
*      out->write(  |El registro se ha actualizado con un nuevo "currency" { ls_airline-currency_code }| ).
*    ENDIF.

    "---------------------------------Update de manera "literal"

* DATA ls_airline TYPE ztab_carrier_der.
*
*        ls_airline = value #( carrier_id = 'AA'
*                              name      = 'American Airlines Inc.'
*                              currency_code = 'EUR' ).
*
*       update ztab_carrier_der from @ls_airline.
*      IF sy-subrc = 0.
*      out->write(  |El registro se ha actualizado con un nuevo "currency" { ls_airline-currency_code }| ).
*    ENDIF.
*
    "---------------------------- UPDATE multiples registros-----------------------------------

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

    "-----------------------------------Actualizacion de columnas----------------------------------------

*
*   CONSTANTS lc_currency TYPE c LENGTH 3 VALUE 'EUR'.
*
*       update ztab_carrier_der
*            set currency_code = @lc_currency
*            where carrier_id = 'AA'
*            or carrier_id = 'DL'.
*
*
*
*      IF sy-subrc = 0.
*        out->write(  |Registros actualizados | ).
*        else.
*        out->write(  |Registros NO actualizados | ).
*     ENDIF.

    "--------------------Actualizacion de columnas con expresiones--------------------------------------

    DATA lt_flights TYPE STANDARD TABLE OF ztab_flight_der.

    UPDATE ztab_flight_der
            SET maximumseats = maximumseats + 10,
                occupiedseats = occupiedseats + 5
                WHERE airlineid = 'LH'.

    IF sy-subrc = 0.

      out->write(  |actualizacion de columnas: { sy-dbcnt }| ).
    ELSE.
      out->write( |Actualizacion no ejecutada | ).
    ENDIF.








  ENDMETHOD.

ENDCLASS.
