CLASS zcl_tablas_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tablas_der IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    TYPES: BEGIN OF ty_persona,
*             nombre TYPE string,
*             edad   TYPE i,
*           END OF ty_persona.
*

    "AÑADIR REGISTROS CON EL INSERT

*   TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
*
*    DATA: lt_personas TYPE ty_tabla_personas,
*          ls_persona  TYPE ty_persona.
*
*
*    ls_persona-nombre = 'Carlos'.
*    ls_persona-edad = 40.
*
*    INSERT ls_persona INTO lt_personas INDEX 1.
*
*    ls_persona-nombre = 'Maria'.
*    ls_persona-edad = 30.
*
*    INSERT ls_persona INTO lt_personas INDEX 2.
*
*    ls_persona-nombre = 'Pedro'.
*    ls_persona-edad = 31.
*
*    INSERT ls_persona INTO lt_personas INDEX 3.
*
*    ls_persona-nombre = 'Juan'.
*    ls_persona-edad = 11.
*
*   INSERT ls_persona INTO lt_personas INDEX 2. " mismo index para forzar su posicion
*
* out->write( lt_personas ).
*
*    LOOP AT lt_personas INTO ls_persona.
*
*     " out->write( |edad { ls_persona-edad } nombre { ls_persona-nombre } | ).
*
*    ENDLOOP.
*
    "insert value

*    DATA lt_aeropuerto TYPE STANDARD TABLE OF /dmo/airport.
*
*    INSERT VALUE #(
*        client  = 100
*        airport_id = 'FRA'
*        name = 'Frankfurt Airport'
*        city = 'Frankfurt/Main'
*        country = 'DE'
*      ) INTO TABLE lt_aeropuerto.
* INSERT VALUE #(
*        client  = 100
*        airport_id = 'FRA'
*        name = 'Frankfurt Airport'
*        city = 'Frankfurt/Main'
*        country = 'PP'
*      ) INTO TABLE lt_aeropuerto.

    """"""""""""""


*  INSERT VALUE #(
*        client  = 100
*        airport_id = 'FRA'
*        name = 'Frankfurt Airport'
*        city = 'Frankfurt/Main'
*        country = 'EE'
*      ) INTO  lt_aeropuerto index 2.  " con esta formula podemos indicar la posicion donde quermos que se introduzca la nueva fila


    "out->write( lt_aeropuerto ).

    " para crear un registro con una linea en blanco
    "insert initial line into table lt_aeropuerto .

    " Para igualar dos tablas internas usamos el like
    "DATA lt_aeropuerto2 like lt_aeropuerto.

    "duplicar el contenido

    "insert lines of lt_aeropuerto into table lt_aeropuerto2.  "Duplica todo el contenido de la tabla original

    "insert lines of lt_aeropuerto to 2 into table lt_aeropuerto2." Copia el contenido de las lineas de la tabla original hasta la linea 2

    "insert lines of lt_aeropuerto from 2 to 3 into table lt_aeropuerto2."Copia el contenido de las lineas de la tabla original desde la linea inicial que se le indica hasta la linea final


    "AÑADIR REGISTROS CON EL APPEND
    "Añade un registro al final de la tabla interna, solo se usa en las standard. hace los mismo que los inserte, mejor usar los insert.

*    TYPES: BEGIN OF ty_persona,
*             nombre TYPE string,
*             edad   TYPE i,
*           END OF ty_persona.
*
*  TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
**
*    DATA: lt_personas TYPE ty_tabla_personas,
*          ls_persona  TYPE ty_persona.
**
*
*
*    ls_persona-nombre = 'Daniel'.
*    ls_persona-edad  = '23'.
*
*
*
*    APPEND ls_persona TO lt_personas.
*
*    out->write( lt_personas ).

    """ declaracion lineal del append

*    TYPES: BEGIN OF ty_persona,
*             nombre TYPE string,
*             edad   TYPE i,
*           END OF ty_persona.
*
*    TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
*
*    DATA: lt_personas TYPE ty_tabla_personas.
*
*APPEND VALUE #(
*
*        nombre = 'Daniel'
*        edad   = 15
*
* ) to lt_personas.

    """"""
    "copiar contenido de unta tabla a otra
*    DATA lt_personas2 LIKE  lt_personas.
*
*    APPEND LINES OF lt_personas TO lt_personas2.
*
*    APPEND LINES OF lt_personas TO 2 TO  lt_personas2.
*
*    APPEND LINES OF lt_personas FROM 4 TO 6 TO  lt_personas2.

    "AÑADIR REGISTROS CON EL VALUE

*    TYPES: BEGIN OF ty_persona,
*             nombre TYPE string,
*             edad   TYPE i,
*           END OF ty_persona.
*
*    TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
*
*
*    DATA(lt_persona) = VALUE ty_tabla_personas(
*    ( nombre = 'Ana' edad = 25 )
*    ( nombre = 'Javier' edad = 45 )
*    ( nombre = 'Lucia' edad = 22 )
*
*
*    ).
*
*    out->write( lt_persona ).
*
*    DATA ls_persona TYPE ty_persona.
*
*    LOOP AT lt_persona INTO ls_persona.
*
*      out->write( |Nombre: { ls_persona-nombre }, Edad: { ls_persona-edad }| ).
*
*    ENDLOOP.

    "extraemos todo de la base de datos / la tabla externa
*data lt_aeropuerto type STANDARD TABLE OF /dmo/airport.
*
*lt_aeropuerto = value #(
*
*        (
*        client = 100
*        airport_id = 'FRA'
*        name = 'Frankfurt Airport'
*        city = 'Frankfurt/Main'
*        country = 'DE'
*        )
*
*                (
*        client = 100
*        airport_id = 'RRA'
*        name = 'Frankfurt Airport'
*        city = 'Frankfurt/Main'
*        country = 'RE'
*        )
* ).
*
*out->write( lt_aeropuerto ).

    "READ TABLE
    "Read table con indice


*    SELECT FROM /dmo/airport
*    FIELDS *
*    WHERE country = 'TR'
*    INTO TABLE @DATA(lt_flights).
*
*    IF sy-subrc = 4.
*
*      READ TABLE lt_flights INTO DATA(ls_flights) INDEX 2.
**      out->write( data = lt_flights name = `tabla de vuelos` ).
**      out->write( data = ls_flights name = `Estructura vuelos` ).
*
*      READ TABLE lt_flights INTO DATA(ls_flights2) INDEX 4 TRANSPORTING airport_id city .
*      out->write( data = ls_flights2 name = `Estructura vuelos` ).
*
*
*    ENDIF.

    """"

*   SELECT FROM /dmo/airport
*    FIELDS *
*    WHERE country = 'DE'
*    INTO TABLE @DATA(lt_flights).
*
*    IF sy-subrc = 0.
*
*      READ TABLE lt_flights ASSIGNING FIELD-SYMBOL(<lfs_flight>) index 3.
*        out->write( data = <lfs_flight> name = `<lfs_flight>` ).
*
*
*    ENDIF.


    """""""""
    "la forma moderna de usar del read table con indiceç
*   SELECT FROM /dmo/airport
*    FIELDS *
*    WHERE country = 'DE'
*    INTO TABLE @DATA(lt_flights).
*
*    out->write( lt_flights ).

    "DATA(ls_data) = lt_flights[ 2 ].
*out->write( data = ls_data name = `esta es nuestra estructura local` ).
*
*
*DATA(ls_data2) = value #( lt_flights[ 20 ] default lt_flights[ 1 ] ) .

    "READ TABLE CON CLAVE

*   SELECT FROM /dmo/airport
*    FIELDS *
*    WHERE country = 'DE'
*    INTO TABLE @DATA(lt_flights).
*
*
* IF sy-subrc = 0.
*
* READ TABLE lt_flights into data(ls_flight) WITH KEY city = 'Berlin'.
*out->write( data = lt_flights name = `lt_flights` ).
*
*out->write( data = ls_flight name = `ls_flight` ).
*
*
*endif.

    "forma moderna de hacer lo anterior

*
* SELECT FROM /dmo/airport
*    FIELDS *
*    WHERE country = 'DE'
*    INTO TABLE @DATA(lt_flights).

*DATA(ls_flight2) = lt_flights[ airport_id = 'MUC' ].
*out->write( data = ls_flight2 name = `ls_flight2` ).

*"""forma moderna
*
*DATA(ls_flight2) = lt_flights[ airport_id = 'MUC' ]-name.
*out->write( data = ls_flight2 name = `ls_flight2` ).

    """"""""""""
    "Corresponding.

*    TYPES:BEGIN OF ty_flights,
*            carrier_id    TYPE /dmo/carrier_id,
*            connection_id TYPE /dmo/connection_id,
*            flight_date   TYPE /dmo/flight_date,
*            animales      TYPE string,
*            currency_code TYPE /dmo/currency_code,
*          END OF ty_flights.
*
*    DATA: lt_my_flights TYPE STANDARD TABLE OF ty_flights.
*    " ls_my_flight type ty_flights.
*
*    """"""""
*    SELECT FROM /dmo/flight
*    FIELDS *
*    WHERE currency_code = 'EUR'
*    INTO TABLE @DATA(lt_flights).
*
*    """""""""""
*
*    MOVE-CORRESPONDING lt_flights TO lt_my_flights.
*
*    out->write( data = lt_flights name = `tabla lt_flights` ).
*    out->write( |\n| ).
*    out->write( data = lt_my_flights name = `tabla lt_my_flights` ).

    """""""""""""""
    "move corresponding moderno
*    TYPES:BEGIN OF ty_flights,
*            carrier_id    TYPE /dmo/carrier_id,
*            connection_id TYPE /dmo/connection_id,
*            flight_date   TYPE /dmo/flight_date,
*            animales      TYPE string,
*            currency_code TYPE /dmo/currency_code,
*          END OF ty_flights.
*
*    DATA: lt_my_flights TYPE STANDARD TABLE OF ty_flights.
*    " ls_my_flight type ty_flights.
*
*    """"""""
*    SELECT FROM /dmo/flight
*    FIELDS *
*    WHERE currency_code = 'EUR'
*    INTO TABLE @DATA(lt_flights).
*
*
*    lt_my_flights = CORRESPONDING #( lt_flights ).
*
*
*
*
*
*    out->write( data = lt_flights name = `tabla lt_flights` ).
*    out->write( |\n| ).
*    out->write( data = lt_my_flights name = `tabla  lt_my_flights` ).

    """"""""""""""
    "keeping trget lines
*
*  TYPES:BEGIN OF ty_flights,
*            carrier_id    TYPE /dmo/carrier_id,
*            connection_id TYPE /dmo/connection_id,
*            flight_date   TYPE /dmo/flight_date,
*            animales      TYPE string,
*            currency_code TYPE /dmo/currency_code,
*          END OF ty_flights.
*
*    DATA: lt_my_flights TYPE STANDARD TABLE OF ty_flights.
*    " ls_my_flight type ty_flights.
*
*    """"""""
*    SELECT FROM /dmo/flight
*    FIELDS *
*    WHERE currency_code = 'EUR'
*    INTO TABLE @DATA(lt_flights).
*
*
*    lt_my_flights = CORRESPONDING #( lt_flights ).
*
*
*    MOVE-CORRESPONDING lt_flights TO lt_my_flights KEEPING TARGET LINES.
*
*
*    out->write( data = lt_flights name = `tabla lt_flights` ).
*    out->write( |\n| ).
*    out->write( data = lt_my_flights name = `tabla  lt_my_flights` ).
    """"""""""""""""""""""""""""""""""""""""""""""""""2
    "chequeo de registros



*    SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @DATA(lt_flights).
    """""""""""""""""""""""""""""""""""""""""""  esto y lo de arriba son dos formas de hacer exactamente lo mismo
*    DATA lt_flights TYPE STANDARD TABLE OF /dmo/flight.
*    SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @lt_flights.
*
* out->write( lt_flights ).
*
*    IF sy-subrc = 0.
*
*      READ TABLE lt_flights WITH KEY connection_id = '0403' TRANSPORTING NO FIELDS.
*
*
*
*
*      IF sy-subrc = 0.
*
*        out->write( 'el vuelo existe en la base de datos' ).
*      ELSE.
*        out->write( 'el vuelo NO existe en la base de datos' ).
*      ENDIF.
*
*    ENDIF.
    "forma moderna

* DATA lt_flights TYPE STANDARD TABLE OF /dmo/flight.
*    SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @lt_flights.
*
* out->write( lt_flights ).
*
*    IF sy-subrc = 0.
*
*
*    IF line_exists( lt_flights[ connection_id = '0404' ] ) .
*
*        out->write( 'el vuelo existe en la base de datos' ).
*      ELSE.
*        out->write( 'el vuelo NO existe en la base de datos' ).
*      ENDIF.
*
*    ENDIF.

    "indice de un registro

    "line_index
    "devuelve el numero de linea donde se encuentra ese vuelo/registro.
*    SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @DATA(lt_flights).
*
*
*    READ TABLE lt_flights WITH KEY connection_id = '0403' TRANSPORTING NO FIELDS.

*    DATA(lv_index) = sy-tabix.
*    out->write( data = lt_flights name = `lt_flights` ).
*    out->write( lv_index ).

    "froma moderna
*    SELECT FROM /dmo/flight
*     FIELDS *
*     WHERE carrier_id = 'LH'
*     INTO TABLE @DATA(lt_flights).
*
*    DATA(lv_index) = line_index( lt_flights[ connection_id = '0401' ] ).
*
*    out->write( data = lt_flights name = `lt_flights` ).
*    out->write( lv_index ).
*
*
*    "lines, numero total de lineas en la tabla
*    data(lv_num) = lines( lt_flights ).
*    out->write( data = lv_num name = `lv_num` ).

    "Loop at

* TYPES: BEGIN OF ty_persona,
*             nombre TYPE string,
*             edad   TYPE i,
*           END OF ty_persona.
*
*    TYPES: ty_tabla_personas TYPE STANDARD TABLE OF ty_persona WITH EMPTY KEY.
*
*
*    DATA(lt_persona) = VALUE ty_tabla_personas(
*    ( nombre = 'Ana' edad = 25 )
*    ( nombre = 'Javier' edad = 45 )
*    ( nombre = 'Lucia' edad = 22 )
*
*
*
*    ).
*
*    out->write( lt_persona ).
*
*    DATA ls_persona TYPE ty_persona.
*
*    LOOP AT lt_persona INTO ls_persona where nombre = 'Ana' .
*
*      out->write( |Nombre: { ls_persona-nombre }, Edad: { ls_persona-edad }| ).

    " ENDLOOP.
    "loop con assigning field-symbol


*    SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @DATA(lt_flights).
*
*    DATA ls_flight TYPE /dmo/flight.
*
*"loop "normal"
*
*    LOOP AT lt_flights INTO ls_flight.
*
*      out->write( data = ls_flight name = `ls_flight` ).
*    ENDLOOP.
*
*
*    """"""""""""""""""""""""""""""
*
*"loop con where y field-symbol
*    LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<fs_flight>) WHERE connection_id = '0403'.
*
*      "out->write( data = <fs_flight> name = `<fs_flight>` ).
*    ENDLOOP.
*    out->write( |\n| ).
*    out->write( |\n| ).
*
*
*"loop con where y estructura creada en linea para almacenar valores
*    LOOP AT lt_flights INTO DATA(ls_flight2) WHERE connection_id = '0403'.
*
*      out->write( data = ls_flight2 name = `fs_flight2` ).
*
*    ENDLOOP.
    """""""""""""""
*    data lv_var type i value 0.
*
*    SELECT FROM /dmo/flight
*      FIELDS *
*      WHERE carrier_id = 'LH'
*      INTO TABLE @DATA(lt_flights).
*
*    DATA ls_flight TYPE /dmo/flight.
*
*    LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<fs_flight>) from 3 to 8.
*
*
*      <fs_flight>-currency_code = 'COP'.
*
*
*    ENDLOOP.
*    out->write( data = lt_flights name = `lt_flights` ).



*  " Paso 1: Leer todas las agencias
*    SELECT FROM /dmo/agency
*      FIELDS *
*      INTO TABLE @DATA(lt_agencias).
*
*    " Mostrar contenido original
*    out->write( data = lt_agencias name = `Antes de la anonimización` ).
*
*    " Paso 2: Recorrer y aplicar condiciones lógicas
*    LOOP AT lt_agencias ASSIGNING FIELD-SYMBOL(<fs_agencia>).
*
*      " Si NO está en Alemania Y su web contiene la palabra 'tour'
*      IF <fs_agencia>-country_code <> 'DE'  AND <fs_agencia>-web_address CP '*tour*'.
*
*        " Paso 3: Anonimizar el correo
*        <fs_agencia>-email_address = 'oculta@demo.com'.
*
*      ENDIF.
*
*    ENDLOOP.
*
*    " Paso 4: Mostrar resultado
*    out->write( data = lt_agencias name = `Después de la anonimización` ).

    "FOR

*types: BEGIN OF ty_flights,
*       iduser type /dmo/customer_id,
*       aircode type /dmo/carrier_id,
*       flightnum type /dmo/connection_id,
*       key type land1,
*       seat type /dmo/plane_seats_occupied,
*       flightdate type /dmo/flight_date,
*       END OF TY_FLIGHTS.
*
**
**
**
**
**
*DATA: lt_flights_info type TABLE of ty_flights,
*      lt_my_flights type table of ty_flights.
**
**
**"for con el until
**
*lt_my_flights = VALUE #( for i = 1 until i > 30
*
*        (     iduser = | { 123456 + i } - USER |
*               aircode = 'LH'
*               flightnum = 00001 + i
*               key = 'US'
*               seat = 0 + i
*               flightdate = cl_abap_context_info=>get_system_date(  ) + 1 ) ).
*
*
*out->write( data = lt_my_flights name = `lt_my_flights` ).
*out->write( |\n| ).
*out->write( |\n| ).

    """""""""""
    " con el while
    "FOR
*
*    TYPES: BEGIN OF ty_flights,
*             iduser     TYPE /dmo/customer_id,
*             aircode    TYPE /dmo/carrier_id,
*             flightnum  TYPE /dmo/connection_id,
*             key        TYPE land1,
*             seat       TYPE /dmo/plane_seats_occupied,
*             flightdate TYPE /dmo/flight_date,
*           END OF ty_flights.
*
*
*
*
*
*
*    DATA: lt_flights_info TYPE TABLE OF ty_flights,
*          lt_my_flights   TYPE TABLE OF ty_flights..




*lt_my_flights = VALUE #( for i = 1 WHILE i <= 20
*
*        (     iduser = | { 123456 + i } - USER |
*               aircode = 'LH'
*               flightnum = 00001 + i
*               key = 'US'
*               seat = 0 + i
*               flightdate = cl_abap_context_info=>get_system_date(  ) + 1 ) ).
*
*
*out->write( data = lt_my_flights name = `lt_my_flights` ).

    """""""""
    "rellenar una tabla con otra tabla usando el for

*
*types: BEGIN OF ty_flights,
*       iduser type /dmo/customer_id,
*       aircode type /dmo/carrier_id,
*       flightnum type /dmo/connection_id,
*       key type land1,
*       seat type /dmo/plane_seats_occupied,
*       flightdate type /dmo/flight_date,
*       END OF TY_FLIGHTS.
*
*
*
*
*
*
*DATA: lt_flights_info type TABLE of ty_flights,
*      lt_my_flights type table of ty_flights.




*    lt_flights_info = VALUE #( FOR ls_my_flight IN lt_my_flights
*
*            (      iduser    = ls_my_flight-iduser
*                   aircode   = ls_my_flight-aircode
*                   flightnum = ls_my_flight-flightnum
*                   key       = ls_my_flight-key
*                   seat      = ls_my_flight-seat
*                   flightdate = ls_my_flight-flightdate   ) ).
*
*
*    out->write( data = lt_my_flights name = `lt_my_flights` ).

*
*    lt_flights_info = VALUE #( FOR ls_my_flight IN lt_my_flights
*    WHERE (  aircode = 'LH' AND flightnum < 0012 )
*
*            (      iduser    = ls_my_flight-iduser
*                   aircode   = ls_my_flight-aircode
*                   flightnum = ls_my_flight-flightnum
*                   key       = ls_my_flight-key
*                   seat      = ls_my_flight-seat
*                   flightdate = ls_my_flight-flightdate   ) ).
*
*
*    out->write( data = lt_my_flights name = `lt_my_flights` ).

    """"""""""""""""""222
    "for anidado
*
*    TYPES: BEGIN OF ty_flights,
*             aircode     TYPE /dmo/carrier_id,
*             flightnum   TYPE /dmo/connection_id,
*             flightdate  TYPE /dmo/flight_date,
*             flightprice TYPE /dmo/flight_price,
*             currency    TYPE /dmo/currency_code,
*           END OF ty_flights.
*
* "creamos primera tabla lt_flights_type, que extrae datos de la base de datos de /dmo/flight
*    SELECT FROM /dmo/flight
*         FIELDS *
*         INTO TABLE @DATA(lt_flights_type).
*
*
* "creamos segunda tabla lt_airline, que extrae datos de la base de datos de /dmo/booking_m
*    SELECT FROM /dmo/booking_m
*       FIELDS carrier_id, connection_id , flight_price, currency_code
*       INTO TABLE @DATA(lt_airline)
*       UP TO 20 ROWS.
*
*"creamos tercera tabla que es de tipo SORTED!!!! a diferencia de con las que hemos trabajado anteriormente que siempre eran estandar.
*"y le indicamos que herda los tipos de ty_flights y tiene una key no unica que hace referencia al campo/columna flightprice
*    DATA lt_final TYPE SORTED TABLE OF ty_flights WITH NON-UNIQUE KEY flightprice.
*
*
*"continuamos con el proceso de creacion de la lt_final usando una expresion de value con for anidados
*    lt_final = VALUE #(
*
*    "primer bucle for : recorre la tabla lt_flgiths_type
*    "filtra solo los vuelos cuyo carrier_id sea 'AA'
*     FOR ls_flight_type IN lt_flights_type WHERE ( carrier_id = 'AA' )
*
*
*                          "segundo bucle for anidado:recorre la tabla lt_airline
*                          "solo se selecciona los registros que coinciden en carrier_id con el vuelo actual
*                         FOR ls_airline IN lt_airline WHERE (  carrier_id = ls_flight_type-carrier_id )
*
*                            "crea una estructura para cada combinacion valida de vuelo y aerolinia
*                         ( aircode     = ls_flight_type-carrier_id
*                           flightnum   = ls_flight_type-connection_id
*                           flightdate  = ls_flight_type-flight_date
*                           flightprice = ls_airline-flight_price
*                           currency    = ls_airline-currency_code )  ).
*
*
*
*    out->write( data = lt_flights_type name = `lt_flights_type` ).
*    out->write( |\n| ).
*    out->write( data = lt_airline name = `lt_airline` ).
*    out->write( |\n| ).
*    out->write( data = lt_final name = `tabla generada con las dos anteriores lt_final ` ).



    "select "normal"

    SELECT FROM /dmo/flight
          FIELDS *
          WHERE carrier_id = 'LH'
         INTO TABLE @DATA(lt_flights).


    "select a una tabla interna (no aconsejado hacer )
    SELECT carrier_id, connection_id, flight_date
    FROM @lt_flights AS lt
    INTO TABLE @DATA(lt_flights_copy).
*
*   out->write( data = lt_flights name = `lt_flights` ).
    " out->write( data = lt_flights_copy name = `lt_flights_copy` ).


    "sentencia SORT
    "ordenar tablas ( no tiene sentido para las tablas de tipo shorted) si para las estandar y las hash

*out->write( data = lt_flights_copy name = `lt_flights_copy` ).
*sort lt_flights_copy by flight_date DESCENDING connection_id ASCENDING.
*out->write( data = lt_flights_copy name = `lt_flights_copy ordenado` ).

    "modificar registros

    "forma del clasico
*out->write( data = lt_flights name = `ANTES / lt_flights` ).
*
*loop at lt_flights into data(ls_flight).
*ls_flight-flight_date = cl_abap_context_info=>get_system_date(  ).
*
*MODIFY lt_flights from ls_flight INDEX 2.
*ENDLOOP.
*out->write( data = lt_flights name = `Despues / lt_flights` ).


*
*
*    out->write( data = lt_flights name = `ANTES / lt_flights` ).
*
*    LOOP AT lt_flights INTO DATA(ls_flight).
*
*
*      IF ls_flight-connection_id > '0401'.
*        ls_flight-connection_id = '4000'.
*        MODIFY lt_flights FROM ls_flight TRANSPORTING connection_id.
*
*      ENDIF.
*
*
*    ENDLOOP.
*    out->write( data = lt_flights name = `Despues / lt_flights` ).
*



    "forma moderna






    out->write( data = lt_flights name = `ANTES / lt_flights` ).

    LOOP AT lt_flights INTO DATA(ls_flight).
      IF ls_flight-connection_id > '0401'.
        ls_flight-connection_id = cl_abap_context_info=>get_system_date(  ).

        MODIFY lt_flights FROM VALUE #(    connection_id  = '4000'
                                           carrier_id = 'TT'
                                           plane_type_id   = 'YY'  ) TRANSPORTING carrier_id plane_type_id connection_id .


      ENDIF.

    ENDLOOP.
    out->write( data = lt_flights name = `DESPUES / lt_flights` ).


    """" eliminar registros

*DATA: lt_flights_struc TYPE STANDARD TABLE OF /dmo/airport,
*      ls_flights_struc TYPE /dmo/airport.
*
*
*SELECT FROM /dmo/airport
*  FIELDS *
*  WHERE country EQ 'US'
*  INTO TABLE @lt_flights_struc.
*
*
*IF sy-subrc EQ 0.
*  out->write( data = lt_flights_struc name = `BEFORE lt_flights_struc` ).
*
*  " Recorremos la tabla para borrar ciertos aeropuertos
*  LOOP AT lt_flights_struc INTO ls_flights_struc.
*
*    " Si el ID del aeropuerto es JFK, BNA o BOS, lo eliminamos
*    IF ls_flights_struc-airport_id = 'JFK' or
*       ls_flights_struc-airport_id = 'BNA' OR
*       ls_flights_struc-airport_id = 'BOS'.
*
*      " Borramos el registro de la tabla interna
*      DELETE TABLE lt_flights_struc FROM ls_flights_struc.
*
*    ENDIF.
*
*  ENDLOOP.
*
*ENDIF.
*
*
*out->write( |\n| ).
*
*
*out->write( data = lt_flights_struc name = `AFTER lt_flights_struc` ).
*
*""""""""
*
*DELETE lt_flights_struc index 2.
*out->write( data = lt_flights_struc name = `AFTER lt_flights_struc` ).
*"""
*DELETE lt_flights_struc from 3 to 6.
*out->write( data = lt_flights_struc name = `AFTER lt_flights_struc` ).

  ENDMETHOD.
ENDCLASS.






