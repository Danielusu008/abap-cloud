CLASS zcl_constructores_punteros_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.
  "atributos publicos accesibles desde fuera de la clase
    Data: lv_name type string,
          lv_age type i.

  "definicion del metodo constructor, recibe paramentros de entrada
  METHODS: constructor IMPORTING iv_name type string
                                 iv_age  type i.

    INTERFACES if_oo_adt_classrun.
PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_constructores_punteros_der IMPLEMENTATION.


METHOD constructor.

lv_age = iv_age.  " asigna el valor recibido a la variable lv_age
lv_name = iv_name.  " asigna el valor recibido a la variable lv_name

ENDMETHOD.



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
*          lt_itab2 TYPE SORTED TABLE OF ty_person WITH UNIQUE KEY name.
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

"Declaramos una variable de referencia a un entero (i)
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


  ENDMETHOD.
ENDCLASS.
