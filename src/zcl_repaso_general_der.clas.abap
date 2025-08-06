CLASS zcl_repaso_general_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_repaso_general_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


*    " =============================
*    " PARTE 1 - Gestión de pasajeros
*    " =============================
*
*    " 1. Definición del tipo de estructura para pasajeros
*    TYPES: BEGIN OF ty_pasajero,
*             nombre TYPE string,
*             edad   TYPE i,
*             email  TYPE /dmo/email_address,
*           END OF ty_pasajero.
*
*    TYPES: ty_tabla_pasajeros TYPE STANDARD TABLE OF ty_pasajero WITH EMPTY KEY.
*
*    " 2. Declaración y carga inicial de tabla de pasajeros con APPEND VALUE
*    DATA lt_pasajeros TYPE ty_tabla_pasajeros.
*
*    APPEND VALUE #( nombre = 'Ana'    edad = 28 email = 'ana@viajes.com' )    TO lt_pasajeros.
*    APPEND VALUE #( nombre = 'Pedro'  edad = 17 email = 'pedro@viajes.com' )  TO lt_pasajeros.
*    APPEND VALUE #( nombre = 'Lucía'  edad = 34 email = 'lucia@viajes.com' )  TO lt_pasajeros.
*    APPEND VALUE #( nombre = 'Marcos' edad = 15 email = 'marcos@viajes.com' ) TO lt_pasajeros.
*
*    " 3. Insertar a Carlos en la segunda posición usando INSERT ... INDEX
*    INSERT VALUE #( nombre = 'Carlos' edad = 22 email = 'carlos@viajes.com' )
*      INTO lt_pasajeros INDEX 2.
*
*    " 4. Crear tabla con pasajeros menores de 30 años
*    DATA lt_pasajeros2 TYPE ty_tabla_pasajeros.
*    DATA ls_pasajero   TYPE ty_pasajero.
*
*    LOOP AT lt_pasajeros INTO ls_pasajero.
*      IF ls_pasajero-edad < 30.
*        APPEND ls_pasajero TO lt_pasajeros2.
*      ENDIF.
*    ENDLOOP.
*
*    " 5. Leer pasajero en posición 3 y mostrar su nombre en mayúsculas
*    READ TABLE lt_pasajeros ASSIGNING FIELD-SYMBOL(<fs_pasajero>) INDEX 3. " con los field-symols
*    IF sy-subrc = 0.
*      out->write( |Nombre en mayúsculas: { to_upper( <fs_pasajero>-nombre ) }| ).
*    ENDIF.
*
*    DATA(ls_data) = lt_pasajeros[ 3 ]-nombre. " forma moderna
*    out->write( |Nombre en mayúsculas: { to_upper( ls_data ) }| ).
*
*    out->write( |\n| ).
*    out->write( |\n| ).
*
*    " Mostrar la tabla de pasajeros original
*    out->write( data = lt_pasajeros name = 'Pasajeros (tabla original)' ).
*    out->write( |\n| ).
*    " Mostrar la tabla de pasajeros filtrada
*    out->write( data = lt_pasajeros2 name = 'Pasajeros menores de 30' ).
*    out->write( |\n| ).
*
*    " =============================
*    " PARTE 2 - Gestión de aeropuertos
*    " =============================
*
*    " 6. Crear y rellenar tabla de aeropuertos manualmente
*    DATA lt_aeropuertos TYPE STANDARD TABLE OF /dmo/airport.
*
*    INSERT VALUE #( client = '100' airport_id = 'FRA' name = 'Frankfurt' city = 'Frankfurt' country = 'DE' )
*      INTO TABLE lt_aeropuertos.
*    INSERT VALUE #( client = '100' airport_id = 'MUC' name = 'Munich'    city = 'Munich'    country = 'DE' )
*      INTO TABLE lt_aeropuertos.
*    INSERT VALUE #( client = '100' airport_id = 'BCN' name = 'Barcelona' city = 'Barcelona' country = 'ES' )
*      INTO TABLE lt_aeropuertos.
*
*    " 7. Copiar aeropuertos alemanes a una nueva tabla
*    DATA lt_alemanes TYPE STANDARD TABLE OF /dmo/airport.
*    DATA ls_aeropuerto TYPE /dmo/airport.
*
*    LOOP AT lt_aeropuertos INTO ls_aeropuerto.
*      IF ls_aeropuerto-country = 'DE'.
*        APPEND ls_aeropuerto TO lt_alemanes.
*      ENDIF.
*    ENDLOOP.
*
*    " 8. Leer aeropuerto con airport_id = 'MUC' con READ moderno
*    DATA(ls_muc) = lt_aeropuertos[ airport_id = 'MUC' ].
*    out->write( |Ciudad del aeropuerto MUC: { ls_muc-city }| ).
*
*
*    " =============================
*    " PARTE 3 - Funciones de texto
*    " =============================
*
*    " 9. Texto de entrada
*    DATA(lv_texto) = 'El pasajero Pedro con email pedro@viajes.com ha comprado el billete'.
*
*    " 10. Extraer nombre del pasajero entre "pasajero " y " con"
*    DATA(lv_temp) = substring_after( val = lv_texto sub = 'pasajero ' ).
*    DATA(lv_nombre) = substring_before( val = lv_temp sub = ' con' ).
*
*    out->write( |Nombre extraído: { lv_nombre }| ).
*
*    " Extraer el email con expresión regular usando MATCH
*    DATA(lv_pattern_email) = `\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b`.
*    DATA(lv_email) = match( val = lv_texto pcre = lv_pattern_email occ = '1' ).
*
*    out->write( |Email extraído: { lv_email }| ).
*
*    " 11. Reemplazar el nombre por 'XXXXX'
*    DATA(lv_texto_oculto) = replace( val = lv_texto sub = lv_nombre with = 'XXXXX' ).
*    out->write( |Texto con nombre oculto: { lv_texto_oculto }| ).
*
*
*    " =============================
*    " BONUS – Concatenar nombres
*    " =============================
*
*  " Declaramos una variable de tipo string para ir acumulando los nombres
*DATA(lv_lista_nombres) = ``.
*
*" Recorremos la tabla lt_pasajeros2 que contiene solo los pasajeros menores de 30
*LOOP AT lt_pasajeros2 INTO ls_pasajero.
*
*  " Si es la primera vuelta (la cadena está vacía), asignamos directamente el nombre
*  IF lv_lista_nombres IS INITIAL.
*    lv_lista_nombres = ls_pasajero-nombre.
*  ELSE.
*    " Si ya hay un nombre en la lista, concatenamos el siguiente separado por coma y espacio
*    CONCATENATE lv_lista_nombres ls_pasajero-nombre INTO lv_lista_nombres SEPARATED BY ', '.
*  ENDIF.
*
*ENDLOOP.
*
*" Mostramos por pantalla la lista final de nombres concatenados
*out->write( |Pasajeros menores de 30: { lv_lista_nombres }| ).

""2lklñ

  ENDMETHOD.
ENDCLASS.
