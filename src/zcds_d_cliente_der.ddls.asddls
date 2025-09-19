@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'd cliente'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_d_cliente_der
  as select from ztab_customer
{
  key doc_id       as DocId,
  key matricula    as Matricula,
      fecha_inicio as FechaInicio,
      fecha_fin    as FechaFin,
      nombres      as Nombres,
      apellidos    as Apellidos,
      email        as Email,
      cntr_type    as CntrType
}
