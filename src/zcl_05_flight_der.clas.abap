CLASS zcl_05_flight_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS check_flight IMPORTING iv_carrier_id    TYPE string
                                   iv_connexion_id  TYPE i
                         RETURNING VALUE(rv_result) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_05_flight_der IMPLEMENTATION.

  METHOD check_flight.

    SELECT SINGLE FROM /dmo/flight
    FIELDS carrier_id
    WHERE carrier_id = @iv_carrier_id
    AND connection_id = @iv_connexion_id
    INTO @DATA(lv_comp_name).
    IF sy-subrc = 0.
      rv_result = |si tiene datos |.
    ELSE.
      rv_result = |no tiene datos|.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
