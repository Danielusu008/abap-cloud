CLASS zcl_clase_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.


  PROTECTED SECTION.
  PRIVATE SECTION.


ENDCLASS.



CLASS zcl_clase_der IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lv_string TYPE string VALUE 'Pedro',
          lv_date1  TYPE d,
          lv_int    TYPE i VALUE 35,
          lv_time   TYPE c,
          lv_int2   TYPE i,
          lv_dec    TYPE p LENGTH 8 DECIMALS 3 VALUE '444.34'.

    DATA: lv_nombre     TYPE string,
          lv_edad       TYPE i,
          lv_dni        TYPE string,
          lv_nacimiento TYPE d.

    lv_date1 = cl_abap_context_info=>get_system_date( ).
    lv_time = cl_abap_context_info=>get_system_time( ).


    "*****Comentar y descomentar ctrl+7 *********************************************************************
    "*************************** OPERACIONES MATEMATICAS **********************


*  DATA: lv_num1 TYPE i VALUE 3,
*        lv_num2 TYPE i VALUE 5,
*        lv_num3 TYPE i VALUE 9,
*        lv_res TYPE i.
*
*lv_res = lv_num1 + lv_num2.
*out->write( lv_res ).
*
*lv_res = lv_num1 * lv_num2.
*out->write( lv_res ).
*
*lv_res = lv_num1 / lv_num2.
*out->write( lv_res ).
*
*lv_res = lv_num1 - lv_num3 * lv_num2.
*out->write( lv_res ).
*
* out->write( |La Suma de las variables es: | ).

    "
    DATA: lv_date  TYPE d,
          lv_date2 TYPE d VALUE '20240623 ',
          lv_mes   TYPE string.

    "lv_date = cl_abap_context_info=>get_system_date(  ).

*    lv_mes = lv_date2+4(2). " mes
*     out->write( lv_mes ).
*    lv_mes = lv_date2(4).
*     out->write( lv_mes ).
*    lv_mes = lv_date2+3.
*     out->write( lv_mes ).



    "cuenta cadena
*Data: lv_cadena type string VALUE 'Hola tengo sueño',
*      lv_contador type i.
*
*lv_contador = numofchar( lv_cadena ).
*
*
*out->write( lv_contador ).


    " devuelve numero de caracteres encontrados


    DATA: lv_cadena   TYPE string VALUE 'FernandoMuñoz  DanielRuiz LauraPerez',
          lv_contador TYPE i.

    "lv_contador = count( val = lv_cadena sub = 'DANIEL').



    "out->write( lv_contador ).
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA  lv_num TYPE string.

    lv_num = find( val = lv_cadena sub = 'Daniel' ).
    out->write( lv_num ).



    DATA lv_texto TYPE string.

    lv_texto = zcl_textos_der=>gc_label_usuario.
    out->write( lv_texto ).





   " out->write( 'Hola mundo 2' ).  " Esta linea imprime por consola asdfasdf out->write( 'Hola mundo 2' ).

 ENDMETHOD.

ENDCLASS.
