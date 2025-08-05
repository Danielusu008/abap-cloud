CLASS zcl_ejercicio2_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejercicio2_der IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lv_string  TYPE string VALUE 'daniel Fernando Pedro Ramon',
          lv_comodin TYPE string.
    DATA: lv_nombre TYPE string VALUE 'Pedro'.


    IF lv_string = 'daniel Fernando Pedro Ramonr'.

      lv_comodin = to_upper( lv_string ). " lv_string = 7
      out->write( lv_comodin ).


    ELSEIF lv_nombre = 'Pedro'.

      lv_comodin = find( val = lv_string sub ='Fernando' ). " 7
      out->write( lv_comodin ). "lv_comodin = 7

    ELSE.

      out->write( 'no te conozco').

    ENDIF.



if lv_string  = 'daniel'.

out->write( 'hola, daniel' ).

endif.


if 5 + 5  = 10.

out->write( 'hola, daniel' ).

endif.




  ENDMETHOD.
ENDCLASS.
