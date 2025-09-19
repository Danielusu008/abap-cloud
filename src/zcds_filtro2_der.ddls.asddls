@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'filtro 2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_filtro2_der 
with parameters 
    pCountryCode : land1



as select from /dmo/travel as Travel
  association [1..1] to ZCDS_filtro_der as _Agency on _Agency.AgencyId = $projection.AgencyId
{
    key travel_id  as TravelId,
    Travel.agency_id as AgencyId,
   
    _Agency( pCountryCode :  $parameters.pCountryCode )[City = 'Chicago'].City as City,
    _Agency(pCountryCode : $parameters.pCountryCode)[inner].Name as AgencyName
    //[City = 'Chicago']
}
