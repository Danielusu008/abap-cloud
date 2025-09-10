CLASS zcl_seleccion_filtros_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA lv_min_seats TYPE i.
ENDCLASS.



CLASS zcl_seleccion_filtros_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


    "-------------- operadores relacionales binarios----------------
    " = EQ ----> igual
    " <> NE ---> distinto
    " < LT ----> menor que
    " > GT ----> Great than
    " <= LE ---> lees equal
    " >= GE ---> Great equal

*    SELECT FROM ztab_flight_der
*       FIELDS *
*       WHERE flightdate > '20260415'
*       INTO TABLE @DATA(lt_flights).
*
*
*    IF sy-subrc = 0.
*      out->write( lt_flights ).
*    ENDIF.

    "------------------  Between --------------


*    SELECT FROM ztab_flight_der
*       FIELDS *
*       WHERE flightdate  ge  '20250619'  and  flightdate le '20260415'
*       INTO TABLE @DATA(lt_flights).
*
*SELECT FROM ztab_flight_der
*       FIELDS *
*       WHERE flightdate  not BETWEEN '20250619' and  '20260415'
*       INTO TABLE @DATA(lt_flights).
*
*
*    IF sy-subrc = 0.
*      out->write( lt_flights ).
*    ENDIF.
*
    "-------- in ----------------------

*
*    SELECT FROM ztab_flight_der
*  FIELDS *
*  WHERE airlineid IN ( 'AA', 'AZ' , 'JL' )
*  INTO TABLE @DATA(lt_airlines).
*
*    IF sy-subrc = 0.
*      out->write( lt_airlines ).
*    ENDIF.
    "-------------- in con tablas de rangos----------------
*
*
*    DATA lr_price TYPE RANGE OF /dmo/price.
*
*    lr_price = VALUE #( ( sign = 'I'
*                            option = 'BT'
*                            low   = 500
*                            high  = 1500 ) ).
*
*
*    APPEND VALUE #( sign = 'I'
*                       option = 'EQ'
*                       low = '4996.00' ) TO lr_price.
*
*
*    SELECT FROM ztab_flight_der
*     FIELDS *
*     WHERE price IN @lr_price
*         AND currencycode = 'USD'
*         INTO TABLE @DATA(lt_flights).
*
*    IF sy-subrc = 0.
*      out->write( lt_flights ).
*    ENDIF.

    "---------------MIN MAX----------------------------------------


*select from /dmo/I_Flight
*    FIELDS min( MaximumSeats ) as MinSeats,
*           max( MaximumSeats ) as MaxSeats
*    into ( @data(lv_min_seats), @data(lv_max_seats) ).
*
*
*if sy-subrc = 0.
*
*    out->write( |Min Seats: { lv_min_seats }; Max Seats { lv_max_seats } | ).
*endif.
*
*
*select from /dmo/I_Flight
*    FIELDS min( MaximumSeats ) as MinSeats,
*           max( MaximumSeats ) as MaxSeats
*    into @data(ls_min_max).
*
*
*if sy-subrc = 0.
*
*    out->write( ls_min_max ).
*endif.

    "-------------------------- AVG / SUM ---------------------------------
*
*    SELECT FROM /dmo/I_Flight
*        FIELDS SUM( MaximumSeats ) AS SumSeats,
*               AVG( MaximumSeats ) AS AvgSeats
*          INTO  @DATA(ls_avg_sum_seats).
*
*
*    IF sy-subrc = 0.
*
*      out->write( ls_avg_sum_seats  ).
*    ENDIF.

    "----------------------- Distinc----------------------------

    "Eliminar campos repetidos

    "------------------------ Count----------------------------------

*    SELECT FROM /dmo/I_flight
*        FIELDS COUNT( * ) AS CountAll,
*                COUNT( DISTINCT MaximumSeats ) AS CountMaximumSeats
*        WHERE AirlineID = 'AA'
*        INTO ( @DATA(lv_count_all), @DATA(lv_distinct_seats) ).
*
*
*    IF sy-subrc = 0.
*
*      out->write( |Count all { lv_count_all }; Count distinct seats { lv_distinct_seats }| ).
*    ENDIF.

    "------------------------ Group by ------------------------------------------------

*    SELECT FROM /dmo/i_flight
*        FIELDS AirlineID,
*            COUNT( DISTINCT ConnectionID ) AS CountDistinctConn
*         WHERE FlightDate = '20250621'
*         GROUP BY AirlineID
*         INTO TABLE @DATA(lt_results).
*
*  IF sy-subrc = 0.
*     out->write( lt_results ).
*    ENDIF.


    "------------------------- order by y having  ---------------------------------------------------
    " where filtra filas antes del group by; having filtra despues usando agregados

*    SELECT FROM /Dmo/I_flight
*        FIELDS AirlineID,
*            MIN( MaximumSeats ) AS MinSeats,
*            MAX( MaximumSeats ) AS MaxSeats
*        where FlightDate BETWEEN '20250617' and '20260419'
*        GROUP BY AirlineID having AirlineID in ( 'AA', 'LH', 'UA' )
*        ORDER BY AirlineID DESCENDING
*        into table @data(lt_results).
*
*     IF sy-subrc = 0.
*     out->write( lt_results ).
*   ENDIF.

    "-------------------------- offset----------------------------------------------------------------------

    " desplazamiento del resultado
    " Salta las primeras  "N" numero de filas y devuelve el resto o el siguente bloque

*    DATA: lv_page_number      TYPE i VALUE 1,
*          lv_records_per_page TYPE i VALUE 10.
*
*    DATA gv_offset TYPE  int8.
*
*
*    gv_offset = ( lv_page_number - 1 ) * lv_records_per_page.
*
*    SELECT FROM /dmo/I_Flight
*        FIELDS *
* "      WHERE CurrencyCode = 'USD'
*        ORDER BY AirlineID, ConnectionID, FlightDate ASCENDING
*        INTO TABLE @DATA(lt_results)
*        OFFSET @gv_offset
*        UP TO @lv_records_per_page ROWS.
*
*
*    IF sy-subrc = 0.
*      out->write( lt_results ).
*    ELSE.
*      out->write( 'No hay columnas disponibles para la siguiente pagina' ).
*    ENDIF.








  ENDMETHOD.

ENDCLASS.
