CLASS zcl_programacion_dinamica_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PROGRAMACION_DINAMICA_DER IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


"================== 1) Field-symbol sobre variable simple ==================
DATA gv_employee TYPE string.                                  " Variable base (string)
"FIELD-SYMBOLS <gfs_employee> TYPE string.                      " Puntero a string

ASSIGN gv_employee TO  FIELD-SYMBOL(<gfs_employee>).                          " <gfs_employee> apunta a gv_employee
<gfs_employee> = 'Maria'.                                      " Cambia el valor a través del puntero
"out->write( |1) gv_employee = { gv_employee }| ).              " => 'Maria'
UNASSIGN <gfs_employee>.
"out->write( |1) gv_employee = { gv_employee }| ).

                                   " Libera el puntero

*"================== 2) Cargar empleados desde la BD ========================
DATA gt_employees     TYPE STANDARD TABLE OF ztab_eje1_der.      " ITAB base
DATA gt_employees_for TYPE STANDARD TABLE OF ztab_eje1_der.      " ITAB copia
SELECT * FROM ztab_eje1_der INTO TABLE @gt_employees.            " Carga inicial
"out->write( data = gt_employees name = '2) Carga inicial' ).
*
*"================== 3A) LOOP INTO (no modifica la ITAB) ====================
LOOP AT gt_employees INTO DATA(gs_employee).                   " Copia cada fila
  gs_employee-email = 'into@example.com'.
                                                            " Cambia SOLO la copia local
ENDLOOP.
out->write( data = gt_employees name = '3A) Tras LOOP INTO (sin cambios)' ).

*"================== 3B) LOOP ASSIGNING (sí modifica la ITAB) ===============
"FIELD-SYMBOLS <fs_employee> LIKE LINE OF gt_employees.         " Puntero a línea de la ITAB


LOOP AT gt_employees ASSIGNING FIELD-SYMBOL(<fs_employee>).                  " Referencia directa a la fila real
  <fs_employee>-email = 'assigning@example.com'.               " Cambia la ITAB in-place
ENDLOOP.

out->write( data = gt_employees name = '3B) Tras LOOP ASSIGNING (modificado)' ).

*"================== 4) APPEND INITIAL LINE + ASSIGNING =====================
APPEND INITIAL LINE TO gt_employees ASSIGNING FIELD-SYMBOL(<fs_new_append>).
<fs_new_append> = VALUE #(
  mandt         = sy-mandt
  id            = 50000001
  first_name    = 'Pedro'
  last_name     = 'Mora'
  email         = 'pedro.mora@append.es'
  phone_number  = 38512369
  salary        = '2000'
  currency_code = 'EUR'
).
out->write( data = gt_employees name = '4) Tras APPEND' ).

*"================== 5) INSERT INITIAL LINE en índice 2 =====================
INSERT INITIAL LINE INTO gt_employees ASSIGNING FIELD-SYMBOL(<fs_new_insert>) INDEX 2.
<fs_new_insert> = VALUE #(
  mandt         = sy-mandt
  id            = 50000002
  first_name    = 'Lucia'
  last_name     = 'Rey'
  email         = 'lucia.rey@insert.es'
  phone_number  = 31234567
  salary        = '2400'
  currency_code = 'EUR'
).
out->write( data = gt_employees name = '5) Tras INSERT en índice 2' ).
*
*"================== 6) READ TABLE ASSIGNING por FIRST_NAME =================
READ TABLE gt_employees ASSIGNING FIELD-SYMBOL(<fs_found>)
     WITH KEY first_name = 'Mario'.
IF sy-subrc = 0.
  <fs_found>-last_name = 'Rivera'.
  <fs_found>-email     = 'mario.rivera@read.es'.
  out->write( |6) Mario encontrado y modificado.| ).
ELSE.
  out->write( |6) Mario no existe en la ITAB.| ).
ENDIF.
out->write( data = gt_employees name = '6) Tras READ/UPDATE' ).
*
*"================== 7) Copia con FOR + CORRESPONDING =======================
gt_employees_for = VALUE #(
  FOR ls_emp IN gt_employees
  ( CORRESPONDING #( ls_emp ) )
).
out->write( data = gt_employees_for name = '7) Copia con FOR + CORRESPONDING' ).

" con los field symbols el eje anterior
*    gt_employees_for = VALUE #(                  " construye otra tabla a partir de gt_employees
*      FOR <gfs_employee> IN gt_employees        " bucle de compresion: recorre cada fila
*      ( CORRESPONDING #( <gfs_employee> ) )     " inserta una linea copiando campos por Nombre (1:1)
*    ).                                           " gt_emloyees_for queda como copia de gt_employees


  ENDMETHOD.
ENDCLASS.
