CLASS zcl_01_main_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_01_main_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
*  DATA(go_person) = NEW zcl_04_person_der( ).
*
*  "Método con IMPORTING -> caller usa EXPORTING
*  go_person->set_age( EXPORTING iv_age = 28 ).
*
*  "Método con EXPORTING -> caller usa IMPORTING
*  go_person->get_age( IMPORTING ev_age = DATA(gv_age) ).
*
*  out->write( |My age is { gv_age }| ).

    "--------------- 7 ------------
*    DATA(go_elements) = NEW zcl_06_elements_der( ).
*    DATA gs_object TYPE zcl_06_elements_der=>ty_elem_objects.
*
*
*
*    gs_object-class     = 'ABAP_CLASS'.
*    gs_object-instance  = 'INSTANCE 123'.
*    gs_object-reference = 'GO_ELEMENTS'.
*
*    go_elements->set_object( exporting is_object = gs_object ).
*
*    out->write( go_elements->ms_object ).
*
*    out->write( zcl_06_elements_der=>lc_light_speed ).
*    out->write( zcl_06_elements_der=>lc_permeability ).
*    out->write( zcl_06_elements_der=>lc_permittivity ).
*    out->write( zcl_06_elements_der=>lc_mass_electron ).
    "--------------------4------------------------------

*    DATA(go_student)  = NEW zcl_07_student_der(  ).
*
*    go_student->set_birth_date( '19921102' ).
*    out->write( go_student->birth_date ).

".......................................................
*    DATA(lo_flight) = NEW zcl_05_flight_DER(  ).
*
* data(lv_bool) = lo_flight->check_flight( EXPORTING iv_carrier_id  = 'AA'  iv_connexion_id = '0118' ).
*   out->write( lv_bool ).
"----------------------------------
*    zcl_08_work_record_der=>open_new_record( exporting iv_date = cl_abap_context_info=>get_system_date(  )
*                                                        iv_first_name = 'Jhon'
*                                                        iv_last_name  = 'Smith' ).
"------------------------------------

*    data(go_account) = new zcl_09_account_der(  ).
*
*    go_account->set_iban( exporting iban = 'ES34 5757 4848 8484 9393'  ).
*    go_account->get_iban( IMPORTING iban =  data(lv_iban) ).
*
*    out->write( lv_iban ).
  ENDMETHOD.


ENDCLASS.
