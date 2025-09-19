CLASS zcl_cds_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cds_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    SELECT FROM zcds_cl_der AS Booking
     FIELDS
     Booking~TravelId,
     Booking~BookinId,

     \_Travel-AgencyId,
     \_Travel\_Agency-name as AgencyName,
     \_Travel\_Customer-customer_id as CustomerId,
     concat_with_space( \_Travel\_Customer-first_name , \_Travel\_Customer-last_name , 1 ) as CustomerName

     where Booking~CarrierId = 'AA'
     into table @DATA(lt_results).
*     up to 5 ROWS.

   if sy-subrc = 0.
    out->write( lt_results ).
   endif.




ENDMETHOD.

ENDCLASS.
