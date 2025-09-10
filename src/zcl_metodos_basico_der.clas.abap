CLASS zcl_metodos_basico_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA nombre TYPE string.

    METHODS: ladrar RETURNING VALUE(rv_accion) TYPE string.

    METHODS: lanzar_pelota RETURNING VALUE(rv_accion) TYPE string.



  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_metodos_basico_der IMPLEMENTATION.

  METHOD ladrar.

    rv_accion =  |{ nombre } dice: Guau guau | .

  ENDMETHOD.

  METHOD lanzar_pelota.
    rv_accion =  |{ nombre } corre a por la pelota | .
  ENDMETHOD.



ENDCLASS.
