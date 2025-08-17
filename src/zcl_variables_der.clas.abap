CLASS zcl_variables_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun. """""

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_VARIABLES_DER IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

""""""""""""""""""""""""""""
"declaracion de variables en linea.

*DATA(lv_variable_linea) = 8 * 16.
*out->write( lv_variable_linea ).
*
*DATA(lv_div) = 8 / 16.
*out->write( lv_div ).
*
*DATA(lv_text) = 'ABAP I - 2025'.
*out->write( lv_text ).
*
*DATA(lv_dec) = '10.245'.
*"out->write( lv_dec ).
*
*lv_dec = 'pedro'.
*
*lv_dec = 'Fernando'.
*out->write( lv_dec ).



" Regular Expresiones
DATA: lv_text    TYPE string,
      lv_pattern TYPE string.

lv_text = 'Please contact us at daniel.elviraruiz@experis.es for more information'.
lv_pattern = `\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b`. " regex para email

IF contains( val = lv_text pcre = lv_pattern ).
  out->write( 'The text contains an email address' ).

  DATA(lv_count) = count( val = lv_text pcre = lv_pattern ).
  out->write( lv_count ).

  DATA(lv_pos) = find( val = lv_text pcre = lv_pattern occ = 1 ).
  out->write( lv_pos ).

ELSE.
  out->write( 'The text does not contain an email address' ).
ENDIF.


  ENDMETHOD.
ENDCLASS.
