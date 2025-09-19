@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'clases'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZCDS_CL_DER2 
as select from /dmo/booking
association [1..1] to   ZCDS_FILTRO2_DER2    as _Travel on _Travel.TravelId  = $projection.TravelId
{
    key travel_id as TravelId,
    key booking_id as BookinId,

    _Travel.AgencyId ,
    _Travel._Agency.name as AgencyName,
    _Travel._Customer.customer_id as CustomerId,
    concat_with_space( _Travel._Customer.first_name, _Travel._Customer.last_name, 1) as CustomerName
}
where carrier_id = 'AA' ;
