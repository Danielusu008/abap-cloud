CLASS zcl_shop_order_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION. "Accesible desde fuera
    "---- Tipos


      TYPES: ty_amount TYPE p LENGTH 11 DECIMALS 2,
             ty_rate   TYPE p LENGTH 3  DECIMALS 2.

    "---- Tipos para líneas de pedido
    TYPES: BEGIN OF ty_item,                               "Estructura de una línea
             sku        TYPE string,                      "Código de artículo
             descr      TYPE string,                      "Descripción
             qty        TYPE i,                           "Cantidad
             unit_price TYPE p LENGTH 8 DECIMALS 2,       "Precio unitario
           END OF ty_item,
           tty_item TYPE STANDARD TABLE OF ty_item WITH EMPTY KEY. "Tabla de líneas

    "---- Atributo estático PÚBLICO (compartido)
    CLASS-DATA currency_code TYPE c LENGTH 3.             "Moneda común a todas las instancias

    "---- Métodos de instancia
    METHODS:
      constructor,                                        "Constructor de instancia
      set_customer                                        "Asigna cliente y región
        IMPORTING iv_name   TYPE string
                  iv_region TYPE string
        EXPORTING ev_msg    TYPE string
        CHANGING  cv_stage  TYPE string,
      add_items                                           "Añade líneas al pedido
        IMPORTING it_items TYPE tty_item,
      get_total                                           "Calcula total con impuestos
        RETURNING VALUE(rv_total) TYPE ty_amount,


      get_summary                                         "Devuelve texto resumen
        EXPORTING ev_text TYPE string,
      get_item_count                                      "Cuenta líneas
        RETURNING VALUE(rv_count) TYPE i.

    "---- Métodos estáticos (no requieren instancia)
    CLASS-METHODS:
      set_tax_rate IMPORTING iv_rate TYPE ty_rate, "Fija IVA %
      get_tax_rate EXPORTING ev_rate TYPE ty_rate. "Lee IVA %

        "---- Constructor estático
    CLASS-METHODS class_constructor.                      "Inicializa estáticos

  PROTECTED SECTION. "Visible para esta clase y subclases
    DATA created_on TYPE d.                               "Fecha de creación (instancia)

  PRIVATE SECTION.    "Solo visible dentro de esta clase
    "---- Atributos de instancia
    DATA customer_name   TYPE string.                     "Nombre cliente
    DATA shipping_region TYPE string.                     "Región envío
    DATA items           TYPE tty_item.                   "Líneas del pedido
    DATA order_id        TYPE i.                          "Id interno del pedido

    "---- Atributos estáticos PRIVADOS
    CLASS-DATA tax_rate TYPE p LENGTH 3 DECIMALS 2.       "IVA compartido
    CLASS-DATA next_id  TYPE i.                           "Contador de IDs


ENDCLASS.

CLASS zcl_shop_order_der IMPLEMENTATION.

  METHOD class_constructor.                               "Se ejecuta una vez por clase
    currency_code = 'EUR'.                                "Moneda por defecto
    tax_rate      = '21'.                                 "IVA inicial 21%
    next_id       = 1000.                                 "ID inicial
  ENDMETHOD.

  METHOD constructor.                                     "Se ejecuta al crear cada objeto
    next_id   = next_id + 1.                              "Incrementa contador global
    order_id  = next_id.                                  "Asigna ID único a la instancia
    created_on = sy-datum.                                "Guarda fecha de creación
  ENDMETHOD.

  METHOD set_customer.                                    "Método de instancia
    customer_name   = iv_name.                            "Guarda nombre
    shipping_region = iv_region.                          "Guarda región
    ev_msg          = |Cliente asignado|.                 "Mensaje de salida
    IF cv_stage IS INITIAL.                               "Si etapa vacía
      cv_stage = |INIT|.                                  "Asigna etapa
    ELSE.
      cv_stage = |{ cv_stage }->CLIENT_SET|.              "Actualiza etapa
    ENDIF.
  ENDMETHOD.

  METHOD add_items.                                       "Añade varias líneas
    APPEND LINES OF it_items TO items.                    "Inserta todas las filas
  ENDMETHOD.

  METHOD get_total.                                       "Calcula total con IVA
   data  lv_net TYPE ty_amount value 0.                         "Acumulador neto
    LOOP AT items ASSIGNING FIELD-SYMBOL(<ls>).           "Recorre líneas
      lv_net = lv_net + ( <ls>-qty * <ls>-unit_price ).  "Suma qty*precio
    ENDLOOP.
    rv_total = lv_net * ( 1 + tax_rate / 100 ).          "Aplica IVA
  ENDMETHOD.

  METHOD get_summary.                                     "Devuelve texto resumen
    DATA(lv_count) = get_item_count( ).                   "Cuenta líneas
    DATA(lv_total) = get_total( ).                        "Calcula total
    ev_text = |Pedido #{ order_id } · { customer_name } · { shipping_region } · |
              && |Líneas:{ lv_count } · Total:{ lv_total } { currency_code } · |
              && |IVA:{ tax_rate }% · Fecha:{ created_on }|. "Compone string
  ENDMETHOD.

  METHOD get_item_count.                                  "Devuelve nº de líneas
    rv_count = lines( items ).                            "Cuenta filas de la tabla
  ENDMETHOD.

  METHOD set_tax_rate.                                    "Estático: fija IVA
    tax_rate = iv_rate.                                   "Actualiza compartido
  ENDMETHOD.

  METHOD get_tax_rate.                                    "Estático: lee IVA
    ev_rate = tax_rate.                                   "Devuelve compartido
  ENDMETHOD.

ENDCLASS.

