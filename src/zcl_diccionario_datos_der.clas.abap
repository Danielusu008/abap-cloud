CLASS zcl_diccionario_datos_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_diccionario_datos_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


*    DATA lv_nombre TYPE zde_nombre_der.
*    DATA ls_empleado type zst_anidada_der.
*
*
*    out->write( ls_empleado ).

    "estructura plana
    "Subestructura (plana)
*    TYPES : BEGIN OF ty_addr,
*
*              steet TYPE c LENGTH 30,
*              city  TYPE c LENGTH 20,
*            END OF ty_addr.
**
*    "estructura ANIDADA: contiene ty_addr como un campo
*
*    TYPES: BEGIN OF ty_employee_nested,
*
*           id type i,
*           name type c LENGTH 20,
*           addr type ty_addr, " subestructura anidada  seria igual que decir prueba : include zst_empleados_der.
*        end of ty_employee_nested.
*
*
*data ls_prueba type ty_employee_nested.
* out->write( ls_prueba ).
*


    " estructura profunda
    " producto simple para la tabla interna
*    TYPES: BEGIN OF ty_order_item,
*             producto TYPE c LENGTH 10,
*             camion   TYPE  i,
*           END OF ty_order_item.
*

*    "estructura profunda: tiene tipos dinamicos (string, tablas, referencias)
*
*
*    TYPES: BEGIN OF ty_customer_deep,
*             id      TYPE i,
*             name    TYPE string,  " profunda
*             addr    TYPE ty_addr, " anidada ( plana )
*             orders  TYPE STANDARD TABLE OF ty_order_item WITH EMPTY KEY, "profunda ( tabala interna )
*             refaddr TYPE REF TO ty_addr, " profunda ( esta haciendo una referencia)
*
*           END OF ty_customer_deep.
*

*    DATA ls_cust TYPE ty_customer_deep.
*    FREE ls_cust-orders .

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Construimos toda la estructura de una vez con VALUE #( ... )
*    ls_cust = VALUE ty_customer_deep(
*      id      = 1001                                    "campo simple
*      name    = |Daniel García|                         "STRING (profundo)
*      addr    = VALUE ty_addr(                          "subestructura anidada (plana)
*                   steet = 'Calle Mayor 1'
*                   city  = 'Madrid' )
*      orders  = VALUE #(                                "tabla interna (profunda)
*                   ( producto = 'A123' camion = 10 )
*                   ( producto = 'B777' camion =  5 ) )
*      refaddr = NEW ty_addr(                            "referencia a datos (profunda)
*                   steet = 'Av. del Sol 9'
*                   city  = 'Madrid' )
*    ).


*    "se podrian añadir mas pedididos despues con el append
*    APPEND VALUE #( producto = 'C999' camion = 2 ) TO ls_cust-orders.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    "--- Campos simples
*ls_cust-id   = 1.
*ls_cust-name = |Daniel|.          "string
*
*"--- Subestructura anidada (addr)
*ls_cust-addr-steet = 'Calle Mayor 1'.
*ls_cust-addr-city  = 'Madrid'.
*
*"--- Tabla interna (orders): añade filas
*APPEND VALUE #( producto = 'A123' camion = 10 ) TO ls_cust-orders.
*INSERT VALUE #( producto = 'B777' camion = 5 ) INTO TABLE ls_cust-orders.
*
*"--- Referencia a datos (refaddr): primero reserva memoria, luego asigna
*ls_cust-refaddr = NEW ty_addr( ).   "o: CREATE DATA ls_cust-refaddr.
*ls_cust-refaddr->steet = 'Av. del Sol 9'.
*ls_cust-refaddr->city  = 'Sevilla'.



    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*
**
*    out->write( 'Cliente:' ).
*    out->write( |ID: { ls_cust-id }  Nombre: { ls_cust-name } | ).
*
*    "Campos de la subestructura anidada
*    out->write( |Dirección: { ls_cust-addr-steet }, { ls_cust-addr-city }| ).
*
*    "Número de pedidos (tabla interna)
*    out->write( |Pedidos: { lines( ls_cust-orders ) }| ).
*
*    "Recorrer e imprimir la tabla interna
*    LOOP AT ls_cust-orders INTO DATA(ls_item).
*      out->write( |  - { ls_item-producto } x { ls_item-camion }| ).
*    ENDLOOP.
*
*    "Acceder a la referencia (desreferenciar con ->)
*    out->write( |RefAddr: { ls_cust-refaddr->steet }, { ls_cust-refaddr->city }| ).


    " Liberar memoria de la tabla interna (opcional)

*    FREE ls_cust-orders.                                "Libera memoria de pedidos
*    out->write( |Pedidos tras FREE: { lines( ls_cust-orders ) }| ).

    " tabla interna con tipos creados desde el diccionario de datos

*    DATA: lt_tabla_dic_datos      TYPE ztt_tipo_tablas_der,
*          ls_estructura_dic_datos TYPE  zst_empleados_der.
*
*
*        ls_estructura_dic_datos-employee_id = |00001|.
*        ls_estructura_dic_datos-category = 's'.
*        ls_estructura_dic_datos-fisrt_name = 'Daniel'.
*        ls_estructura_dic_datos-last_name = 'Elvira'.
*        ls_estructura_dic_datos-start_date = sy-datum.
*     out->write( ls_estructura_dic_datos ).
*
*APPEND ls_estructura_dic_datos to lt_tabla_dic_datos.
*     out->write( ls_estructura_dic_datos ).




*
*data lv_nombre type zde_nombre_rc.
*
*data ls_empleado  type zst_empleado_der.
*
*
*
*"dominions - > elementos de datos - > estructuras -> tablas
*data lt_empleado_tab type  ZTT_TAB_EMPLEADO_DER.
*
*ls_empleado-apellido = 'elvira'.
*ls_empleado-id = 01.
*ls_empleado-nombre = 'Daniel'.
*ls_empleado-telefono = 66843948.
*
*APPEND ls_empleado to lt_empleado_tab.
*
*ls_empleado-apellido = 'elvira'.
*ls_empleado-id = 02.
*ls_empleado-nombre = 'pedro'.
*ls_empleado-telefono = 66843948.
*
*APPEND ls_empleado to lt_empleado_tab.
*APPEND ls_empleado to lt_empleado_tab.
*APPEND ls_empleado to lt_empleado_tab.
*
*
*out->write( lt_empleado_tab ).
*





  ENDMETHOD.

ENDCLASS.
