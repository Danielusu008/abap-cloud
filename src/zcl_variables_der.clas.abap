CLASS zcl_variables_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun. """""

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_variables_der IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    """"""""""""""""""""""""""""
*DATA: lv_int_value TYPE i VALUE 100,     " Variable entera con valor inicial 100
*lv_ref_int   TYPE REF TO i.        " Variable referencia a un entero (apunta a un i)
*
*lv_ref_int = REF #( lv_int_value ).      " Toma la referencia (dirección) de lv_int_value y la guarda en lv_ref_int
*
*out->write( data = lv_int_value  name = 'Original value' ).        " Imprime el valor directo de la variable
*out->write( data = lv_ref_int->* name = 'Value through reference' ). " Imprime desreferenciando la referencia (->*

    """"""""""""""""""""""""""""""""""""
    SELECT FROM /dmo/flight
    FIELDS *
    INTO TABLE @DATA(lt_flight).
*
*
*
*ASSIGN lt_flight[ 2 ] TO FIELD-SYMBOL(<ls_flight>).
*out->write( <ls_flight> ).


*data(lr_flight) = ref #( lt_flight[ 2 ] ).
*out->write( lr_flight ).

*


*    out->write( |Filas en lt_emp: { lines( lt_emp ) }| ).
*    out->write( |Referencias en lt_emp_ref: { lines( lt_emp_ref ) }| ).
*
*out->write( lt_emp ).
*out->write( lt_emp_ref ).


*   MODIFY lt_emp FROM VALUE ty_emp( id = 1 nombre = 'Ana*' ciudad = 'Madrid' sueldo = 32000 ) INDEX 1.
*    out->write( |Nombre 1ª fila (vía ref): { lt_emp_ref[ 1 ]->nombre }| ).


*out->write( lt_emp ).
*out->write( lt_emp_ref ).



*
*
*
**--- 1) Referencia tipada + field-symbol --------------------------------------
*    DATA lr_i TYPE REF TO i.                         "declara ref a entero (aún vacía)
*    CREATE DATA lr_i.                                "reserva un entero y lo hace apuntar
*    FIELD-SYMBOLS <i> TYPE i.                        "alias temporal de entero (sin memoria)
*    ASSIGN lr_i->* TO <i>.                           "asigna el entero apuntado al alias
*    <i> = 42.                                        "escribe 42 a través del alias
*    out->write( |[1] lr_i->*={ lr_i->* } / <i>={ <i> }| ).  "mismo valor por ref y alias
*
**--- 2) Referencia genérica a string + alias genérico -------------------------
*    DATA lr_any TYPE REF TO data.                    "ref genérica (a cualquier tipo)
*    DATA lv_text TYPE string VALUE 'hola'.           "string con valor inicial
*    GET REFERENCE OF lv_text INTO lr_any.            "apunta a la variable existente
*    FIELD-SYMBOLS <any> TYPE any.                    "alias genérico (tipo ANY)
*    ASSIGN lr_any->* TO <any>.                       "engancha alias genérico al dato
*    <any> = |{ <any> } mundo|.                       "modifica lv_text indirectamente
*    out->write( |[2] lv_text={ lv_text }| ).         "muestra 'hola mundo'
*
**--- 3) Estructura por referencia ------------------------------------------------
*    TYPES: BEGIN OF ty_person,                       "estructura persona
*             id   TYPE i,
*             name TYPE string,
*           END OF ty_person.
*    DATA lr_pers TYPE REF TO ty_person.              "ref a estructura persona
*    CREATE DATA lr_pers.                             "reserva memoria para la estructura
*    FIELD-SYMBOLS <ls_pers> TYPE ty_person.          "alias de la estructura
*    ASSIGN lr_pers->* TO <ls_pers>.                  "engancha alias a la estructura real
*    <ls_pers>-id   = 1.                              "rellena campos
*    <ls_pers>-name = 'Ana'.
*    out->write( |[3] person id={ <ls_pers>-id } name={ <ls_pers>-name }| ).
*
**--- 4) Tabla interna por referencia y APPEND -----------------------------------
*    TYPES ty_tab_person TYPE STANDARD TABLE OF ty_person WITH EMPTY KEY. "tipo tabla
*    DATA lr_tab TYPE REF TO ty_tab_person.           "ref a la tabla interna
*    CREATE DATA lr_tab.                              "reserva la tabla vacía
*    FIELD-SYMBOLS <lt_pers> TYPE ty_tab_person.      "alias de la tabla
*    ASSIGN lr_tab->* TO <lt_pers>.                   "engancha alias a la tabla real
*    APPEND VALUE ty_person( id = 1 name = 'Ana'  ) TO <lt_pers>.  "insertar filas
*    APPEND VALUE ty_person( id = 2 name = 'Luis' ) TO <lt_pers>.
*    APPEND VALUE ty_person( id = 3 name = 'Marta' ) TO <lt_pers>.
*    out->write( data = <lt_pers> name = '[4] Tabla personas (inicial)' ). "imprime
*
**--- 5) Referencia a una LÍNEA concreta y edición vía ->* ----------------------
*    DATA lr_line2 TYPE REF TO ty_person.             "ref a una línea de la tabla
*    TRY.
*        lr_line2 = REF #( <lt_pers>[ 2 ] ).          "toma ref a fila 2 (Luis)
*        lr_line2->*-name = 'Luis (edit)'.            "modifica el campo name vía ref
*      CATCH cx_sy_itab_line_not_found.               "si no existe la fila
*        out->write( '[5] No existe la línea 2' ).
*    ENDTRY.
*    out->write( data = <lt_pers> name = '[5] Tras editar línea 2' ).
*
**--- 6) OPTIONAL al referenciar línea inexistente --------------------------------
*    DATA lr_line99 TYPE REF TO ty_person.            "ref potencial a fila 99
*    lr_line99 = REF #( <lt_pers>[ 99 ] OPTIONAL ).   "no lanza excepción si no hay fila
*    IF lr_line99 IS BOUND.                           "¿apunta a algo?
*      out->write( '[6] lr_line99 BOUND' ).           "sí, improbable aquí
*    ELSE.
*      out->write( '[6] lr_line99 NO BOUND' ).        "no se encontró la línea
*    ENDIF.
*
**--- 7) Estructura profunda: tabla dentro de estructura -------------------------
*    TYPES: BEGIN OF ty_order_item,                   "líneas de pedido
*             product TYPE string,
*             qty     TYPE i,
*           END OF ty_order_item.
*    TYPES ty_items TYPE STANDARD TABLE OF ty_order_item WITH EMPTY KEY. "tabla de items
*
*    TYPES: BEGIN OF ty_customer_deep,                "cliente con tabla interna
*             id    TYPE i,
*             name  TYPE string,
*             items TYPE ty_items,
*           END OF ty_customer_deep.
*
*    DATA lr_cust TYPE REF TO ty_customer_deep.       "ref a estructura profunda
*    CREATE DATA lr_cust.                             "reserva memoria
*    FIELD-SYMBOLS <ls_cust> TYPE ty_customer_deep.   "alias de la estructura
*    ASSIGN lr_cust->* TO <ls_cust>.                  "engancha alias
*    <ls_cust>-id = 10.                               "rellena datos simples
*    <ls_cust>-name = 'Cliente X'.
*    APPEND VALUE ty_order_item( product = 'A' qty = 2 ) TO <ls_cust>-items. "añade item
*    APPEND VALUE ty_order_item( product = 'B' qty = 1 ) TO <ls_cust>-items.
*    out->write( data = <ls_cust> name = '[7] Cliente profundo' ). "imprime todo
*
**--- 8) Tabla de REFERENCIAS a líneas y edición indirecta -----------------------
*    TYPES: BEGIN OF ty_person_ref,                   "estructura que guarda una ref
*             ref TYPE REF TO ty_person,
*           END OF ty_person_ref.
*    TYPES ty_tab_person_ref TYPE STANDARD TABLE OF ty_person_ref WITH EMPTY KEY. "tabla de refs
*
*    DATA lt_refs TYPE ty_tab_person_ref.             "tabla con referencias a filas
*    APPEND VALUE #( ref = REF #( <lt_pers>[ 1 ] ) ) TO lt_refs. "guarda ref fila 1
*    APPEND VALUE #( ref = REF #( <lt_pers>[ 3 ] ) ) TO lt_refs. "guarda ref fila 3
*
*    LOOP AT lt_refs INTO DATA(ls_ref).               "recorre refs guardadas
*      IF ls_ref-ref IS BOUND.                        "si la ref está ligada
*        ls_ref-ref->*-name = |{ ls_ref-ref->*-name } (OK)|. "edita nombre via ref
*      ENDIF.
*    ENDLOOP.
*    out->write( data = <lt_pers> name = '[8] Editado vía referencias' ).
*
**--- 9) Pipeline genérico: ref genérica -> alias -> salida ----------------------
*    DATA lr_gen TYPE REF TO data.                    "ref genérica
*    lr_gen = REF #( <ls_cust>-name ).                "apunta al campo name del cliente
*    IF lr_gen IS BOUND.                              "comprueba ref
*      FIELD-SYMBOLS <g> TYPE any.                    "alias genérico
*      ASSIGN lr_gen->* TO <g>.                       "engancha alias al dato
*      out->write( |[9] Nombre cliente (genérica) = { <g> }| ). "imprime
*    ENDIF.
*
**--- 10) Liberar la referencia tipada y chequear --------------------------------
*    FREE lr_i.                                       "libera el entero referenciado
*    IF lr_i IS NOT BOUND.                            "ya no apunta a nada
*      out->write( '[10] lr_i liberada; NO BOUND' ).
*    ENDIF.
**   Regla: nunca hagas lr_i->* sin comprobar IS BOUND (daría dump).
*
**=== BONUS: empleados + tabla de referencias a cada fila ========================
*    TYPES: BEGIN OF ty_emp,                          "estructura empleado
*             id     TYPE i,
*             nombre TYPE string,
*             ciudad TYPE string,
*             sueldo TYPE decfloat34,
*           END OF ty_emp.
*
*    DATA lt_emp TYPE STANDARD TABLE OF ty_emp WITH EMPTY KEY. "tabla interna simple
*    lt_emp = VALUE #(
*      ( id = 1 nombre = 'Ana'   ciudad = 'Madrid'   sueldo = 32000 )
*      ( id = 2 nombre = 'Luis'  ciudad = 'Sevilla'  sueldo = 29500 )
*      ( id = 3 nombre = 'Sara'  ciudad = 'Bilbao'   sueldo = 31000 )
*      ( id = 4 nombre = 'Diego' ciudad = 'Valencia' sueldo = 28000 ) ).
*
*    DATA lt_emp_ref TYPE STANDARD TABLE OF REF TO ty_emp WITH EMPTY KEY. "tabla de refs
*    LOOP AT lt_emp REFERENCE INTO DATA(lsr_emp).     "itera por empleados
*      APPEND lsr_emp TO lt_emp_ref.                  "guarda ref de cada fila
*    ENDLOOP.
*
*    IF lines( lt_emp_ref ) >= 3 AND lt_emp_ref[ 3 ] IS BOUND. "si hay 3ª ref
*      lt_emp_ref[ 3 ]->*-sueldo = 31500.             "sube sueldo a la fila 3 vía ref
*    ENDIF.
*
*    out->write( data = lt_emp name = '[B] Empleados tras editar por ref' ). "imprime final



     DATA lv_from type d value    '20250101'.
    DATA lv_to type d value      '20251231'.
    DATA lv_min_prc TYPE /dmo/flight_price VALUE '300'.

*--- 1) Detalle
    SELECT
      c~carrier_id    AS carrier,
      c~connection_id AS conn,
      af~city         AS city_from,
      at~city         AS city_to,
      f~flight_date,
      f~price,
      f~currency_code
    FROM /dmo/connection AS c
    INNER JOIN /dmo/flight  AS f
      ON  f~carrier_id    = c~carrier_id
      AND f~connection_id = c~connection_id
    INNER JOIN /dmo/airport AS af
      ON  af~airport_id   = c~airport_from_id
    INNER JOIN /dmo/airport AS at
      ON  at~airport_id   = c~airport_to_id
    WHERE f~flight_date BETWEEN @lv_from AND @lv_to
    ORDER BY f~flight_date ASCENDING
    INTO TABLE @DATA(lt_detail).

    out->write( data = lt_detail name = '1) Vuelos detalle' ).

*--- 2) Agregado + filtro min_price > lv_min_prc
    SELECT
      c~carrier_id    AS carrier,
      c~connection_id AS conn,
      af~city         AS city_from,
      at~city         AS city_to,
      f~currency_code AS currency,
      COUNT( * )      AS flights,
      MIN( f~price )  AS min_price,
      MAX( f~price )  AS max_price
    FROM /dmo/connection AS c
    INNER JOIN /dmo/flight  AS f
      ON  f~carrier_id    = c~carrier_id
      AND f~connection_id = c~connection_id
    INNER JOIN /dmo/airport AS af
      ON  af~airport_id   = c~airport_from_id
    INNER JOIN /dmo/airport AS at
      ON  at~airport_id   = c~airport_to_id
    WHERE f~flight_date BETWEEN @lv_from AND @lv_to
    GROUP BY c~carrier_id, c~connection_id, af~city, at~city, f~currency_code
    HAVING MIN( f~price ) > @lv_min_prc
    ORDER BY c~carrier_id, c~connection_id
    INTO TABLE @DATA(lt_agg).
out->write( |\n| ).
    out->write( data = lt_agg name = '2) Rutas con min_price > 300' ).


  ENDMETHOD.
ENDCLASS.















