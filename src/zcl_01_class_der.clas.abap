CLASS zcl_01_class_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor importing iv_employee_id type string .
    METHODS get_employee_id returning VALUE(rv_employee_id) type string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    data employee_id type string.
ENDCLASS.



CLASS zcl_01_class_der IMPLEMENTATION.
  METHOD constructor.
    me->employee_id = iv_employee_id.
  ENDMETHOD.

  METHOD get_employee_id.
    rv_employee_id = me->employee_id.
  ENDMETHOD.

ENDCLASS.
