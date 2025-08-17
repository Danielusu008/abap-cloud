CLASS zcl_constante_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CONSTANTE_DER IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.




    CONSTANTS: lc_pi TYPE p DECIMALS 2 VALUE '3.14'.
    DATA: lv_radio     TYPE i VALUE 2,
          lv_resultado TYPE p DECIMALS 2.

    lv_resultado = lc_pi * lv_radio ** 2.

    out->write( |El area de un circulo de radio { lv_radio }: { lv_resultado }| ).

  ENDMETHOD.
ENDCLASS.
