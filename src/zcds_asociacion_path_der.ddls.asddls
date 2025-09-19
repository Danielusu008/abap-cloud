@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds con asociacion'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_asociacion_path_der 
as select from /dmo/travel
association [0..*] to I_CurrencyText as _Currency on _Currency.Currency = $projection.Currency
{
    key travel_id as TravelID,
    @Semantics.amount.currencyCode: 'Currency'
    total_price as Price, 
    currency_code as Currency, 
    _Currency[1:Language = $session.system_language ].CurrencyName 
}
