CLASS zcl_ejemplos_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .




  PUBLIC SECTION.
    CLASS-DATA currency TYPE c LENGTH 3.
    DATA: region TYPE string.



    METHODS set_client IMPORTING  iv_client   TYPE string
                                  iv_location TYPE string
                        EXPORTING ev_status   TYPE string
                        CHANGING  cv_process  TYPE string.





   METHODS get_client EXPORTING ev_client TYPE string.



    CLASS-METHODS:
      set_cntr_type IMPORTING iv_cntr_type TYPE string,
      get_cntr_type EXPORTING ev_cntr_type TYPE string.








  PROTECTED SECTION.
    DATA creation_data TYPE sydate.

  PRIVATE SECTION.
    DATA client TYPE string value 'Raul'.
    CLASS-DATA cntr_type TYPE string.
ENDCLASS.



CLASS zcl_ejemplos_der IMPLEMENTATION.



  METHOD set_client.

      me->client = iv_client.
      ev_status  = 'ok'.
      cv_process = 'started' .

  ENDMETHOD.

  METHOD get_client.
    ev_client = client.

  ENDMETHOD.






  METHOD get_cntr_type.

        ev_cntr_type = cntr_type.

  ENDMETHOD.

  METHOD set_cntr_type.

    cntr_type = iv_cntr_type.

  ENDMETHOD.

ENDCLASS.
