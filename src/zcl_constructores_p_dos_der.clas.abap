CLASS zcl_constructores_p_dos_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_constructores_p_dos_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    "value

    "corresponding
    "mapping
*
*    TYPES: BEGIN OF ty_employee,
*             emp_name TYPE string,
*             emp_age  TYPE i,
*           END OF ty_employee.
*
*
*    TYPES: BEGIN OF ty_person,
*             name TYPE string,
*             age  TYPE i,
*           END OF ty_person.
*
*    DATA: lt_employee TYPE TABLE OF ty_employee,
*          lt_person   TYPE TABLE OF ty_person,
*          lt_client   TYPE TABLE OF ty_person.
*
*    lt_employee = VALUE #( ( emp_name = 'Pedro'
*                              emp_age = 30 ) ).
*
*    "out->write( data = lt_employee name = 'lt_employee' ).
*    lt_person = CORRESPONDING #( lt_employee MAPPING name = emp_name  " usamos el mapping para "igualar" los encabezado de las dos tablas
*                                                      age = emp_age ).
**    out->write( |\n| ).
**    out->write( data = lt_person name = 'lt_person' ).
*
*    "corresponding con el BASE
*
*    lt_client =  VALUE #( ( name = 'Maria '
*                            age = 50 ) ).
*
*    lt_client = CORRESPONDING #( BASE ( lt_client ) lt_person ).
*
**    out->write( |\n| ).
**    out->write( data = lt_client name = 'lt_client' ).
*
*    "Excep
*
*    lt_person = CORRESPONDING #( lt_client EXCEPT name ).
*    out->write( |\n| ).
*    out->write( data = lt_person name = 'lt_person' ).

*    "discarting duplicates
*
*    DATA: lt_itab1 TYPE TABLE OF ty_person WITH EMPTY KEY,
*          lt_itab2 TYPE  TABLE OF ty_person WITH UNIQUE KEY name.
*
*    lt_itab1  = VALUE #( ( name = 'maria'  age = 22 )
*                         ( name = 'maria'  age = 25 )
*                         ( name = 'maria'  age = 22 )
*                         ( name = 'Pedro'  age = 24 ) ).
*
*    out->write( |\n| ).
*    out->write( data = lt_itab2 name = 'lt_itab2' ).
*    out->write( |\n| ).
*    out->write( data = lt_itab1 name = 'lt_itab1' ).
*
*
*    lt_itab2 = CORRESPONDING #( lt_itab1 DISCARDING DUPLICATES ).
*    out->write( |\n| ).
*    out->write( data = lt_itab2 name = 'lt_itab2' ).


    "NEW

*"Declaramos una variable de referencia a un entero (i)
*data lo_data type ref to i.
*
*"creamos un nuevo objeto de tipo entero (inferido por # ) con valor inicial 12345
*lo_data = NEW #( 12345 ).
*
*"mostramos el valor de la referencia lo_data.
*out->write( lo_data ).
*
*"declarmos y creamos una referencia a un objeto string con el valor de 'Experis'.
*
*Data(lo_data2) = NEW string( 'Experis' ).
*
*out->write( lo_data2 ).
    """""""""
    "CONV le pasa el valor de una variable a otra modificando su tipo al especificado con el conv

*
*DATA(lv_number) = 2025.
*
*DATA(lv_text) = CONV string( lv_number ) .
*
*out->write( |Numero original (entero): { lv_number } | ).
*
*out->write( |Numero convertido a texto: { lv_text }| ).
*
*DATA(lv_str_number) = '150'.
*DATA(lv_int_number) = conv i( lv_str_number ).
*
*out->write( |cadena original: { lv_str_number } | ).
*
*out->write( |Numero convertida a entero: { lv_int_number }| ).

*    "EXACT Es igual que el CONV pero con "mas poder" si hay perdida de datos en el proceso de conversion lanza
*    "un error en tiempo de ejecucion.
*
*    DATA lv_num  TYPE p LENGTH 5 DECIMALS 2 VALUE '123.45'.
*
*    "converion con CONV (funciona incluso si hubiera redondeo)
*    DATA(lv_conv) = CONV i( lv_num ). "resultado: 123
*    out->write( |CONV a entero: { lv_conv }| ).
*
*    "converion con EXACT (falla si hay perdida de datos)
*
*    TRY. " utilizamos el try catch que hemos visto en otras clases para controlar el error en caso
*           " de que se diese una perdida de datos por culpa de la conversion.
*           "en el caso de este ejemplo se produce la perdida pero si le quitamos en la declaracion del variable
*           "lv_num el .45 ya si que no nos daria ninguna exacepcion
*
*        DATA(lv_exact) = EXACT i( lv_num ).
*        out->write( |EXACT a entero: { lv_exact }| ).
*
*      CATCH cx_sy_conversion_error INTO DATA(lx_error).
*        out->write( |Error EXACT: { lx_error->get_text(  ) }| ).
*
*    ENDTRY.

    "REF Crea una referencia de datos (un puntero) a un valor o estructura existente, sin
    "copiar el contenido. Es util cuando: queremos pasar gran cantidad de datos sin copiarlos
    "modificar el valor original desde otro lugar.
    "trabajar con objetos dinamicos ( ya veremos que es la programacion dinamica mas adelante)

*Data: lv_int_value type i VALUE 100,
*      lv_ref_int type REF TO i.   "declara una referencia a un entero
*
* lv_ref_int = REF #( lv_int_value ). "crea una referencia al dato lv_int_value
*                                     "No copia el valor, solo apunta a la misma direccion de memoria
*
*out->write( data = lv_int_value name = 'Original value' ).
*
*out->write( data = lv_ref_int->* name = 'Value desde la referencia' ).
*"accede al valor apuntando por la referneica lv_ref_int usando ->*
*"esto mostrara el mimso valor (100), pero leido a traves de la referncia



*    """"" segundo ejemplo del ref"""""""""""
*
*TYPES: Ty_tabla_vuelos TYPE STANDARD TABLE OF /dmo/flight WITH EMPTY KEY.
*
*data lt_fligth TYPE ty_tabla_vuelos.
*
*
*
*    lt_fligth = VALUE #( ( client = 100
*                           carrier_id = 'CO'
*                           connection_id = 1101
*                           currency_code = 'COP'
*                           flight_date = sy-datum
*                           plane_type_id = 'AF-1234'
*                           price         = 200
*                           seats_max  = 100
*                           seats_occupied = 20 )
*
*                         ( client = 100
*                           carrier_id = 'MX'
*                           connection_id = 1102
*                           currency_code = 'MXN'
*                           flight_date = cl_abap_context_info=>get_system_date(  )
*                           plane_type_id = 'XX-1234'
*                           price         = 400
*                           seats_max  = 60
*                           seats_occupied = 50 )
*
*                         ( client = 100
*                           carrier_id = 'PE'
*                           connection_id = 1103
*                           currency_code = 'EUR'
*                           flight_date = sy-datum
*                           plane_type_id = 'PE-1234'
*                           price         = 150
*                           seats_max  = 80
*                           seats_occupied = 30 )
*     ).
*
*
*DATA(lr_flight) = REF #( lt_fligth[ 2 ] ).
*
*out->write( data = lr_flight->* name = 'Referencia  index/indice  2'   ).


**    "CAST SE usa para convertir referencias de un tipo a otro. (NO CONVIERTE VALORES COMO EL CONV O EXACT, SINO REFERENCIAS )
**    "dicho de otro modo, convierte referencias de objetos o datos de un tipo de referencia a otro tipo de referencia
**    "compatible.
**
*    TYPES: BEGIN OF ty_struc,
*             col1 TYPE i,
*             col2 TYPE i,
*
*           END OF ty_struc.
*
*"declaramos una referencia generica a datos
*
*DATA lr_data type ref to data.
*
*"declaramos una variable de tipo ty_struc (estructura tipada)
*
*data ls_int type ty_struc.
*
*"creamos en memoria un objeto del tipo ty_struc
*    "guardamos su referncia en lr_data
*    "NEW devuelve una referencia, no una copia
*
*lr_data = NEW ty_struc(  ).
*
*"usamos el CAST para convertir la referencia generica lr_data a una referencia del tipo ty_struc , y ->* para desreferenciar
*"y copiar el contenido completo en ls_int
*
*ls_int = CAST ty_struc( lr_data )->*.
*
*"accedemos directamente al campo col1 usando CAST.
*"esto no copia toda la estructura, solo lee col1.
*
*ls_int-col1 = cast ty_struc( lr_data )->col1.
*
*"lo mismo pero con el col2
*ls_int-col2 = cast ty_struc( lr_data )->col2.
*
*
*out->write( data = ls_int name = 'ls_int' ).
*
*
*out->write( data = ls_int-col1 name = 'ls_int-col1' ).
*
*out->write( data = ls_int-col2 name = 'ls_int-col2' ).


    "FILTER: Es una expresion de ABAP que crea una nueva tabla interna filtrando los
    "registros de otra tabla segun "unas condiciones"

    "las condiciones pueden basarse en valores individuales o en una tabla de RANGOS
    "la tabla interna en la que se utiliza el operdador filter debe tener al menos una
    "clave ordenada o una clave hash ultilizada para el acceso

    "declaracion
     "de tablas

*    DATA: lt_flights_all   TYPE STANDARD TABLE OF /dmo/flight,
*          lt_flights_final TYPE STANDARD TABLE OF /dmo/flight,
*          lt_filter        TYPE SORTED TABLE OF /dmo/flight-carrier_id  "tabla de filtro( solo una columan)
*                           WITH UNIQUE KEY table_line. "clave unica sobre table_line( el propio valor)
*
*
*    SELECT from /dmo/flight
*            fields *
*            into table @lt_flights_all.
*
*    "contruir la lista de aerolinias permitidas (IDs de compañia)
*    " Value #(...)  crear la tabla 'lt_filter' con los valores indicados en filas de una sola columna ( table_line)
*
*    lt_filter = value #( ( 'LH ' ) ( 'AA ' ) ( 'UA ' ) ).
*
*
*   "filtrando en memoria:
*        "-Filter #(...)  toma lt_flights_all como base
*        "-IN lt_filter indica que usaremos la tabla de filtro como referencia
*        "-WHERE carrier_id = table_line mantiene solo las filas cuyo carrier_id esta en lt_filter
*
*   lt_flights_final = FILTER #( lt_flights_all IN lt_filter where carrier_id = table_line ).
*
*   out->write( name = 'lt_flights_all' data = lt_flights_all ).
*    out->write( name = 'lt_flights_final (soloLH , AA , UA )  ' data = lt_flights_final ). " LH , AA , UA



*DATA: lt_flights_all   TYPE STANDARD TABLE OF /dmo/flight,
*      lt_flights_final TYPE STANDARD TABLE OF /dmo/flight,
*
*      " Tabla de filtro: una sola columna con el mismo tipo que plane_type_id
*      lt_plane_types   TYPE SORTED TABLE OF /dmo/flight-plane_type_id
*                       WITH UNIQUE KEY table_line.
*
*" 1) Cargar todos los vuelos (si prefieres filtrar directamente en SQL, ver alternativa abajo)
*SELECT FROM /dmo/flight
*       FIELDS *
*       INTO TABLE @lt_flights_all.
*
*" 2) Construir la lista de tipos de avión permitidos
*lt_plane_types = VALUE #(
*  ( '747-400   ' )
*  ( '767-200   ' )
*  ( 'A320-200  ' )
*  ( 'A380-800  ' )
*).
*
*" 3) Filtrado en memoria: mantener solo los vuelos cuyo plane_type_id esté en lt_plane_types
*lt_flights_final = FILTER #( lt_flights_all IN lt_plane_types
*                             WHERE plane_type_id = table_line ).
*
*out->write( name = 'lt_flights_all' data = lt_flights_all ).
*out->write( name = 'lt_flights_final (solo 747-400, 767-200, A320-200, A380-800)' data = lt_flights_final ).
*

*" Declaración de variables y tablas internas
*DATA gv_employee      TYPE string.
*DATA gt_employees     TYPE STANDARD TABLE OF ztab_bd_der.
*DATA gt_employees_for TYPE STANDARD TABLE OF ztab_bd_der.
*
*FIELD-SYMBOLS: <gfs_employee>  TYPE string,
*               <gfs_employee2> TYPE ztab_bd_der.
*
*" Asignar y usar un field-symbol con variable simple
*ASSIGN gv_employee TO <gfs_employee>.
*<gfs_employee> = 'Maria'.
*out->write( gv_employee ).
*UNASSIGN <gfs_employee>.
*
*" Seleccionar todos los empleados de la tabla Z
*SELECT FROM ztab_bd_der
*       FIELDS *
*       INTO TABLE @gt_employees.
*
*" 1) Modificar emails con LOOP INTO DATA
*LOOP AT gt_employees INTO DATA(gs_employee).
*  gs_employee-email = 'NEW-EMAIL@LOGALIGROUP.COM'.
*ENDLOOP.
*
*out->write( data = gt_employees name = 'Structure' ).
*
*" 2) Modificar emails con LOOP ASSIGNING FIELD-SYMBOL
*LOOP AT gt_employees ASSIGNING <gfs_employee2>.
*  <gfs_employee2>-email = 'NEW-EMAIL@LOGALIGROUP.COM'.
*ENDLOOP.
*
*out->write( data = gt_employees name = 'Field symbols' ).
*
*" 3) Crear nueva tabla con FOR + CORRESPONDING
*gt_employees_for = VALUE #(
*  FOR <gfs_employee3> IN gt_employees
*  ( CORRESPONDING #( <gfs_employee3> ) )
*).
*
*out->write( data = gt_employees_for name = 'gt_employees_for' ).



  ENDMETHOD.
ENDCLASS.
