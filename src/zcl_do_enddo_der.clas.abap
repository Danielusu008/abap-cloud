CLASS zcl_do_enddo_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DO_ENDDO_DER IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.




    DO 5 TIMES.

      out->write( |primero { sy-index } | ).


      DO 5 TIMES.

        out->write( |segundo { sy-index } | ).

      ENDDO.

    ENDDO.







  ENDMETHOD.
ENDCLASS.
