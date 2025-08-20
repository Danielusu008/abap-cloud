CLASS zcl_field_symbols_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_field_symbols_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*"Field_symbols
*    "ejemplo simple

*    DATA gv_employee type string.
*
*    "Declaracion del field symbol(simbolo de campo) que actua como puntero para una variable string.
*    FIELD-SYMBOLS <gfs_employee> type string.
*
*     " asignamos la direccion de memoria de gv_eemployee al field symbol
*     "ahora <gfs_employee> apunta a la misma zona de memoria que gv_employee
*    ASSIGN gv_employee TO <gfs_employee>.
*
*
*    "asignamos el valor Maria usando el field symbol
*    "esto modifica directamente el gv_employee porque ambos apuntan al mismo dato
*    <gfs_employee> = 'Maria'.
*
*
*     out->write( gv_employee ).

    """"""""""""""""""""""""""""" """"""""""""""""
    "Field_symbols


    " Declaración de variables y tablas internas
*    DATA gv_employee      TYPE string.
*    DATA gt_employees     TYPE STANDARD TABLE OF ztab_bd_der.
*    DATA gt_employees_for TYPE STANDARD TABLE OF ztab_bd_der.
*
*    FIELD-SYMBOLS: <gfs_employee>  TYPE string,
*                   <gfs_employee2> TYPE ztab_bd_der. " field-symbol a una **linea** de la tabla Zxxxxxx

    " Asignar y usar un field-symbol con variable simple
*    ASSIGN gv_employee TO <gfs_employee>.
*    <gfs_employee> = 'Maria'.
*    "out->write( <gfs_employee> ).


*    UNASSIGN <gfs_employee>.

    " Seleccionar todos los empleados de la tabla Z
*    SELECT FROM ztab_bd_der
*           FIELDS *
*           INTO TABLE @gt_employees.
*
*
*    LOOP AT gt_employees INTO DATA(gs_employee). " itera copuando cda fila en gs_emloyee ( estructura loca)
*      gs_employee-email = 'nuevo@email.com'.     " cambia el email **solo en la copia**, no en gt_employees
*    ENDLOOP.                                     " fin del bucle por copia ( no persiste camnos en la tabla )
*
*    out->write( gs_employee ).
*    out->write( |\n| ).
*    out->write( data = gt_employees name = 'Structure' ). "Muestra gt_employees "(deberia seguir sin cambios) "
*
*
*    LOOP AT gt_employees ASSIGNING <gfs_employee2>.    " Itera ASSIGNING haciendo referencia a la fila real de gt_employees
*      <gfs_employee2>-email = 'nuevo@email.com'.       " Modifica el email **en la fila real** de gt_employees
*    ENDLOOP.                                           " Fin del bulcle por referencia ( si persisten los cambios)
*    out->write( |\n| ).
*    out->write( data = gt_employees name = 'Field symbols' ). "Muestra gt_employees ya con los emails modificados

*
*    gt_employees_for = VALUE #(                  " construye otra tabla a partir de gt_employees
*      FOR <gfs_employee3> IN gt_employees        " bucle de compresion: recorre cada fila
*      ( CORRESPONDING #( <gfs_employee3> ) )     " inserta una linea copiando campos por Nombre (1:1)
*    ).                                           " gt_emloyees_for queda como copia de gt_employees
*    out->write( |\n| ).
*    out->write( data = gt_employees_for name = 'gt_employees_for' ).  "muestra el resultado de la copia de gt_employees, en la nueva tabla
*                                                                      " gt_employees_for que ha sido introducida por el for.

    """"""""""""""""""""""""""""""""""""""""""""""

*  " Declaración de variables y tablas internas
*    DATA gv_employee      TYPE string.
*    DATA gt_employees     TYPE STANDARD TABLE OF ztab_bd_der.
*    DATA gt_employees_for TYPE STANDARD TABLE OF ztab_bd_der.
*
**    FIELD-SYMBOLS: <gfs_employee>  TYPE string,
**                   <gfs_employee2> TYPE ztab_bd_der. " field-symbol a una **linea** de la tabla Zxxxxxx
*
*    " Seleccionar todos los empleados de la tabla Z
*    SELECT FROM ztab_bd_der
*           FIELDS *
*           INTO TABLE @gt_employees.
*
*    LOOP AT gt_employees ASSIGNING FIELD-SYMBOL(<gfs_employee2>).    " Itera ASSIGNING haciendo referencia a la fila real de gt_employees
*      <gfs_employee2>-email = 'nuevo@email.com'.       " Modifica el email **en la fila real** de gt_employees
*    ENDLOOP.                                           " Fin del bulcle por referencia ( si persisten los cambios)
*    out->write( |\n| ).
*    out->write( data = gt_employees name = 'Field symbols' ). "Muestra gt_employees ya con los emails modificados
*

*    gt_employees_for = VALUE #(                  " construye otra tabla a partir de gt_employees
*      FOR <gfs_employee3> IN gt_employees        " bucle de compresion: recorre cada fila
*      ( CORRESPONDING #( <gfs_employee3> ) )     " inserta una linea copiando campos por Nombre (1:1)
*    ).                                           " gt_emloyees_for queda como copia de gt_employees
*    out->write( |\n| ).
*    out->write( data = gt_employees_for name = 'gt_employees_for' ).  "muestra el resultado de la copia de gt_employees, en la nueva tabla
*                                                                      " gt_employees_for que ha sido introducida por el for.

    """"""""""""""""""""""""""""""""
    "AÑADIR REGISTROS

*    SELECT
*    from ztab_bd_der
*    FIELDS *
*    into table @DATA(gt_employees).
*
*out->write( data =  gt_employees name = 'gt_employees' ).
*out->write( |\n| ).
*
*    append INITIAL LINE TO gt_employees ASSIGNING FIELD-SYMBOL(<lfs_employee_apd>).
*
*    <lfs_employee_apd> = value #(
*                                mandt         = sy-mandt
*                                id            = 00000005
*                                first_name    = 'Pedro'
*                                last_name     = 'Mora'
*                                email         = 'mora@experis.es'
*                                phone_number  = 38512369
*                                salary        = '2000'
*                                currency_code = 'EUR'     ).
*
*
*out->write( data =  gt_employees name = 'gt_employees' ).
*

    "INSERTAR REGISTROS

*    SELECT
*    FROM ztab_bd_der
*    FIELDS *
*    INTO TABLE @DATA(gt_employees).
*
*    out->write( data =  gt_employees name = 'gt_employees' ).
*    out->write( |\n| ).
*
*    INSERT INITIAL LINE INTO gt_employees ASSIGNING FIELD-SYMBOL(<lfs_employee_into>) INDEX 2.
*
*    <lfs_employee_into> = VALUE #(
*                                mandt         = sy-mandt
*                                id            = 00000005
*                                first_name    = 'Pedro'
*                                last_name     = 'Mora'
*                                email         = 'mora@experis.es'
*                                phone_number  = 38512369
*                                salary        = '2000'
*                                currency_code = 'EUR'     ).
*
*
*    out->write( data =  gt_employees name = 'gt_employees' ).


    " Leer registros

*    SELECT
* FROM ztab_bd_der
* FIELDS *
* INTO TABLE @DATA(gt_employees).
*
*
*
*    READ TABLE gt_employees ASSIGNING FIELD-SYMBOL(<lfs_employee_rd>) WITH KEY first_name = 'Mario'.
*
*    <lfs_employee_rd>-last_name = 'Rivera'.
*    <lfs_employee_rd>-email      = 'rivera@expris.es '.
*
*    out->write( data =  gt_employees name = 'gt_employees' ).
*
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*                                PROGRAMACION DINAMICA
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    "field-symbols dinamicos

*    FIELD-SYMBOLS: <gt_employees> TYPE ANY TABLE, "Puntero a una tabla interna generica
*                   <gs_employee>  TYPE any, " puntero a un registro/estructura generia
*                   <gs_data>      TYPE any.  " puntero a un campo generico
*
*
*    "Crea un registro de ejemplo en base a la tabla ZTAB_BD_DER
*    DATA(gs_employee) = VALUE ztab_bd_der(
*                                    mandt         = sy-mandt
*                                    id            = '00000005'
*                                    first_name    = 'Pedro'
*                                    last_name     = 'Mora'
*                                    email         = 'mora@experis.es'
*                                    phone_number  = 38512369
*                                    salary        = '2000'
*                                    currency_code = 'EUR'    ).
*
*
*    "Asignar el registro gs_employee al field-symbol <gs_employee>
*
*    ASSIGN gs_employee TO <gs_employee>.
*
*
*    "Verificar que el field-symbol <gs_employee> esta asignado
*    IF <gs_employee> IS ASSIGNED.
*
*        "Asignar dinamicamente el componente 'first_name' del registro <gs-employee> al field-symbol <gs_data>
*        ASSIGN COMPONENT 'FIRST_NAME' of STRUCTURE <gs_employee> to <gs_data>.
*
*            "Verificar que el field-symbol <gs_data> esta asignado
*            if <gs_data> is ASSIGNED.
*                "Modifica dinamicamente el valor del campo first_name a Maria
*                <gs_data> = 'Maria'.
*
*                "liberar la asignacion del field-symbol <gs_data>
*                UNASSIGN <gs_data>.
*            ENDIF.
*
*            UNASSIGN <gs_employee>.
*    ENDIF.
*
*    out->write(
*        data = gs_employee
*        name = 'Programacion Dinamica'
*    ).

*
*    "Declaracion una variable de referencia lr_data y le asignamos memoria para un entero ( tipo i)
*    DATA(lr_data) = NEW i(  ).
*
*
*    "asociamos el contenido de la referencia lr_data ( el entero en memoria)
*    "a un field-symbol <lfs_value>, para poder manipularlo de forma directa.
*    ASSIGN lr_data->* TO FIELD-SYMBOL(<lfs_value>).
*
*
*    "modificamos el valor apuntado por <lfs_value> ( es decir el entero en memoria)
*    " y lo establecemos a 30
*    <lfs_value> = 30.
*
*
*    "Declaramos una referencia lr_class y creamos un nuevo objeto de la clase ZCL_xxxx
*    "llamando a su constructor ( El parentesis vacio indica constructor sin paramentros )
*    data(lr_class) = new zcl_eje3_der(  ).
    """"""
    "objetos de datos anonimos

    DATA(lr_dato01) = NEW i( 123 ).  " creamos un objeto de datos anonimo de tipo i
    " inizializamos a 123 y guarda un "ref to" i en lr_dato01


    DATA(lr_dato02) = NEW ztab_bd_der( id = 10005 first_name = 'Sofia' ). "creamos una estructura anonima de tipo ztab_bd_der
    " con los valores  ( id = 10005 first_name = 'Sofia' )  y guarda una "ref to" a ztab_bd_der



    out->write( lr_dato01 ).
    out->write( lr_dato02 ).

    SELECT *
    FROM ztab_bd_der
    INTO TABLE NEW @DATA(lr_dato03).  "Crea una "tabla interna anonima" con el resultado y devuelve una "ref to" en lr_data03.

    out->write( lr_dato03 ).


    SELECT
    SINGLE *
    FROM  ztab_bd_der
    INTO NEW @DATA(lr_dato04).     " crea una "estructura anonima" con esa fila y devuelve un "ref to" en lr_dato04


    out->write( lr_dato04 ).


    "Sentencia dinamica con assign


    TYPES: BEGIN OF lty_data,
             field1 TYPE i,
             field2 TYPE string,
             field3 TYPE string,
           END OF lty_data.


    DATA: ls_data TYPE lty_data,
          lt_data TYPE TABLE OF lty_data WITH EMPTY KEY.


    ls_data = VALUE #(
    field1  = 1
    field2 = 'aaa'
    field3  = 'z'

    ).

    APPEND ls_data TO lt_data.

    DATA(lr_data) = NEW lty_data(           "crea "referencia de datos " a una estructura anonima
                                            " iniciada con los valores 2, b, y
   field1  = 2
   field2 = 'b'
   field3  = 'y'

   ).


    FIELD-SYMBOLS <lfs_generic> TYPE data.     "field symol generico (tipo dinamico)

    ASSIGN ls_data-('field1') TO <lfs_generic>.   "asigna por "nombre dinamico" el comp . field1 de ls_data
    out->write( <lfs_generic> ).                  "->muestra 1


    ASSIGN lt_data[ 1 ]-('field1') TO <lfs_generic>.  " toma la fila 1 de  lt_data y su comp. field1 " -> muestra 1
    "ASSIGN lt_data[ 1 ]-field1 TO <lfs_generic>.      " lo mismo que la anterior fila
    out->write( <lfs_generic> ).                      "->muestra 1



    "------IMPORTANTE AL TRABABJAR CON REFERENCIAS DE DATOS USAR EL COMPONENT------
    ASSIGN COMPONENT  'field2' OF STRUCTURE lr_Data->* TO <lfs_generic>. "accede a field2 de la estructura ereferenciada
    out->write( <lfs_generic> ).    " -> muestra B


    ASSIGN COMPONENT  'field3' OF STRUCTURE lr_Data->* TO <lfs_generic>. "accede a field3 de la estructura ereferenciada
    out->write( <lfs_generic> ).    " -> muestra y


    DATA lv_field TYPE string VALUE 'field2'.
    ASSIGN ls_data-(lv_field) TO <lfs_generic>.     " asignacion por "nombre en variable" field2
    out->write( <lfs_generic> ).                    " muestra aaa

    ASSIGN ('ls_data-field1') to <lfs_generic>.     "asignacion por "nombre absoluto" en c adena
     out->write( <lfs_generic> ).                   " muestra 1

     ASSIGN ls_data-(3) to <lfs_generic>.           "Asignacion por "posicion"  (3= field3)
       out->write( <lfs_generic> ).                 "muestra z


  endmethod.

ENDCLASS.
