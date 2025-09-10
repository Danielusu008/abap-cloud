CLASS zcl_second_key_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_second_key_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*Data: gt_employees type SORTED TABLE OF ztab_eje1_der with UNIQUE key id
*           with NON-UNIQUE SORTED KEY first_name
*           COMPONENTS last_name.
*



DATA gt_employees_dd TYPE ztt_secundaria_der.

SELECT *
  FROM ztab_keys_der
  INTO CORRESPONDING FIELDS OF TABLE @gt_employees_dd.

    loop at gt_employees_dd ASSIGNING FIELD-SYMBOL(<gs_employees>) where employee_id between  '00002' and  '00005'.


   out->write( <gs_employees> ).


    endloop.





  ENDMETHOD.

ENDCLASS.
