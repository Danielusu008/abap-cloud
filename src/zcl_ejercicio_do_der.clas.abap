CLASS zcl_ejercicio_do_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejercicio_do_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

DATA(lv_string) = 'daniel Fernando Pedro ramon Sergio'.
CONDENSE lv_string.

DATA: lv_nombre1 TYPE string,
      lv_nombre2 TYPE string,
      lv_nombre3 TYPE string,
      lv_nombre4 TYPE string,
      lv_nombre5 TYPE string,
      lv_nombre  TYPE string,
      lv_longitud TYPE i.

" Extraer los nombres
SPLIT lv_string AT space INTO lv_nombre1 lv_nombre2 lv_nombre3 lv_nombre4 lv_nombre5.

DO 5 TIMES.

  " Elegir el nombre correcto en cada vuelta del bucle
  CASE sy-index.
    WHEN 1.
    lv_nombre = lv_nombre1.
    WHEN 2.
     lv_nombre = lv_nombre2.
    WHEN 3.
    lv_nombre = lv_nombre3.
    WHEN 4.
    lv_nombre = lv_nombre4.
    WHEN 5.
    lv_nombre = lv_nombre5.
  ENDCASE.

  lv_longitud = strlen( lv_nombre ).

  IF lv_longitud > 7.
    out->write( 'Hola Fernando' ).

  ELSEIF lv_longitud = 6.
    IF lv_nombre = 'Sergio'.
      out->write( 'Hola Sergio' ).
    ELSEIF lv_nombre = 'daniel'.  " Ojo: está en minúsculas
      out->write( 'Hola Daniel' ).
    ENDIF.

  ELSE.
    out->write( 'Hola Pedro' ).
    lv_nombre = to_upper( lv_nombre ).
    out->write( |Nombre en mayúsculas: { lv_nombre }| ).
  ENDIF.

ENDDO.


  ENDMETHOD.
ENDCLASS.
