CLASS zcl_07_student_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA birth_date TYPE zde_date_der READ-ONLY.
    METHODS set_birth_date IMPORTING iv_birth_date TYPE zde_date_der.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_07_student_der IMPLEMENTATION.

  METHOD set_birth_date.
    me->birth_date = iv_birth_date.
  ENDMETHOD.
ENDCLASS.
