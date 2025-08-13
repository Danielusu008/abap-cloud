CLASS zcl_eje_manipulacion_tab_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_eje_manipulacion_tab_der IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.



*
**Crea una tabla interna con los datos de 15 vuelos simulados. Cada vuelo tendrá:
**Un ID de usuario (iduser)
**Un código de aerolínea (aircode)
**Un número de vuelo (flightnum)
**Una clave de país (key)
**Número de asientos ocupados (seat)
**Fecha del vuelo (flightdate)
**Utiliza una expresión FOR con UNTIL para crear los datos dinámicamente.
*
*
*
*TYPES: BEGIN OF ty_flight,
*         iduser     TYPE /dmo/customer_id,
*         aircode    TYPE /dmo/carrier_id,
*         flightnum  TYPE /dmo/connection_id,
*         key        TYPE land1,
*         seat       TYPE /dmo/plane_seats_occupied,
*         flightdate TYPE /dmo/flight_date,
*       END OF ty_flight.
*
*DATA: lt_flights TYPE TABLE OF ty_flight.
*
*" Generamos 15 vuelos con datos ficticios usando FOR ... UNTIL
*    lt_flights = VALUE #( FOR i = 1 UNTIL i > 15
*      ( iduser     = |{ 123000 + i }|         " 123001, 123002, ...
*        aircode    = 'LH'
*        flightnum  = |04{ i WIDTH = 2 PAD = '0' }|
*        key        = 'US'
*        seat       = i + 10
*        flightdate = cl_abap_context_info=>get_system_date( ) + i ) ).
*
*out->write( data = lt_flights name = `lt_flights` ).
*
*
*"Con la tabla de vuelos del ejercicio anterior, elimina todos los vuelos cuyo número de vuelo sea menor que '0405'.
*
*out->write( |\n| ).
*
*LOOP AT lt_flights INTO DATA(ls_flight).
*  IF ls_flight-flightnum < '0405'.
*    DELETE lt_flights FROM ls_flight.
*  ENDIF.
*ENDLOOP.
*
*out->write( data = lt_flights name = `Después del borrado` ).
*
**
**Actualiza la tabla interna lt_flights para:
**Cambiar la aircode a 'UPD' si seat es mayor a 20.
**Cambiar el flightdate al día actual para esos mismos vuelos.
*
**
**LOOP AT lt_flights INTO ls_flight.
**  IF ls_flight-seat > 20.
**    ls_flight-aircode    = 'UPD'.
**    ls_flight-flightdate = cl_abap_context_info=>get_system_date( ).
**
**    " Se usa MODIFY con TRANSPORTING para actualizar solo los campos deseados
**    MODIFY lt_flights FROM ls_flight TRANSPORTING aircode flightdate.
**  ENDIF.
**ENDLOOP.
*
*
*
**"""SOLO PARA JORGE que vea como se hace con los field-symbol
**" Actualiza aircode y flightdate cuando seat > 20 usando FIELD-SYMBOLS
**LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<ls_flight>).
**  IF <ls_flight>-seat > 20.
**    <ls_flight>-aircode    = 'UPD'.
**    <ls_flight>-flightdate = cl_abap_context_info=>get_system_date( ).
**
**    " Con ASSIGNING, ya estás modificando la línea real de la tabla.
**    " Si quieres ser explícito, puedes usar una de estas dos (opcional):
**    " MODIFY CURRENT LINE TRANSPORTING aircode flightdate.
**    " MODIFY lt_flights FROM <ls_flight> TRANSPORTING aircode flightdate INDEX sy-tabix.
**  ENDIF.
**ENDLOOP.
**"""SOLO PARA JORGE que vea como se hace con los field-symbol
*
*
*out->write( data = lt_flights name = `Después de modificar` ).


*Crea dos tablas internas:
*lt_vuelos: contiene información de vuelos (aerolínea, número de vuelo y fecha).
*lt_precios: contiene información de precios de vuelo por aerolínea y número de vuelo.
*Crea una tercera tabla lt_resultado que combine los datos de ambas, solo si coinciden en aircode y flightnum.
*Usa una expresión VALUE #( FOR ... FOR ... ) (for anidado) para construir la tabla resultado.
*

          "-----------------------------
    " 1) Definición de tipos
    "-----------------------------
    TYPES: BEGIN OF ty_vuelo,
             aircode    TYPE /dmo/carrier_id,     " Aerolínea (p.ej. 'AA', 'LH')
             flightnum  TYPE /dmo/connection_id,  " Nº de vuelo (p.ej. '0401')
             flightdate TYPE /dmo/flight_date,    " Fecha del vuelo
           END OF ty_vuelo.

    TYPES: BEGIN OF ty_precio,
             aircode     TYPE /dmo/carrier_id,     " Aerolínea
             flightnum   TYPE /dmo/connection_id,  " Nº de vuelo
             flightprice TYPE /dmo/flight_price,   " Precio
             currency    TYPE /dmo/currency_code,  " Moneda
           END OF ty_precio.

    TYPES: BEGIN OF ty_resultado,
             aircode     TYPE /dmo/carrier_id,
             flightnum   TYPE /dmo/connection_id,
             flightdate  TYPE /dmo/flight_date,
             flightprice TYPE /dmo/flight_price,
             currency    TYPE /dmo/currency_code,
           END OF ty_resultado.

    " Tablas internas resultado y de datos
    DATA: lt_vuelos     TYPE STANDARD TABLE OF ty_vuelo,
          lt_precios    TYPE STANDARD TABLE OF ty_precio,
          lt_resultado  TYPE STANDARD TABLE OF ty_resultado.

    "------------------------------------------
    " 2) Carga de DATOS SIMULADOS (no de BBDD)
    "------------------------------------------
    " Dos vuelos de AA y uno de LH; uno de ellos NO tendrá precio para que se vea
    " que el join por FOR anidado solo devuelve coincidencias.
    lt_vuelos = VALUE #(
      ( aircode = 'AA' flightnum = '0401' flightdate = '20250731' )
      ( aircode = 'AA' flightnum = '0402' flightdate = '20250801' )
      ( aircode = 'LH' flightnum = '0500' flightdate = '20250815' )
    ).

    " Precios: uno para AA-0401 y otro para LH-0500.
    " Deliberadamente NO ponemos precio de AA-0402 para comprobar el filtrado.
    lt_precios = VALUE #(
      ( aircode = 'AA' flightnum = '0401' flightprice = '399.00' currency = 'USD' )
      ( aircode = 'LH' flightnum = '0500' flightprice = '520.00' currency = 'EUR' )
      " ( aircode = 'AA' flightnum = '0402' ... )  -> a propósito no existe
    ).

    " Mostrar datos de partida
    out->write( data = lt_vuelos  name = `lt_vuelos (datos simulados)` ).
    out->write( data = lt_precios name = `lt_precios (datos simulados)` ).

    "---------------------------------------------------------------------------------
    " 3) Construcción de lt_resultado con VALUE #( FOR ... FOR ... )
    "
    "    - Primer FOR recorre cada vuelo.
    "    - Segundo FOR recorre precios PERO filtrados por coincidencia de claves:
    "        aircode = gs_vuelo-aircode AND flightnum = gs_vuelo-flightnum
    "    - El paréntesis final (...) crea la línea del tipo ty_resultado
    "      combinando campos de ambas tablas (equivale a un INNER JOIN en memoria).
    "---------------------------------------------------------------------------------
    lt_resultado = VALUE #(
      FOR gs_vuelo  IN lt_vuelos
        FOR gs_prec  IN lt_precios
          WHERE ( aircode  = gs_vuelo-aircode
                  AND flightnum = gs_vuelo-flightnum )
          ( aircode     = gs_vuelo-aircode
            flightnum   = gs_vuelo-flightnum
            flightdate  = gs_vuelo-flightdate
            flightprice = gs_prec-flightprice
            currency    = gs_prec-currency )
    ).

    "-----------------------------------------
    " 4) Salida: solo aparecen coincidencias
    "    Esperado con los datos de ejemplo:
    "      - AA 0401 (tiene precio)   -> aparece
    "      - AA 0402 (sin precio)     -> NO aparece
    "      - LH 0500 (tiene precio)   -> aparece
    "-----------------------------------------
    out->write( data = lt_resultado name = `lt_resultado (join por FOR anidado)` ).



ENDMETHOD.
ENDCLASS.
