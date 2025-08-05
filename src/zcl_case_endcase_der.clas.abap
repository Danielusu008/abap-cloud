CLASS zcl_case_endcase_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_case_endcase_der IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    DATA(lv_cliente) = cl_abap_random_int=>create(  seed = cl_abap_random=>seed(  )
*    min = 0
*    max = 3 )->get_next(  ).
*
*    lv_cliente = lv_cliente + 1.
*
*
*
*    CASE lv_cliente.
*
*      WHEN 1.
*
*
*
*      WHEN 2.
*
*      WHEN 3.
*
*        when 4.
*
*      WHEN OTHERS.
*        out->write( lv_cliente ).
*        out->write( 'el cliente no ha sido registrado' ).
*    ENDCASE.

    """""""""""""""""""

    DATA(lv_aleatorio) = cl_abap_random_int=>create(  seed = cl_abap_random=>seed(  )
     min = 1
      max = 4 )->get_next(  ).



    DATA: lv_nombre1 TYPE string VALUE 'Daniel',
          lv_nombre2 TYPE string VALUE 'Pedro',
          lv_nombre3 TYPE string VALUE 'Diego',
          lv_nombre4 TYPE string VALUE 'Sara'.

    DATA lv_nombre TYPE string.


    IF lv_aleatorio = 1 .
      lv_nombre = lv_nombre1.
    ENDIF.

    IF lv_aleatorio = 2.
      lv_nombre = lv_nombre2.
    ENDIF.

    IF lv_aleatorio = 3.
      lv_nombre = lv_nombre3.

    ENDIF.

    IF lv_aleatorio = 4.
      lv_nombre = lv_nombre4.
    ENDIF.

    lv_nombre = 'Daniel'.
    CASE lv_nombre.

      WHEN 'Daniel'.
        out->write( lv_nombre ).
        out->write( 'hola1').

      WHEN 'Daniel'.
        out->write( lv_nombre ).
     out->write( 'hola2').
      WHEN 'Diego'.
        out->write( lv_nombre ).

      WHEN 'Sara'.
        out->write( lv_nombre ).

      WHEN OTHERS.

    ENDCASE.
    """"""""""

*    DATA(lv_aleatorio) = cl_abap_random_int=>create(  seed = cl_abap_random=>seed(  ) min = 1 max = 4 )->get_next(  ).
*    DATA(lv_num1) = cl_abap_random_int=>create(  seed = cl_abap_random=>seed(  ) min = 1 max = 100 )->get_next(  ).
*    DATA(lv_num2) = cl_abap_random_int=>create(  seed = cl_abap_random=>seed(  ) min = 1 max = 100 )->get_next(  ).
*
*    DATA: lv_operacion TYPE string,
*          lv_resultado TYPE p DECIMALS 2.
*
*
*    CASE lv_aleatorio.
*
*      WHEN 1.
*        lv_operacion = '+'.
*
*      WHEN 2.
*        lv_operacion = '-'.
*
*      WHEN 3.
*        lv_operacion = '*'.
*      WHEN 4.
*        lv_operacion = '/'.
*
*      WHEN OTHERS.
*    ENDCASE.
*
*
*    CASE lv_operacion.
*
*      WHEN '+'.
*
*        lv_resultado = lv_num1 + lv_num2.
*        out->write( |El resultado de { lv_num1 } { lv_operacion } { lv_num2 } es { lv_resultado } | ).
*      WHEN '-'.
*
*        lv_resultado = lv_num1 - lv_num2.
*        out->write( |El resultado de { lv_num1 } { lv_operacion } { lv_num2 } es { lv_resultado } | ).
*
*      WHEN '*'.
*        lv_resultado = lv_num1 * lv_num2.
*        out->write( |El resultado de { lv_num1 } { lv_operacion } { lv_num2 } es { lv_resultado } | ).
*
*      WHEN '/'.
*
*        lv_resultado = lv_num1 / lv_num2.
*        out->write( |El resultado de { lv_num1 } { lv_operacion } { lv_num2 } es { lv_resultado } | ).
*      WHEN OTHERS.
*    ENDCASE.
*


  ENDMETHOD.

ENDCLASS.
