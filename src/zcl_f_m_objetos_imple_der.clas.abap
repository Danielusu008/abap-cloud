CLASS zcl_f_m_objetos_imple_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_f_m_objetos_imple_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    Data(lo_perro) = New zcl_f_m_objetos_der(  ).
    data(lo_perrodos)  = New zcl_f_m_objetos_der(  ).


    if lo_perro is BOUND.

        lo_perro->lv_nombre = 'Dante'.
        lo_perro->lv_raza = 'Pastor Suizo'.

        out->write( lo_perro->ladrar(  ) ).




        lo_perro->lanzar_pelota(
          RECEIVING
            rv_accion = data(lv_acction)
        ).

      out->write( lv_acction ).
           out->write( lo_perro->lv_raza ).
    endif.


    if lo_perrodos is BOUND.

        lo_perrodos->lv_nombre = 'Pancho'.
        lo_perrodos->lv_raza = 'Pastor Aleman'.

        out->write( lo_perrodos->ladrar(  ) ).




        lo_perrodos->lanzar_pelota(
          RECEIVING
            rv_accion = lv_acction
        ).

      out->write( lv_acction ).
           out->write( lo_perrodos->lv_raza ).
    endif.


  ENDMETHOD.

ENDCLASS.
