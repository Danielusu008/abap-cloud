CLASS zcl_f_m_objetos_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    Data lv_nombre type string.
    Data lv_raza type string.

      METHODS: ladrar RETURNING VALUE(rv_accion) type string.
      METHODS: lanzar_pelota  RETURNING VALUE(rv_accion) type string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_f_m_objetos_der IMPLEMENTATION.

  METHOD ladrar.

        rv_accion = |{ lv_nombre } dice: guau guau |.

  ENDMETHOD.

  METHOD lanzar_pelota.

        rv_accion = |{ lv_nombre } Corre a por la pelota |.
  ENDMETHOD.

ENDCLASS.
