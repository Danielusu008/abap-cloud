CLASS zcl_performance_der DEFINITION          " Definición de la clase
  PUBLIC                                      " Visibilidad pública (usable desde cualquier paquete)
  FINAL                                       " No permite herencia
  CREATE PUBLIC.                              " Creadora pública (instanciable desde fuera)

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.            " Interfaz para ejecutar la clase desde ADT (método MAIN)
    METHODS constructor.                       " Carga de datos e inicializaciones
    METHODS standard.                          " Lectura por clave en tabla STANDARD
    METHODS sort.                              " Lectura por clave en tabla SORTED
    METHODS hash.                              " Lectura por clave en tabla HASHED

  PROTECTED SECTION.                           " (No se usa en este ejemplo)

  PRIVATE SECTION.                             " Atributos y ayudas internas

    DATA: lt_standard TYPE STANDARD TABLE OF /dmo/booking_m
                  WITH NON-UNIQUE KEY travel_id booking_id booking_date,   " Itab estándar con clave no única
          lt_sort     TYPE SORTED   TABLE OF /dmo/booking_m
                  WITH NON-UNIQUE KEY travel_id booking_id booking_date,   " Itab ordenada por la clave indicada
          lt_hash     TYPE HASHED   TABLE OF /dmo/booking_m
                  WITH UNIQUE      KEY travel_id booking_id booking_date.  " Itab hash con clave única

    DATA: key_travel_id  TYPE /dmo/travel_id,   " Clave elegida: travel_id
          key_booking_id TYPE /dmo/booking_id,  " Clave elegida: booking_id
          key_date       TYPE /dmo/booking_date. " Clave elegida: booking_date

    METHODS set_line_to_read.                  " Calcula y guarda en los atributos una línea “objetivo”
ENDCLASS.



CLASS zcl_performance_der IMPLEMENTATION.

  METHOD constructor.                                                        " Constructor de la clase
    SELECT FROM /dmo/booking_m                                               " Lee la tabla de reservas demo
           FIELDS *                                                          " Todas las columnas
           INTO TABLE @lt_standard.                                          " Carga la itab STANDARD

    SELECT FROM /dmo/booking_m                                               " Segunda lectura (mismo origen)
           FIELDS *                                                          " Idéntico dataset
           INTO TABLE @lt_sort.                                              " Carga la itab SORTED (se ordenará por su key)

    SELECT FROM /dmo/booking_m                                               " Tercera lectura (mismo origen)
           FIELDS *                                                          " Idéntico dataset
           INTO TABLE @lt_hash.                                              " Carga la itab HASHED (se indexará por su key)

    set_line_to_read( ).                                                     " Calcula una línea “de referencia” y guarda su clave en atributos
  ENDMETHOD.

  METHOD standard.                                                            " Lectura en tabla STANDARD por expresión de tabla
    DATA(result) = lt_standard[                                              " Lee la línea cuyo conjunto de claves coincide con…
                       travel_id    = me->key_travel_id                      " travel_id almacenado en los atributos
                       booking_id   = me->key_booking_id                     " booking_id almacenado
                       booking_date = me->key_date ].                        " booking_date almacenado
  ENDMETHOD.

  METHOD set_line_to_read.                                                    " Obtiene una línea “objetivo” y guarda sus claves
    DATA(lv_data) = lt_standard[ CONV i( lines( lt_standard ) * '0.65' ) ].  " Toma aprox. la fila del 65% (convierte a entero)
    me->key_travel_id  = lv_data-travel_id.                                  " Guarda travel_id de esa fila
    me->key_booking_id = lv_data-booking_id.                                 " Guarda booking_id
    me->key_date       = lv_data-booking_date.                               " Guarda booking_date
  ENDMETHOD.

  METHOD hash.                                                                " Lectura en tabla HASHED (acceso promedio O(1))
    DATA(result) = lt_hash[                                                  " Expresión de tabla: busca por clave primaria
                       travel_id    = me->key_travel_id                      " travel_id desde atributos
                       booking_id   = me->key_booking_id                     " booking_id desde atributos
                       booking_date = me->key_date ].                        " booking_date desde atributos
  ENDMETHOD.

  METHOD sort.                                                                " Lectura en tabla SORTED (búsqueda binaria O(log n))
    DATA(result) = lt_sort[                                                  " Expresión de tabla: coincide con la clave primaria
                       travel_id    = me->key_travel_id
                       booking_id   = me->key_booking_id
                       booking_date = me->key_date ].
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.                                            " Punto de entrada ejecutable en ADT
    DATA(lo_flights) = NEW zcl_performance_der( ).                           " Instancia la clase (ejecuta constructor)

    lo_flights->standard( ).                                                 " Prueba lectura en STANDARD
    lo_flights->sort( ).                                                     " Prueba lectura en SORTED
    lo_flights->hash( ).                                                     " Prueba lectura en HASHED

    " out->write( me->key_travel_id ).                                         " Muestra travel_id almacenado
    "out->write( me->key_booking_id ).                                        " Muestra booking_id almacenado
    "out->write( me->key_date ).                                              " Muestra booking_date almacenado



*"---------------------------------------------------------------------------------
*" Definición de un tipo de tabla interna con filas de /dmo/flight
*" Clave primaria NO única por (carrier_id, connection_id, flight_date)
*" → permitirá duplicados en esa combinación pero servirá para ordenar por defecto
*"---------------------------------------------------------------------------------
*TYPES lty_flights TYPE STANDARD TABLE OF /dmo/flight
*                  WITH NON-UNIQUE KEY carrier_id connection_id flight_date.
*
*"---------------------------------------------------------------------------------
*" Declaración de la tabla interna que usaremos en los ejemplos de ordenación
*"---------------------------------------------------------------------------------
*DATA lt_flights TYPE lty_flights.                          " Itab de vuelos con la clave anterior
*
*"---------------------------------------------------------------------------------
*" Carga manual de datos de ejemplo usando constructor VALUE #( ... ).
*" Nota: muchos campos de /dmo/flight son DATS, NUMC o DEC → las comillas serán
*"       convertidas implícitamente (si prefieres, puedes usar CONV <tipo>( ... )).
*"       flight_date es DATS (YYYYMMDD), price suele ser DEC / CURR.
*"---------------------------------------------------------------------------------
*lt_flights = VALUE #(
*  ( client         = sy-mandt                                " Mandante actual del sistema
*    carrier_id     = 'CO'                                    " Compañía aérea
*    connection_id  = '0500'                                  " Conexión (NUMC/char con ceros a la izquierda)
*    flight_date    = '20250201'                              " Fecha de vuelo (YYYYMMDD)
*    plane_type_id  = '123-456'                               " Tipo de avión (texto)
*    price          = '1000'                                  " Precio (se convertirá a DEC/CURR si aplica)
*    currency_code  = 'COP' )                                 " Moneda
*
*  ( client         = sy-mandt
*    carrier_id     = 'MX'
*    connection_id  = '0600'
*    flight_date    = '20250120'
*    plane_type_id  = '747-400'
*    price          = '800'
*    currency_code  = 'MXN' )
*
*  ( client         = sy-mandt
*    carrier_id     = 'QF'
*    connection_id  = '0006'
*    flight_date    = '20230112'
*    plane_type_id  = 'A380'
*    price          = '1600'
*    currency_code  = 'AUD' )
*
*  ( client         = sy-mandt
*    carrier_id     = 'SP'
*    connection_id  = '0700'
*    flight_date    = '20250610'
*    plane_type_id  = '321-654'
*    price          = '100'
*    currency_code  = 'EUR' )
*
*  ( client         = sy-mandt
*    carrier_id     = 'LX'
*    connection_id  = '0900'
*    flight_date    = '20250101'
*    plane_type_id  = '258-963'
*    price          = '50'
*    currency_code  = 'COP' )
*).
*
*"---------------------------------------------------------------------------------
*" Mostrar la tabla ANTES de ordenar
*"---------------------------------------------------------------------------------
*out->write( |Before Sort| ).                                " Título/etiqueta
*out->write( lt_flights ).                                   " Contenido actual de la itab
*
*"=================================================================================
*" SORT con la clave primaria de la itab
*"=================================================================================
*SORT lt_flights.                                            " Ordena por la clave definida en lty_flights:
*                                                            " (carrier_id, connection_id, flight_date) ASC por defecto
*out->write( |Sort by primary key| ).                        " Título/etiqueta
*out->write( lt_flights ).                                   " Tabla ya ordenada por la clave
*
*"=================================================================================
*" SORT por cualquier campo (varios campos) – orden ascendente por defecto
*"=================================================================================
*SORT lt_flights BY currency_code plane_type_id.             " Ordena 1º por moneda, 2º por tipo de avión (ASC/ASC)
*out->write( |Sort by 2 fields| ).                           " Título/etiqueta
*out->write( lt_flights ).                                   " Resultado del orden múltiple
*
*"=================================================================================
*" SORT combinando ASCENDING y DESCENDING por distintos campos
*"=================================================================================
*SORT lt_flights BY carrier_id ASCENDING                     " 1º por compañía (A→Z)
*                   flight_date DESCENDING.                  " 2º por fecha (más reciente primero)
*out->write( |Sort by 2 fields (ASC/DESC)| ).                " Título/etiqueta
*out->write( lt_flights ).                                   " Tabla ordenada con criterios mixtos
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "MISMO CODIGO DE ARRIBA PERO SIN COMENTARIOS
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    TYPES lty_flights TYPE STANDARD TABLE OF /dmo/flight
*                      WITH NON-UNIQUE KEY carrier_id connection_id flight_date.
*
*    DATA lt_flights TYPE lty_flights.
*
*    lt_flights = VALUE #(
*      ( client        = sy-mandt
*        carrier_id    = 'CO'
*        connection_id = '0500'
*        flight_date   = '20250201'
*        plane_type_id = '123-456'
*        price         = '1000'
*        currency_code = 'COP' )
*      ( client        = sy-mandt
*        carrier_id    = 'MX'
*        connection_id = '0600'
*        flight_date   = '20250120'
*        plane_type_id = '747-400'
*        price         = '800'
*        currency_code = 'MXN' )
*      ( client        = sy-mandt
*        carrier_id    = 'CO'
*        connection_id = '0500'
*        flight_date   = '20260201'
*        plane_type_id = 'A380'
*        price         = '1600'
*        currency_code = 'AUD' )
*      ( client        = sy-mandt
*        carrier_id    = 'SP'
*        connection_id = '0700'
*        flight_date   = '20250610'
*        plane_type_id = '321-654'
*        price         = '100'
*        currency_code = 'EUR' )
*      ( client        = sy-mandt
*        carrier_id    = 'LX'
*        connection_id = '0900'
*        flight_date   = '20250101'
*        plane_type_id = '258-963'
*        price         = '50'
*        currency_code = 'COP' )
*    ).
*
*    out->write( |Before Sort| ).
*    out->write( lt_flights ).
*
*    " SORT con la clave primaria de la itab
*    SORT lt_flights.
*    out->write( |Sort by primary key| ).
*    out->write( lt_flights ).
*
*    " SORT por cualquier campo (varios campos) – orden ascendente por defecto
*    SORT lt_flights BY currency_code plane_type_id.
*    out->write( |Sort by 2 fields| ).
*    out->write( lt_flights ).
*
*    " SORT combinando ASCENDING y DESCENDING por distintos campos
*    SORT lt_flights BY carrier_id ASCENDING flight_date DESCENDING.
*    out->write( |Sort by 2 fields (ASC/DESC)| ).
*    out->write( lt_flights ).


    "Mejor manera para eliminar registros duplicados
    "Tener en cuenta que los delet solo borran los registros duplicados que se encuentren uno junto al  otro por eso tendremos que hacer una "ordenacion" con
    "el sort para agrupar los campos repetidos


    "En nuestro ejemplo hay 3 campos clave que tendrian que coincidir el valor de los 3 para que se hiciera el borrado de la fila/S por ello para ser mas
    "especifico utilizamos el comparing + los campos que queremos comparar para borrar dichas filas.
    "sino se pone el comparing solo se borran las filas con los campos repetidos si coninciden todos los campos del KEY
*SORT lt_flights by carrier_id connection_id.
*out->write( lt_flights ).
*
*DELETE ADJACENT DUPLICATES FROM lt_flights  COMPARING CARRIER_ID  CONNECTION_ID.
*
*out->write( lt_flights ).
*

    "REDUCE
    "la expresion REDUCE en sap permite realizar acumulaciones o agrupaciones sobre elementos de una tabla interna, como sumas, restas, hacer medias etc.
    " el reduce 'reduce' todo a un unico valor.


    "sumar todas las filas de una columna de una tabla
*
*SELECT from /dmo/flight
*FIELDS *
*into table @DATA(lt_flight_red).
*
*
*"nota: si price es decimal/moneda, Reduce i "tipo entero"  truncara decimales.
*" en ese caso usa reduce decfloat34 o reduce type of ls_flight_red-price.
*
*
*
*
*DATA(lv_sum) = REDUCE i(                                "calcula la suma total (tipo entero i) de los precios
*    INIT lv_result = 0                                 "inicailiza el "acumulador"  lv_result en 0
*    for ls_flight_red in lt_flight_red                    "itera cada registro de lt_flight_red
*    next lv_result += ls_flight_red-price ).                " acumula el precio de cada vuelo en lv_result
*
*" lo mismo que arriba pero con decimales
*DATA(lv_sum2) = REDUCE decfloat34(                                "calcula la suma total (tipo entero i) de los precios
*    INIT acc = conv  decfloat34( '0.10' )                                  "inicailiza el "acumulador"  lv_result en 0
*    for ls_flight_red in lt_flight_red                    "itera cada registro de lt_flight_red
*    next acc += ls_flight_red-price ).                " acumula el precio de cada vuelo en lv_result
*
*
*out->write( 'suma de el precio de los vuelos' ).
*out->write( lv_sum2 ).

"para sumar de una tabla todos las filas de mas de una columna
*    TYPES:BEGIN OF lty_total,
*            price    TYPE /dmo/flight_price,
*            seatsocc TYPE /dmo/plane_seats_occupied,
*          END OF lty_total.
*
*    SELECT FROM /dmo/flight
*    FIELDS *
*    INTO TABLE @DATA(lt_flight_red).
*
*
*
*    DATA(lv_sum) = REDUCE lty_total(                                    "Devuelve un valor de tipo lty_total con los totales acumulados
*        INIT ls_totals type lty_total                                   " acumulador inicial ( estructura con price y sseatsocc a cero por defecto)
*        FOR ls_flight_red IN lt_flight_red                              "Recorre cada vuelo de la tabla lt_flight_red
*        NEXT ls_totals-price  += ls_flight_red-price                    " suma el precio del vuelo al total de price
*             ls_totals-seatsocc += ls_flight_red-seats_occupied ).      "suma los asientos ocupados al total de seatsocc
*                                                                        "fin del reduce: el resultado se asigna a lv_sum
*
*out->write( 'suma del precio de vuelos y los asientos ocupados' ).
*out->write( lv_sum ).

"Acceso a las tablas internas

  ENDMETHOD.

ENDCLASS.
