CLASS zcl_03_contract_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA cntr_type TYPE c LENGTH 2.
    METHODS set_creation_date IMPORTING iv_creation_date TYPE zde_date_der.
  PROTECTED SECTION.
    DATA creation_date TYPE zde_date_der.
  PRIVATE SECTION.
    DATA client TYPE string.
ENDCLASS.



CLASS zcl_03_contract_der IMPLEMENTATION.
  METHOD set_creation_date.
    me->creation_date = iv_creation_date.
  ENDMETHOD.
ENDCLASS.

*Todos los atributos declarados en la sección pública son accesibles para
*todos los usuarios de la clase (es decir en todo el contexto del servidor
*ABAP) y para todos los métodos de la clase y de cualquier clase que herede
*de ella, mientras que los atributos declarados en la sección protegida son
*accesibles para todos los métodos de la clase y de las subclases que heredan
*de ella. Con respeto a los atributos declarados en la sección privada son sólo
*visibles en los métodos de la misma clase.
