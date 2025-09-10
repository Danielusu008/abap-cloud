CLASS zcl_delete_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_delete_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
*
*"--------------borrado simple con lectura del select utilizando una estructura ------------------
*    SELECT SINGLE FROM ztab_carrier_der
*        FIELDS *
*        WHERE carrier_id = 'UA'
*        INTO @DATA(ls_airline).
*
*    IF sy-subrc = 0.
*
*      DELETE ztab_carrier_der FROM @ls_airline.
*      IF sy-subrc = 0.
*        out->write( 'El registro ha sido borrado de la base de datos ' ).
*      ENDIF.
*    ENDIF.
*
*"------ borrado de forma literal desde el campo key
*    DATA(ls_airline2) = VALUE ztab_carrier_der( carrier_id = 'WZ' ).
*
*    DELETE ztab_carrier_der FROM @ls_airline2.
*
*    IF sy-subrc = 0.
*      out->write( 'El registro ha sido borrado de la base de datos ' ).
*    ELSE.
*      out->write( 'El registro no esta disponible para el borrado' ).
*
*    ENDIF.
    "-------------------- Eliminacion de multiples registros-------------------
*
*    DATA lt_airlines TYPE STANDARD TABLE OF ztab_carrier_der.
*
*    SELECT FROM ztab_carrier_der
*        FIELDS *
*        WHERE currency_code = 'EUR'
*        INTO TABLE @lt_airlines.
*
*    IF sy-subrc = 0.
*
*      DELETE ztab_carrier_der FROM TABLE @lt_airlines.
*
*      IF sy-subrc = 0.
*
*      out->write( 'los registros han sido borrados de la base de datos ' ).
*      ENDIF.
*    ENDIF.










  ENDMETHOD.

ENDCLASS.
