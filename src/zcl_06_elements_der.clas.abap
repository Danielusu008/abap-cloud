CLASS zcl_06_elements_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CONSTANTS: lc_light_speed   TYPE string VALUE '3,00 · 108 m/s',
               lc_permeability  TYPE string VALUE '4p · 10-7 H/m',
               lc_permittivity  TYPE string VALUE '8,85 · 10-12 F/m',
               lc_mass_electron TYPE string VALUE '9,1091 · 10-31 kg'.




    ".............
    TYPES: BEGIN OF ty_elem_objects,
             class     TYPE string,
             instance  TYPE string,
             reference TYPE string,
           END OF ty_elem_objects.


    DATA ms_object TYPE ty_elem_objects.
    METHODS set_object IMPORTING is_object TYPE ty_elem_objects.
    class-METHODS hola.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_06_elements_der IMPLEMENTATION.
  METHOD set_object.
    me->ms_object = is_object.
  ENDMETHOD.
  METHOD hola.

  ENDMETHOD.

ENDCLASS.
