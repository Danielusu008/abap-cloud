@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'días restantes'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_restantes_day_DER as select from ztab_rentcar_der
{
    key matricula as Matricula,
        marca as Marca, 
  
       dats_days_between( cast( $session.system_date as abap.dats ),alq_hasta ) * -1  as Dias
}
