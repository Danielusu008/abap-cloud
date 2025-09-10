CLASS zcl_08_work_record_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS open_new_record IMPORTING iv_date       TYPE zde_date_der
                                            iv_first_name TYPE string
                                            iv_last_name  TYPE string
                                            iv_surname    TYPE string OPTIONAL.





  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA date TYPE zde_date_der.
    CLASS-DATA first_name TYPE string.
    CLASS-DATA last_name TYPE string.
    CLASS-DATA surname TYPE string.

ENDCLASS.



CLASS zcl_08_work_record_der IMPLEMENTATION.
  METHOD open_new_record.
    date = iv_date.
    first_name = iv_first_name.
    last_name = iv_last_name.
    surname   = iv_surname.

  ENDMETHOD.

ENDCLASS.
