CLASS zcl_metodos_atributos_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
"Declaración de atributos
    CLASS-DATA currency TYPE c LENGTH 3.
    DATA region TYPE string.

"Declaracion de metodo/funcion de instancia  1
    METHODS set_client
        "Parametros de entrada
      IMPORTING iv_client   TYPE string
                iv_location TYPE string
        "Parametros de salida
      EXPORTING ev_status   TYPE string
        "Parametros de cambio
      CHANGING  cv_process  TYPE string.

"Declaracion de metodo/funcion de instancia  2
    METHODS get_client
      EXPORTING ev_client TYPE string.

"Declaracion de metodo/funcion estatica 3
    CLASS-METHODS:
      set_cntr_type IMPORTING iv_cntr_type TYPE string,
      get_cntr_type EXPORTING ev_cntr_type TYPE string.

      METHODS get_client_name IMPORTING iv_client_id          type string
                              RETURNING VALUE(rv_client_name) type string.


  PROTECTED SECTION.
    DATA creation_date TYPE sydate.

  PRIVATE SECTION.
    DATA client TYPE string.
    CLASS-DATA cntr_type TYPE string.
ENDCLASS.



CLASS zcl_metodos_atributos_der IMPLEMENTATION.
  METHOD set_client.
    client = iv_client.
    ev_status = 'Ok'.
    cv_process = 'Started'.
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

  METHOD get_client_name.
   case iv_client_id.
    when '01'.
        rv_client_name = 'Client name 01'.
    when '02'.
        rv_client_name = 'Client name 02'.
     endcase.

  ENDMETHOD.

ENDCLASS.
