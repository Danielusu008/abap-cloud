CLASS zcl_tablas_repaso_eje DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.



    TYPES:
      "=== Ej.13: ==========================
      BEGIN OF ty_from_to_cnt_13,
        airport_from_id TYPE /dmo/airport_from_id,
        airport_to_id   TYPE /dmo/airport_to_id,
        cnt             TYPE i,
      END OF ty_from_to_cnt_13,

      "=== Ej.1: Tipo base solicitado en el enunciado ==========================
      BEGIN OF ty_flights,
        iduser     TYPE c LENGTH 40,
        aircode    TYPE /dmo/carrier_id,
        flightnum  TYPE /dmo/connection_id,
        key        TYPE land1,
        seat       TYPE /dmo/plane_seats_occupied,
        flightdate TYPE /dmo/flight_date,
      END OF ty_flights,
      ty_flights_tab TYPE STANDARD TABLE OF ty_flights WITH EMPTY KEY,

      "=== Ej.3: Tipo para subconjunto de /dmo/connection =====================
      BEGIN OF ty_airlines,
        carrier_id      TYPE /dmo/carrier_id,
        connection_id   TYPE /dmo/connection_id,
        airport_from_id TYPE /dmo/airport_from_id,
        airport_to_id   TYPE /dmo/airport_to_id,
      END OF ty_airlines,
      ty_airlines_tab TYPE STANDARD TABLE OF ty_airlines WITH EMPTY KEY,

      "=== Ej.8: Tipo agregado para COLLECT ===================================
      BEGIN OF ty_seats,
        carrier_id    TYPE /dmo/carrier_id,
        connection_id TYPE /dmo/connection_id,
        seats         TYPE /dmo/plane_seats_occupied,
        bookings      TYPE /dmo/flight_price,
      END OF ty_seats,
      ty_seats_hashed TYPE HASHED TABLE OF ty_seats
        WITH UNIQUE KEY carrier_id connection_id,
      ty_seats_std    TYPE STANDARD TABLE OF ty_seats WITH EMPTY KEY,

      "=== Ej.14: Rango para seats_occupied ===================================
      ty_range_seats  TYPE RANGE OF /dmo/plane_seats_occupied.

    DATA:
      mt_flights_type TYPE STANDARD TABLE OF /dmo/flight WITH EMPTY KEY,
      mt_airlines     TYPE STANDARD TABLE OF /dmo/connection WITH EMPTY KEY,
      mt_scarr        TYPE STANDARD TABLE OF /dmo/carrier WITH EMPTY KEY.


    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.


ENDCLASS.



CLASS zcl_tablas_repaso_eje IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


**************************************************************** EJERCICIO 1 *******************************************************************************

    DATA: ls_flight       TYPE ty_flights,                      " WA (work area) con la estructura de una fila del tipo ty_flights
          lt_flights      TYPE STANDARD TABLE OF ty_flights,    " Itab estándar que contendrá 15 vuelos generados
          lt_flights_info TYPE STANDARD TABLE OF ty_flights.    " Itab estándar resultado con los vuelos mapeados

    " Construye lt_flights con 15 filas usando FOR (i = 1..15)
    lt_flights = VALUE ty_flights_tab(                          " Constructor de tabla del tipo ty_flights_tab
      FOR i = 1 UNTIL i > 15                                    " Bucle generador: crea filas mientras i ≤ 15
      ( iduser     = |1234{ i }-t100437|                        " iduser con plantilla de texto: 1234 + i + sufijo
        aircode    = 'SQ'                                       " Código de aerolínea fijado a 'SQ'
        flightnum  = CONV /dmo/connection_id( i )               " Convierte i al tipo /dmo/connection_id (evita warnings)
        key        = 'US'                                       " País/clave fijado a 'US' (sin espacios)
        seat       = CONV /dmo/plane_seats_occupied( i )        " Asientos ocupados = i, convertido a su tipo
        flightdate = cl_abap_context_info=>get_system_date( ) + i ) ). " Fecha = hoy + i días (DATE aritmética)

    out->write( EXPORTING data = lt_flights name = 'Ej.1: LT_FLIGHTS (base)' ). " Muestra la tabla base generada

    " Mapea/cambia campos a lt_flights_info
    lt_flights_info = VALUE ty_flights_tab(                     " Nuevo constructor de tabla para la tabla destino
      FOR ls IN lt_flights                                      " Recorre cada vuelo de la tabla base
      ( iduser     = ls-iduser                                  " Copia el iduser
        aircode    = 'CL'                                       " Sustituye aerolínea por 'CL'
        flightnum  = ls-flightnum + 10                          " Incrementa el nº de vuelo en +10
        key        = 'COP'                                      " Cambia la clave/país a 'COP'
        seat       = ls-seat                                    " Copia asientos ocupados
        flightdate = ls-flightdate ) ).                         " Copia la fecha

    out->write( EXPORTING data = lt_flights_info name = 'Ej.1: LT_FLIGHTS_INFO (mapeada)' ). " Muestra la tabla mapeada


**************************************************************** EJERCICIO 2 *******************************************************************************

    DATA lt_final TYPE SORTED TABLE OF ty_flights WITH NON-UNIQUE KEY aircode. " Tabla ordenada por 'aircode' permitiendo duplicados

    " Cargar datos base de las tablas demo
    SELECT FROM /dmo/flight     FIELDS * INTO TABLE @mt_flights_type.          " Selecciona TODOS los vuelos a mt_flights_type
    SELECT FROM /dmo/connection FIELDS * WHERE carrier_id = 'SQ'               " Selecciona conexiones sólo de la aerolínea 'SQ'
           INTO TABLE @mt_airlines.

    " Join en memoria: vuelos SQ + su conexión por connection_id
    lt_final = VALUE ty_flights_tab(                                           " Construye la tabla resultado
      FOR ls_flights_type IN mt_flights_type WHERE ( carrier_id = 'SQ' )       " Itera los vuelos de la compañía 'SQ'
      FOR ls_airline      IN mt_airlines     WHERE ( connection_id = ls_flights_type-connection_id ) " Une por connection_id
      ( iduser     = ls_flights_type-client                                    " Usa el mandante como iduser (tipifica a string)
        aircode    = ls_flights_type-carrier_id                                " Copia el código de aerolínea
        flightnum  = ls_airline-connection_id                                  " Toma el nº de conexión de /dmo/connection
        key        = ls_airline-airport_from_id                                " Pone el aeropuerto de origen como 'key'
        seat       = ls_flights_type-seats_occupied                            " Copia asientos ocupados del vuelo
        flightdate = ls_flights_type-flight_date ) ).                           " Copia la fecha del vuelo

    out->write( EXPORTING data = lt_final name = 'Ej.2: Nested FOR (join en memoria)' ). " Muestra el resultado del join


***************************************************************** EJERCICIO 3 *******************************************************************************

    DATA mt_airlines_sub TYPE ty_airlines_tab.                                 " Subconjunto con sólo 4 columnas (tipo reducido)

    " Selección de subconjunto (sólo columnas requeridas) para origen FRA
    SELECT carrier_id, connection_id, airport_from_id, airport_to_id           " Selecciona solo estas columnas
      FROM /dmo/connection                                                      " De la tabla de conexiones
      WHERE airport_from_id = 'FRA'                                             " Filtra conexiones cuyo origen sea FRA
      INTO TABLE @mt_airlines_sub.                                              " Vuelca el resultado al subconjunto

    out->write( EXPORTING data = mt_airlines_sub name = 'Ej.3: Multiple lines (FRA)' ). " Muestra el subconjunto
*
*
***************************************************************** EJERCICIO 4 *******************************************************************************

    " Ordenar el subconjunto por connection_id descendente
    SORT mt_airlines_sub BY connection_id DESCENDING.                           " Ordena Z→A / 999→0 por connection_id

    out->write( EXPORTING data = mt_airlines_sub name = 'Ej.4: Sorted DESC by connection_id' ). " Muestra ordenado
*
*
***************************************************************** EJERCICIO 5 *******************************************************************************

    " Alias mt_spfli del mismo tipo que /dmo/connection (reutiliza lo ya cargado en Ej.2)
    DATA mt_spfli TYPE STANDARD TABLE OF /dmo/connection WITH EMPTY KEY.       " Crea alias con el tipo de /dmo/connection
    mt_spfli = mt_airlines.                                                    " Copia las conexiones de 'SQ' cargadas en Ej.2

    " Modificar la hora de salida si es > 12:00 (formato TIMS 'HHMMSS')
    LOOP AT mt_spfli ASSIGNING FIELD-SYMBOL(<ls_spfli>).                        " Itera editando en sitio (sin WA y sin MODIFY)
      IF <ls_spfli>-departure_time > '120000'.                                  " Compara TIMS: 12:00:00 → '120000'
        <ls_spfli>-departure_time = cl_abap_context_info=>get_system_time( ).   " Sustituye por la hora actual del sistema
      ENDIF.                                                                    " Fin condición
    ENDLOOP.                                                                    " Fin bucle

    out->write( EXPORTING data = mt_spfli name = 'Ej.5: Modify table (departure_time)' ). " Muestra tabla modificada


***************************************************************** EJERCICIO 6 *******************************************************************************

    " Eliminar de mt_spfli (alias de /dmo/connection) los registros cuyo destino sea FRA
    DELETE mt_spfli WHERE airport_to_id = 'FRA'.                               " Elimina filas cuyo destino sea FRA
    out->write( EXPORTING data = mt_spfli name = 'Ej.6: Deleted airport_to_id = FRA' ). " Muestra tras borrado


***************************************************************** EJERCICIO 7 *******************************************************************************

    " Demostración de CLEAR y FREE sobre una itab (usamos el subconjunto de Ej.3: mt_airlines_sub)
    DATA(lv_before) = lines( mt_airlines_sub ).                                " Guarda nº de filas ANTES (para comparar)
    CLEAR mt_airlines_sub.                                                     " Vacía el contenido (pero puede dejar capacidad)
    DATA(lv_after_clear) = lines( mt_airlines_sub ).                           " Cuenta DESPUÉS de CLEAR (debería ser 0)
    FREE mt_airlines_sub.                                                      " Libera la memoria (capacidad) de la tabla
    out->write( |Ej.7: entries ANTES={ lv_before } / DESPUÉS CLEAR={ lv_after_clear } / FREE hecho| ). " Traza informativa


***************************************************************** EJERCICIO 8 *******************************************************************************
*
*    " COLLECT: agregación por clave (carrier_id + connection_id) sumando numéricos
*    DATA lt_seats_src TYPE ty_seats_std.                                       " Fuente con los campos renombrados (seats/bookings)
*    DATA lt_seats     TYPE ty_seats_hashed.                                    " Destino HASHED con clave única para COLLECT
*
*    " Seleccionar sólo lo necesario de /dmo/flight cuando seats_max = 140
*    SELECT FROM /dmo/flight
*           FIELDS carrier_id,                                                 " Clave 1
*                  connection_id,                                             " Clave 2
*                  seats_occupied AS seats,                                   " Campo sumable 1 (renombrado)
*                  price          AS bookings                                 " Campo sumable 2 (renombrado)
*           WHERE seats_max = 140
*           INTO TABLE @lt_seats_src.                                         " Vuelca a la fuente
*
*    " Aplicar COLLECT (suma seats y bookings por clave única)
*    LOOP AT lt_seats_src INTO DATA(ls_s).                                     " Itera cada registro fuente
*      COLLECT ls_s INTO lt_seats.                                             " Si la clave ya existe: suma; si no, inserta
*    ENDLOOP.
*
*    out->write( EXPORTING data = lt_seats name = 'Ej.8: COLLECT seats/bookings por clave' ). " Muestra agregación
*
*
***************************************************************** EJERCICIO 9 *******************************************************************************
*
    " LET en plantillas puede no estar soportado; versión compatible: precalcula y concatena con salto
    IF mt_scarr IS INITIAL.                                                    " Si no se ha cargado /dmo/carrier aún…
      SELECT FROM /dmo/carrier FIELDS * INTO TABLE @mt_scarr.                  " …cárgalo ahora
    ENDIF.

    DATA(lv_carrier) = COND string( WHEN lines( mt_scarr ) > 0                 " Si hay al menos 1 compañía…
                                    THEN mt_scarr[ 1 ]-carrier_id ELSE '' ).   " …toma su carrier_id; si no, vacío
    DATA(lv_price)   = COND string( WHEN lines( mt_flights_type ) > 0          " Si hay vuelos cargados…
                                    THEN mt_flights_type[ 1 ]-price ELSE 0 ).  " …toma el precio del primero; si no, 0

    DATA(lv_info) =                                                            " Construye una cadena multilínea:
      |Carrier={ lv_carrier }| &&                                              " 1ª línea: Carrier=...
      cl_abap_char_utilities=>newline &&                                       " Salto de línea seguro
      |Price={ lv_price }|.                                                    " 2ª línea: Price=...

    out->write( |Ej.9: { lv_info }| ).                                         " Imprime el bloque de texto

*
***************************************************************** EJERCICIO 10 ******************************************************************************
*
    " Uso de BASE en un constructor de tabla para clonar y sobrescribir una fila
    DATA lt_flights_base TYPE STANDARD TABLE OF /dmo/flight WITH EMPTY KEY.    " Itab destino para el clonado

    lt_flights_base = VALUE #(                                                 " Constructor de tabla con BASE
      BASE mt_flights_type                                                     " Copia todas las filas de mt_flights_type
      ( carrier_id    = mt_flights_type[ 1 ]-carrier_id                        " Añade/sobrescribe 1 fila: misma aerolínea
        connection_id = mt_flights_type[ 1 ]-connection_id                     " Misma conexión
        flight_date   = mt_flights_type[ 1 ]-flight_date + 1                   " Fecha desplazada +1 día
        price         = mt_flights_type[ 1 ]-price * '1.05' ) ).               " Precio incrementado un 5% (conversión implícita)

    out->write( EXPORTING data = lt_flights_base name = 'Ej.10: BASE (clonado + override)' ). " Muestra el clonado
*
*
***************************************************************** EJERCICIO 11 ******************************************************************************
*
    " Agrupación de registros: miembros por aeropuerto de ORIGEN
    DATA lt_group_members TYPE STANDARD TABLE OF /dmo/connection WITH EMPTY KEY. " Itab temporal para visualizar miembros

    LOOP AT mt_airlines INTO DATA(ls_conn)                                     " Recorre conexiones de 'SQ'
         GROUP BY ( from_id = ls_conn-airport_from_id ) INTO DATA(g_from).     " Agrupa por aeropuerto de origen (alias from_id)
      CLEAR lt_group_members.                                                  " Limpia acumulador de miembros
      LOOP AT GROUP g_from INTO DATA(ls_m).                                    " Itera los miembros del grupo actual
        APPEND ls_m TO lt_group_members.                                       " Añade cada miembro al acumulador
      ENDLOOP.
      out->write( EXPORTING data = lt_group_members                             " Muestra los miembros del grupo
                  name = |Ej.11: Miembros grupo FROM={ g_from-from_id }| ).
    ENDLOOP.                                                                    " Siguiente grupo

*
***************************************************************** EJERCICIO 12 ******************************************************************************
*
    " Agrupar por clave compuesta (carrier_id + connection_id + from + to)
    LOOP AT mt_airlines INTO ls_conn                                           " Recorre conexiones
         GROUP BY ( grp = VALUE ty_airlines(                                   " Define la clave compuesta en una estructura
                         carrier_id      = ls_conn-carrier_id
                         connection_id   = ls_conn-connection_id
                         airport_from_id = ls_conn-airport_from_id
                         airport_to_id   = ls_conn-airport_to_id ) )
         INTO DATA(g_comp).                                                    " g_comp contiene la clave (estructura grp)

      CLEAR lt_group_members.                                                  " Limpia acumulador
      LOOP AT GROUP g_comp INTO DATA(ls_m2).                                   " Itera miembros con esa clave compuesta
        APPEND ls_m2 TO lt_group_members.                                      " Acumula
      ENDLOOP.

      out->write( EXPORTING data = lt_group_members                             " Muestra los miembros de esa clave
                  name = |Ej.12: Grupo { g_comp-grp-airport_from_id }→{ g_comp-grp-airport_to_id }| ).
    ENDLOOP.                                                                    " Siguiente clave compuesta
*
*
***************************************************************** EJERCICIO 13 ******************************************************************************
*
    " Conteos por from/to con COLLECT (fallback compatible)
    DATA lt_counts_13 TYPE HASHED TABLE OF ty_from_to_cnt_13                    " Tabla hash con clave from/to
                      WITH UNIQUE KEY airport_from_id airport_to_id.

    LOOP AT mt_airlines INTO DATA(ls_conn_13).                                  " Itera conexiones
      DATA(ls_cnt_13) = VALUE ty_from_to_cnt_13(                                " Prepara unidad de conteo
                            airport_from_id = ls_conn_13-airport_from_id
                            airport_to_id   = ls_conn_13-airport_to_id
                            cnt             = 1 ).
      COLLECT ls_cnt_13 INTO lt_counts_13.                                      " Si existe clave, suma cnt; si no, inserta
    ENDLOOP.

    out->write( EXPORTING data = lt_counts_13                                    " Muestra los conteos por par from/to
                name = 'Ej.13: Conteos por from/to (fallback COLLECT)' ).
*
*
***************************************************************** EJERCICIO 14 ******************************************************************************
*
    " Rangos: seats_occupied entre 200 y 400
    DATA lt_range TYPE ty_range_seats.                                         " Rango estándar para seats_occupied
    APPEND VALUE #( sign = 'I' option = 'BT' low = 200 high = 400 ) TO lt_range." Incluye valores entre 200 y 400 (BETWEEN)

    DATA lt_flights_range TYPE STANDARD TABLE OF /dmo/flight WITH EMPTY KEY.   " Tabla resultado del filtro por rango
    SELECT FROM /dmo/flight FIELDS *                                           " Selecciona todos los campos
           WHERE seats_occupied IN @lt_range                                   " Filtra usando el rango definido
           INTO TABLE @lt_flights_range.                                       " Vuelca el resultado

    out->write( EXPORTING data = lt_range         name = 'Ej.14: Rango seats [200..400]' ).       " Muestra el rango
    out->write( EXPORTING data = lt_flights_range name = 'Ej.14: Vuelos dentro del rango' ).      " Muestra los vuelos filtrados
*
*
***************************************************************** EJERCICIO 15 ******************************************************************************
*
    " Sustitución del ENUM por constantes (compatible con todas las releases)

    " 1) Tipo base entero para la “moneda”
    TYPES mty_currency TYPE i.                                     " Tipo simple entero usado para representar la moneda

    " 2) Constantes que representan cada valor (sustituyen al ENUM)
    CONSTANTS:                                                     " Conjunto de constantes simbólicas
      c_curr_initial TYPE mty_currency VALUE 0,                    " 0 → estado inicial
      c_curr_usd     TYPE mty_currency VALUE 1,                    " 1 → USD
      c_curr_eur     TYPE mty_currency VALUE 2,                    " 2 → EUR
      c_curr_cop     TYPE mty_currency VALUE 3,                    " 3 → COP
      c_curr_mex     TYPE mty_currency VALUE 4.                    " 4 → MEX

    " 3) Variable de “moneda” y mapeo a texto
    DATA lv_curr TYPE mty_currency VALUE c_curr_usd.               " Inicializa en USD

    DATA(lv_curr_tx) = SWITCH string(                              " Traduce el valor entero a texto
      lv_curr                                                      " Operando a evaluar
      WHEN c_curr_initial THEN 'Initial'                           " 0 → 'Initial'
      WHEN c_curr_usd     THEN 'USD'                               " 1 → 'USD'
      WHEN c_curr_eur     THEN 'EUR'                               " 2 → 'EUR'
      WHEN c_curr_cop     THEN 'COP'                               " 3 → 'COP'
      WHEN c_curr_mex     THEN 'MEX'                               " 4 → 'MEX'
      ELSE 'Unknown' ).                                            " Cualquier otro → 'Unknown'

    out->write( |Ej.15: Moneda actual = { lv_curr_tx }| ).         " Debe mostrar 'USD'

    " 4) Cambio de “moneda” y nuevo mapeo
    lv_curr = c_curr_eur.                                          " Cambia el valor entero a EUR

    lv_curr_tx = SWITCH string(                                    " Vuelve a traducir a texto tras el cambio
      lv_curr
      WHEN c_curr_initial THEN 'Initial'
      WHEN c_curr_usd     THEN 'USD'
      WHEN c_curr_eur     THEN 'EUR'
      WHEN c_curr_cop     THEN 'COP'
      WHEN c_curr_mex     THEN 'MEX'
      ELSE 'Unknown' ).

    out->write( |Ej.15: Moneda cambiada = { lv_curr_tx }| ).       " Debe mostrar 'EUR'




  ENDMETHOD.
ENDCLASS.
