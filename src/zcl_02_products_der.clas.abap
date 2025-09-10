CLASS zcl_02_products_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS set_product IMPORTING iv_product TYPE matnr.
    METHODS set_creation_date IMPORTING iv_creation_date TYPE zde_date_der.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA product TYPE matnr.
    DATA creation_date TYPE zde_date_der.
ENDCLASS.



CLASS zcl_02_products_der IMPLEMENTATION.
  METHOD set_creation_date.
  "auto referencia / me->  : Es una referencia implicita a la INSTANCIA ACTUAL, solo en metodos de instancia y constructor.
  "no existe en metodos estaticos ni en "class_constructor".
  "con el me-> accedes a atributos / metodos de instancia, desambiguas nombres y puedes pasarte "a ti mismo" como parametro
    me->creation_date  = iv_creation_date.

  ENDMETHOD.

  METHOD set_product.
    me->product = iv_product.
  ENDMETHOD.

ENDCLASS.
