CLASS zcl_tipos_select_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tipos_select_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    "--------Select single
*    SELECT SINGLE FROM ztab_carrier_der
*        FIELDS *
*        WHERE carrier_id = 'AA'
*        INTO @DATA(ls_airline).
*
*    IF sy-subrc = 0.
*        out->write( ls_airline ).
*    ENDIF.

    "----------------- select into  y appending table ---------------------

*    DATA lt_airlines TYPE STANDARD TABLE OF ztab_carrier_der.
*
*    SELECT FROM ztab_carrier_der
*        FIELDS *
*            WHERE currency_code = 'USD'
*            INTO TABLE @lt_airlines.
*
*    IF sy-subrc = 0.
*      out->write( lt_airlines ).
*    ENDIF.
*
*    out->write( 'nueva seleccion' ).
*
*    SELECT FROM ztab_carrier_der
*        FIELDS *
*          WHERE currency_code = 'XYZ'
*          INTO TABLE @lt_airlines.
*
*    out->write( lt_airlines ).
*
*    if lt_airlines is initial.
*
*        out->write( 'no hay datos en la tabla interna' ).
*     endif.

    "----- appending table

*    DATA lt_airlines TYPE STANDARD TABLE OF ztab_carrier_der.
*
*    SELECT FROM ztab_carrier_der
*        FIELDS *
*            WHERE currency_code = 'USD'
*            INTO TABLE @lt_airlines.
*
*    IF sy-subrc = 0.
*
*  "    APPEND INITIAL LINE TO lt_airlines.
*
*
*      SELECT FROM ztab_carrier_der
*          FIELDS *
*            WHERE currency_code = 'EUR'
*            APPENDING TABLE @lt_airlines.
*
*         out->write( lt_airlines ).
*
*    ENDIF.
    "------------Select into correspondig fields-----------------

*
*    TYPES: BEGIN OF ty_flights,
*            airlineid    type c LENGTH 3,
*            connectionid type n LENGTH 4,
*            price        type p LENGTH 16 DECIMALS 2,
*            currencycode type c LENGTH 5,
*            planeType type c LENGTH 7,
*        end of TY_FLIGHTS.
*
*
*     data lt_flights type STANDARD TABLE OF ty_flights.
*
*     select from ztab_flight_der
*        FIELDS
*        airlineid,
*       connectionid,
*        price
*        where  airlineid = 'LH'
*        into CORRESPONDING FIELDS OF TABLE @lt_flights.
*
*      if sy-subrc = 0.
*        out->write( lt_flights ).
*
*     endif.

    " ----------------------- select columns ------------------

*    SELECT SINGLE FROM ztab_flight_der
*        FIELDS price
*            WHERE airlineid = 'AA'
*            AND connectionid = '0018'
*            AND flightdate   = '20250620'
*       INTO @DATA(lv_flight_price).
*
*    IF sy-subrc = 0.
*      out->write( lv_flight_price ).
*    ENDIF.
    "------ select up to n rows----------------------

*select from ztab_flight_der
*       FIELDS *
*       where airlineid = 'LH'
*       into table @data(lt_flights)
*       up to 3 rows.
*
*      IF sy-subrc = 0.
*      out->write( lt_flights ).
*    ENDIF.


    "------------------ select package size ------------------------
*
*    DATA lt_flights TYPE SORTED TABLE OF ztab_flight_der
*        WITH NON-UNIQUE KEY airlineid connectionid.
*
*
*    SELECT FROM ztab_flight_der
*        FIELDS *
*        INTO TABLE @lt_flights
*        PACKAGE SIZE 3.
*
*
*      LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<ls_flights>).
*        out->write( | { <ls_flights>-airlineid } { <ls_flights>-connectionid }| ).
*      ENDLOOP.
*
*
*      out->write( cl_abap_char_utilities=>newline ).
*
*    ENDSELECT.






  ENDMETHOD.

ENDCLASS.
