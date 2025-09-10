CLASS zcl_clase_tablas_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.






  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_clase_tablas_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.



*    TRY.
*        DATA(lo_lock_object) = cl_abap_lock_object_factory=>get_instance( EXPORTING iv_name = 'EZ_OBJ_BLQ_DER' ).
*
*      CATCH cx_abap_lock_failure.
*        out->write( |El objeto lock no se ha creado| ).
*    ENDTRY.
*
*    TRY.  "shit + enter
*        DATA lt_parameter TYPE if_abap_lock_object=>tt_parameter.
*        lt_parameter = VALUE #( ( name = 'ID'
*                                   value = REF #(  '00000001' ) ) ).
*
*        lo_lock_object->enqueue(
**      it_table_mode =
*          it_parameter  =  lt_parameter
**      _scope        =
**      _wait         =
*        ).
*      CATCH cx_abap_foreign_lock.
*        out->write( |foreing lock exception| ).
*      CATCH cx_abap_lock_failure.
*        out->write( |El objeto ya esta siendo tratado por otro usuario| ).
*    ENDTRY.
*
*    out->write( |El objeto esta disponible| ).

    " Vaciar la tabla antes de cargar datos de ejemplo
    DELETE FROM ztab_eje1_der.

    " Insertar los registros
    MODIFY ztab_eje1_der FROM TABLE @(
      VALUE #(
        ( mandt         = '100'
          id            = '00000001'
          first_name    = 'Laura'
          last_name     = 'Martinez'
          email         = 'lauram@example.com'
          phone_number  = '38512369'
          salary        = '2000.30'
          currency_code = 'EUR' )

        ( mandt         = '100'
          id            = '00000002'
          first_name    = 'Mario'
          last_name     = 'Martinez'
          email         = 'marion@example.com'
          phone_number  = '38512369'
          salary        = '2000.30'
          currency_code = 'EUR' )

        ( mandt         = '100'
          id            = '00000003'
          first_name    = 'Daniela'
          last_name     = 'Linares'
          email         = 'daniela@example.com'
          phone_number  = '38512369'
          salary        = '2000.30'
          currency_code = 'EUR' )

        ( mandt         = '100'
          id            = '00000004'
          first_name    = 'Karol'
          last_name     = 'Pérez'
          email         = 'kperez@example.com'
          phone_number  = '546987'
          salary        = '5000.00'
          currency_code = 'USD' )

           ( mandt         = '100'
          id            = '00000005'
          first_name    = 'Mario'
          last_name     = 'Pérez'
          email         = 'kperez@example.com'
          phone_number  = '546987'
          salary        = '5000.00'
          currency_code = 'USD' )

      )

    ).
*
*    IF sy-subrc = 0.
*      out->write( |El objeto has sido actualizado| ).
*    ENDIF.
*
*    TRY.
*
*        lo_lock_object->dequeue( it_parameter = lt_parameter ).
*      CATCH cx_abap_lock_failure.
*        out->write( |El objeto no ha sido liberado | ).
*    ENDTRY.
*        out->write( |El objeto no ha sido liberado | ).
*








    " Vaciar la tabla antes de cargar datos de ejemplo
    DELETE FROM ztab_bd_der.

    " Insertar los registros
    MODIFY ztab_bd_der FROM TABLE @(
      VALUE #(
        ( mandt         = '100'
          id            = '00000001'
          first_name    = 'Laura'
          last_name     = 'Martinez'
          email         = 'lauram@example.com'
          phone_number  = '38512369'
          salary        = '2000.30'
          currency_code = 'EUR' )

        ( mandt         = '100'
          id            = '00000002'
          first_name    = 'Mario'
          last_name     = 'Martinez'
          email         = 'marion@example.com'
          phone_number  = '38512369'
          salary        = '2000.30'
          currency_code = 'EUR' )

        ( mandt         = '100'
          id            = '00000003'
          first_name    = 'Daniela'
          last_name     = 'Linares'
          email         = 'daniela@example.com'
          phone_number  = '38512369'
          salary        = '2000.30'
          currency_code = 'EUR' )

        ( mandt         = '100'
          id            = '00000004'
          first_name    = 'Karol'
          last_name     = 'Pérez'
          email         = 'kperez@example.com'
          phone_number  = '546987'
          salary        = '5000.00'
          currency_code = 'USD' )

           ( mandt         = '100'
          id            = '00000005'
          first_name    = 'Mario'
          last_name     = 'Pérez'
          email         = 'kperez@example.com'
          phone_number  = '546987'
          salary        = '5000.00'
          currency_code = 'USD' )


      )

    ).



    DELETE FROM ztab_keys_der.




    " Insertar los registros
    MODIFY ztab_keys_der FROM TABLE @(
      VALUE #(
        ( mandt         = '100'
          employee_id     = '001'
          first_name    = 'Daniel'
          last_name     = 'Martinez'
          start_date   = sy-datum
         category  = 's'
         )

         ( mandt         = '100'
          employee_id     = '002'
          first_name    = 'Laura'
          last_name     = 'Martinez'
          start_date   = sy-datum
         category  = 's'
         )
         ( mandt         = '100'
          employee_id     = '003'
          first_name    = 'Pedro'
          last_name     = 'Martinez'
          start_date   = sy-datum
         category  = 's'
         )
         ( mandt         = '100'
          employee_id     = '004'
          first_name    = 'Raul'
          last_name     = 'Martinez'
          start_date   = sy-datum
         category  = 's'
         )
         ( mandt         = '100'
          employee_id     = '005'
          first_name    = 'Martin'
          last_name     = 'Martinez'
          start_date   = sy-datum
         category  = 's'
         )

    )
    ).




  ENDMETHOD.

ENDCLASS.
