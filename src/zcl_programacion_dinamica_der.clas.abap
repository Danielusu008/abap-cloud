CLASS zcl_programacion_dinamica_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA: lv_name TYPE string,
          lv_age  TYPE i.
    METHODS: constructor IMPORTING iv_name type string
                                    iv_age type i.


    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PROGRAMACION_DINAMICA_DER IMPLEMENTATION.


METHOD constructor.

lv_age = iv_age.
lv_name = iv_name.
ENDMETHOD.


  METHOD if_oo_adt_classrun~main.




  ENDMETHOD.
ENDCLASS.
