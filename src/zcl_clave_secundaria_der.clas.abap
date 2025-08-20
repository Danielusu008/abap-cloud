CLASS zcl_clave_secundaria_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
PUBLIC SECTION.
INTERFACES if_oo_adt_classrun.
METHODS constructor.
METHODS read_primary.
METHODS read_non_key.
METHODS read_secondary_1.
METHODS read_secondary_2.
METHODS read_secondary_3.

PROTECTED SECTION.
PRIVATE SECTION.
DATA: lt_sort TYPE SORTED TABLE OF /dmo/booking_m WITH NON-UNIQUE KEY travel_id booking_id booking_date,
      lt_sort_with_sk TYPE SORTED TABLE OF /dmo/booking_m WITH NON-UNIQUE KEY travel_id booking_id booking_date
        WITH NON-UNIQUE SORTED KEY sk_carrier COMPONENTS carrier_id.


ENDCLASS.



CLASS zcl_clave_secundaria_der IMPLEMENTATION.


METHOD constructor.
  SELECT FROM /dmo/booking_m
         FIELDS *
         INTO TABLE @lt_sort.

  SELECT FROM /dmo/booking_m
         FIELDS *
         INTO TABLE @lt_sort_with_sk.
ENDMETHOD.

METHOD read_non_key.
  DATA(ls_flight_without_key) = lt_sort[ flight_date = '20240801' ].
ENDMETHOD.

METHOD read_primary.
  DATA(ls_flight) = lt_sort[
    travel_id    = '00000013'
    booking_id   = '0003'
    booking_date = '20240402'
  ].
ENDMETHOD.

METHOD read_secondary_1.
  DATA(ls_scnd_key1) = lt_sort_with_sk[ KEY sk_carrier carrier_id = 'AA' ].
ENDMETHOD.

METHOD read_secondary_2.
  DATA(ls_scnd_key2) = lt_sort_with_sk[ KEY sk_carrier carrier_id = 'AA' ].
ENDMETHOD.

METHOD read_secondary_3.
  DATA(ls_scnd_key3) = lt_sort_with_sk[ KEY sk_carrier carrier_id = 'AA' ].
ENDMETHOD.

METHOD if_oo_adt_classrun~main.
  DATA(object) = NEW zcl_clave_secundaria_der( ).

  object->read_non_key( ).
  object->read_primary( ).
  object->read_secondary_1( ).
  object->read_secondary_2( ).
  object->read_secondary_3( ).




out->write( 'ok' ).
ENDMETHOD.

ENDCLASS.
