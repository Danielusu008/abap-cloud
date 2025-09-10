CLASS zcl_run_orders_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.                        "Permite out->write
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_run_orders_der IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.                         "Punto de entrada
    DATA(lo_o1) = NEW zcl_shop_order_der( ).              "Crea primer pedido
    DATA(lo_o2) = NEW zcl_shop_order_der( ).              "Crea segundo pedido

    IF lo_o1 IS BOUND AND lo_o2 IS BOUND.                 "Comprueba referencias

      "---- Asigna cliente al pedido 1
      DATA(lv_stage1) = VALUE string( ).                  "Etapa del flujo
      lo_o1->set_customer(                                "Llama método instancia
        EXPORTING
          iv_name   = 'Acme Robotics'                     "Nombre cliente
          iv_region = 'EU-Central'                        "Región envío
        IMPORTING
          ev_msg    = DATA(lv_msg1)                       "Mensaje de salida
        CHANGING
          cv_stage  = lv_stage1                           "Etapa mutable
      ).

      "---- Prepara líneas de pedido 1 con VALUE #(
      DATA(lt_items1) = VALUE zcl_shop_order_der=>tty_item( "Tabla de líneas
        ( sku = 'RBT-100' descr = 'Robot Arm'  qty = 2 unit_price = '899.00' )
        ( sku = 'CNV-050' descr = 'Conveyor'   qty = 1 unit_price = '499.90' )
      ).
      lo_o1->add_items( lt_items1 ).                      "Añade las líneas

      "---- Muestra resumen pedido 1
      lo_o1->get_summary( IMPORTING ev_text = DATA(lv_sum1) ). "Compone resumen
      out->write( lv_sum1 ).                              "Imprime

      "---- Asigna cliente al pedido 2
      DATA(lv_stage2) = |KICKOFF|.                        "Etapa inicial
      lo_o2->set_customer(
        EXPORTING
          iv_name   = 'Nova Components'
          iv_region = 'NA-East'
        IMPORTING
          ev_msg    = DATA(lv_msg2)
        CHANGING
          cv_stage  = lv_stage2
      ).

      "---- Prepara líneas de pedido 2
      lo_o2->add_items( VALUE zcl_shop_order_der=>tty_item(
        ( sku = 'PSU-750' descr = 'Power Supply' qty = 3 unit_price = '129.50' )
        ( sku = 'CAB-ETH' descr = 'Ethernet Cable' qty = 5 unit_price = '12.99' )
      ) ).

      "---- Lee y cambia atributos estáticos compartidos
      out->write( |Moneda actual: { zcl_shop_order_der=>currency_code }| ). "Lee estático público
      zcl_shop_order_der=>currency_code = 'USD'.         "Cambia estático público
      out->write( |Moneda tras cambio: { zcl_shop_order_der=>currency_code }| ).

      "---- Muestra IVA actual y luego lo cambia para TODOS
      zcl_shop_order_der=>get_tax_rate( IMPORTING ev_rate = DATA(lv_iva_before) ). "Lee IVA
      out->write( |IVA actual: { lv_iva_before }%| ).
      zcl_shop_order_der=>set_tax_rate( iv_rate = '18' ). "Cambia IVA compartido
      zcl_shop_order_der=>get_tax_rate( IMPORTING ev_rate = DATA(lv_iva_after) ).  "Lee nuevo IVA
      out->write( |IVA nuevo: { lv_iva_after }%| ).

      "---- Totales con nuevo IVA (afecta a ambas instancias)
      out->write( |Total Pedido1: { lo_o1->get_total( ) } { zcl_shop_order_der=>currency_code }| ).
      out->write( |Total Pedido2: { lo_o2->get_total( ) } { zcl_shop_order_der=>currency_code }| ).

      "---- Demostración de RETURNING y LINES( )
      out->write( |Líneas P1: { lo_o1->get_item_count( ) }| ).
      out->write( |Líneas P2: { lo_o2->get_item_count( ) }| ).

    ENDIF.
  ENDMETHOD.

ENDCLASS.
