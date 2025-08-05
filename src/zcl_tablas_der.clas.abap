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


 SELECT FROM /dmo/airport
    FIELDS *
    WHERE country = 'DE'
    INTO TABLE @DATA(lt_flights).

*DATA(ls_flight2) = lt_flights[ airport_id = 'MUC' ].
*out->write( data = ls_flight2 name = `ls_flight2` ).

*"""forma moderna
*
DATA(ls_flight2) = lt_flights[ airport_id = 'MUC' ]-name.
out->write( data = ls_flight2 name = `ls_flight2` ).

  ENDMETHOD.
ENDCLASS.
