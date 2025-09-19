@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'asociacion con parametros'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_asociacion_par_Der
    with parameters 
     pCountryCode : land1
 as select from /dmo/travel as Travel
   
   association[1..1] to ZCDS_CDS_DER as _Agency on _Agency.AgencyId = $projection.AgencyId
   
  
{
      key travel_id            as TravelId,
      Travel.agency_id         as AgencyId,
      _Agency(pCountryCode : $parameters.pCountryCode).Name as AgencyName
}
