CLASS zcl_obj_block_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_obj_block_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    "---------------------- Primera parte sentencia de bloqueo-----------------------------
*    out->write( 'El usuario ha empezado el programa' ). " AÑADIDA
*    TRY.
*
*        DATA(lo_lock_object) = cl_abap_lock_object_factory=>get_instance( EXPORTING iv_name = 'EZ_BLOK_DER' ).
*      CATCH cx_abap_lock_failure.
*             out->write( 'El objeto instance no se ha creado' ).
*             RETURN. " AÑADIDA
*    ENDTRY.
*
*
*        DATA lt_parameter TYPE if_abap_lock_object=>tt_parameter.
*        lt_parameter = VALUE #( (   name = 'ID'
*                                   value = REF #( '00000001' ) )
*                                    ).
* TRY. " AÑADIDA
*        lo_lock_object->enqueue(
**               it_table_mode =
*         it_parameter  =  lt_parameter
**               _scope        =
**               _wait         =
*        ).
*      CATCH cx_abap_foreign_lock  cx_abap_lock_failure.
*
*        out->write( 'El objeto ya esta siendo tratado por otro usuario ' ).
*        return. " AÑADIDA
*    ENDTRY.
*
*    out->write( 'El objeto ya esta disponible' ).
*
*    "--------------- segunda parte , "intento" crear una nueva fila----------------------------
*
*    DATA ls_new_registro TYPE ztab_eje1_der.
*
*    ls_new_registro  =  VALUE #(
*                                  mandt         = '100'
*                                  id            = '00000006'
*                                  first_name    = 'Daniel'
*                                  last_name     = 'RUIZ'
*                                  email         = 'lauram@example.com'
*                                  phone_number  = '38512369'
*                                  salary        = '2000.30'
*                                  currency_code = 'EUR' ).
*
*wait up to 20 seconds.
*
*    MODIFY ztab_eje1_der FROM @ls_new_registro.
*
*    "---------------- tercera parte, liberación del objeto.---------------------------------------
*
*    IF sy-subrc = 0.
*      out->write( 'El la base de datos ha sido actualizado ' ).
*    ENDIF.
*
*    TRY.
*        lo_lock_object->dequeue( it_parameter = lt_parameter ).
*      CATCH cx_abap_lock_failure.
*        out->write( 'El objeto no ha sido liberado' ).
*    ENDTRY.
*    out->write( 'El objeto ha sido liberado' ).


    "---------------------- Primera parte sentencia de bloqueo-----------------------------
*    out->write( 'El usuario ha empezado el programa' ). " AÑADIDA
*    TRY.
*
*        DATA(lo_lock_object) = cl_abap_lock_object_factory=>get_instance( EXPORTING iv_name = 'EZ_BLOK_DER' ).
*      CATCH cx_abap_lock_failure.
*             out->write( 'El objeto instance no se ha creado' ).
*             RETURN. " AÑADIDA
*    ENDTRY.
*
*
*        DATA lt_parameter TYPE if_abap_lock_object=>tt_parameter.
*        lt_parameter = VALUE #( (   name = 'ID'
*                                   value = REF #( '00000001' ) )
*                                    ).
* TRY. " AÑADIDA
*        lo_lock_object->enqueue(
**               it_table_mode =
*         it_parameter  =  lt_parameter
**               _scope       =
*               _wait         = abap_true
*        ).
*      CATCH cx_abap_foreign_lock  cx_abap_lock_failure.
*
*        out->write( 'El objeto ya esta siendo tratado por otro usuario ' ).
*        "return. " AÑADIDA
*    ENDTRY.
*
*    out->write( 'El objeto ya esta disponible' ).
*
*    "--------------- segunda parte , "intento" crear una nueva fila----------------------------
*
*    DATA ls_new_registro TYPE ztab_eje1_der.
*
*    ls_new_registro  =  VALUE #(
*                                  mandt         = '100'
*                                  id            = '00000006'
*                                  first_name    = 'Fernando'
*                                  last_name     = 'RUIZ'
*                                  email         = 'lauram@example.com'
*                                  phone_number  = '38512369'
*                                  salary        = '2000.30'
*                                  currency_code = 'EUR' ).
*
*wait up to 20 seconds.
*
*    MODIFY ztab_eje1_der FROM @ls_new_registro.
*
*    "---------------- tercera parte, liberación del objeto.---------------------------------------
*
*    IF sy-subrc = 0.
*      out->write( 'El la base de datos ha sido actualizado ' ).
*    ENDIF.
*
*    TRY.
*        lo_lock_object->dequeue( it_parameter = lt_parameter ).
*      CATCH cx_abap_lock_failure.
*        out->write( 'El objeto no ha sido liberado' ).
*    ENDTRY.
*    out->write( 'El objeto ha sido liberado' ).


"---------------------- Bloqueo con reintentos -----------------------------
*out->write( 'El usuario ha empezado el programa' ).
*
*" 1) Instancia del lock object
*DATA lo_lock_object TYPE REF TO if_abap_lock_object.
*TRY.
*  lo_lock_object = cl_abap_lock_object_factory=>get_instance( iv_name = 'EZ_BLOK_DER' ).
*CATCH cx_abap_lock_failure INTO DATA(lx_inst).
*  out->write( |No se pudo crear la instancia del lock: { lx_inst->get_text( ) }| ).
*  RETURN.
*ENDTRY.
*
*" 2) Parámetros del lock (bloqueo por ID)
*DATA lv_id TYPE ztab_eje1_der-id VALUE '00000001'.
*DATA lt_parameter TYPE if_abap_lock_object=>tt_parameter.
*lt_parameter = VALUE #( ( name = 'ID' value = REF #( lv_id ) ) ).
*
*" 3) Política de reintentos
*CONSTANTS: c_sleep   TYPE i VALUE 1,     "segundos entre intentos
*           c_timeout TYPE i VALUE 30.    "máximo a esperar
*
*DATA waited    TYPE i         VALUE 0.        "tiempo acumulado
*DATA lv_locked TYPE abap_bool VALUE abap_false.
*
*" 4) Bucle: seguimos MIENTRAS no tengamos el bloqueo
*WHILE lv_locked = abap_false.
*  TRY.
*      lo_lock_object->enqueue( it_parameter = lt_parameter ). "intenta bloquear
*      lv_locked = abap_true.                                  "bloqueo conseguido
*    CATCH cx_abap_foreign_lock.                               "otro usuario lo tiene
*      WAIT UP TO c_sleep SECONDS.                             "pausa
*      waited += c_sleep.
*      IF waited >= c_timeout.                                 "timeout
*        out->write( |Timeout esperando el bloqueo tras { waited } s| ).
*        RETURN.
*      ENDIF.
*    CATCH cx_abap_lock_failure INTO DATA(lx_enqueue).         "fallo técnico
*      out->write( |Fallo de bloqueo: { lx_enqueue->get_text( ) }| ).
*      RETURN.
*  ENDTRY.
*
*ENDWHILE.
*
*out->write( 'El objeto ya está disponible' ).
*
*
*DATA ls_new_registro TYPE ztab_eje1_der.
*ls_new_registro = VALUE #(
*  mandt         = '100'
*  id            = '00000006'
*  first_name    = 'Daniel'
*  last_name     = 'RUIZ'
*  email         = 'lauram@example.com'
*  phone_number  = '38512369'
*  salary        = '2000.30'
*  currency_code = 'EUR'
*).
*wait up to 15 seconds.
*MODIFY ztab_eje1_der FROM @ls_new_registro.
*
*IF sy-subrc = 0.
*  out->write( 'La base de datos ha sido actualizada' ).
*ELSE.
*  out->write( 'No se pudo actualizar la base de datos' ).
*ENDIF.
*
*" (Opcional) COMMIT WORK.
*
*"---------------- Liberación del bloqueo -----------------------------------
*IF lv_locked = abap_true.
*  TRY.
*      lo_lock_object->dequeue( it_parameter = lt_parameter ).
*    CATCH cx_abap_lock_failure INTO DATA(lx_deq).
*      out->write( |No se pudo liberar el lock: { lx_deq->get_text( ) }| ).
*  ENDTRY.
*  out->write( 'El objeto ha sido liberado' ).
*ENDIF.

"---------------------- Primera parte sentencia de bloqueo-----------------------------
data lv_comprobacion type i VALUE 1.

    out->write( 'El usuario ha empezado el programa' ). " AÑADIDA
    TRY.

        DATA(lo_lock_object) = cl_abap_lock_object_factory=>get_instance( EXPORTING iv_name = 'EZ_BLOK_DER' ).
      CATCH cx_abap_lock_failure.
             out->write( 'El objeto instance no se ha creado' ).
             RETURN. " AÑADIDA
    ENDTRY.


        DATA lt_parameter TYPE if_abap_lock_object=>tt_parameter.
        lt_parameter = VALUE #( (   name = 'ID'
                                   value = REF #( '00000001' ) )
                                    ).
while lv_comprobacion <> 0.


 TRY. " AÑADIDA
        lo_lock_object->enqueue(
*               it_table_mode =
         it_parameter  =  lt_parameter
*               _scope        =
*               _wait         =
        ).

lv_comprobacion = 0.

      CATCH cx_abap_foreign_lock  cx_abap_lock_failure.

        out->write( 'El objeto ya esta siendo tratado por otro usuario ' ).

     " return. " AÑADIDA
    ENDTRY.

    out->write( 'El objeto ya esta disponible' ).

endwhile.
    "--------------- segunda parte , "intento" crear una nueva fila----------------------------

    DATA ls_new_registro TYPE ztab_eje1_der.

    ls_new_registro  =  VALUE #(
                                  mandt         = '100'
                                  id            = '00000006'
                                  first_name    = 'Daniel'
                                  last_name     = 'RUIZ'
                                  email         = 'lauram@example.com'
                                  phone_number  = '38512369'
                                  salary        = '2000.30'
                                  currency_code = 'EUR' ).

wait up to 15 seconds.

    MODIFY ztab_eje1_der FROM @ls_new_registro.

    "---------------- tercera parte, liberación del objeto.---------------------------------------

    IF sy-subrc = 0.
      out->write( 'El la base de datos ha sido actualizado ' ).
    ENDIF.

    TRY.
        lo_lock_object->dequeue( it_parameter = lt_parameter ).
      CATCH cx_abap_lock_failure.
        out->write( 'El objeto no ha sido liberado' ).
    ENDTRY.
    out->write( 'El objeto ha sido liberado' ).


  ENDMETHOD.

ENDCLASS.
