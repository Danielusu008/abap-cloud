CLASS zcl_eje3_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EJE3_DER IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    " Declaramos la cadena original con los nombres separados por espacios
    DATA(lv_string) = 'daniel Fernando Pedro ramon Sergio'.

    " Quitamos espacios duplicados y espacios al principio/final si los hubiera
    CONDENSE lv_string.

    " Declaramos variables para almacenar cada nombre individualmente
*    DATA: lv_nombre1 TYPE string,
*          lv_nombre2 TYPE string,
*          lv_nombre3 TYPE string,
*          lv_nombre4 TYPE string,
*          lv_nombre5 TYPE string.
*
*    " Buscamos la posición del primer espacio
*    DATA(lv_pos1) = find( val = lv_string sub = | | ).
*
*    " Extraemos el primer nombre desde la posición 0 hasta antes del primer espacio
*    lv_nombre1 = substring( val = lv_string off = 0 len = lv_pos1 ).
*
*    " Obtenemos el resto de la cadena después del primer espacio
*    DATA(lv_rest1) = substring_after( val = lv_string sub = | | ).
*
*    " Buscamos el siguiente espacio en la nueva subcadena
*    DATA(lv_pos2) = find( val = lv_rest1 sub = | | ).
*
*    " Extraemos el segundo nombre
*    lv_nombre2 = substring( val = lv_rest1 off = 0 len = lv_pos2 ).
*
*    " Repetimos el proceso para extraer el tercer nombre
*    DATA(lv_rest2) = substring_after( val = lv_rest1 sub = | | ).
*    DATA(lv_pos3) = find( val = lv_rest2 sub = | | ).
*    lv_nombre3 = substring( val = lv_rest2 off = 0 len = lv_pos3 ).
*
*    " Repetimos el proceso para extraer el cuarto nombre
*    DATA(lv_rest3) = substring_after( val = lv_rest2 sub = | | ).
*    DATA(lv_pos4) = find( val = lv_rest3 sub = | | ).
*    lv_nombre4 = substring( val = lv_rest3 off = 0 len = lv_pos4 ).
*
*    " El quinto nombre es lo que queda después del último espacio
*    lv_nombre5 = substring_after( val = lv_rest3 sub = | | ).


"""""""""""""""" lo mismo con funcion split"""""""""""""""""""""""""
    DATA: lv_nombre1 TYPE string,
          lv_nombre2 TYPE string,
          lv_nombre3 TYPE string,
          lv_nombre4 TYPE string,
          lv_nombre5 TYPE string.

    " Extraer los nombres usando SPLIT
    SPLIT lv_string AT space  INTO  lv_nombre1 lv_nombre2 lv_nombre3 lv_nombre4 lv_nombre5.

    """""""""""""" SEGUNDA PARTE DEL EJERCICIO """"""""""""""""



    " Seleccionamos un nombre a evaluar (en este caso, el primero: daniel)
    DATA(lv_nombre) = lv_nombre2.

    " Obtenemos su longitud
    DATA(lv_longitud) = strlen( lv_nombre ).

    " Evaluamos según la longitud del nombre
    IF lv_longitud > 7.
      " Si tiene más de 7 caracteres, asumimos que es Fernando
      out->write( 'Hola Fernando' ).

    ELSEIF lv_longitud = 6.
      " Si tiene 6 caracteres puede ser Sergio o Daniel
      IF lv_nombre = 'Sergio'.
        out->write( 'Hola Sergio' ).
      ELSEIF lv_nombre = 'daniel'.
        out->write( 'Hola Daniel' ).
      ENDIF.

    ELSE.
      " Si no es ninguno de los anteriores, asumimos que es Pedro
      out->write( 'Hola Pedro' ).

      " Convertimos el nombre a mayúsculas
      lv_nombre = to_upper( lv_nombre ).

      " Mostramos el nombre en mayúsculas
      out->write( |Nombre en mayúsculas: { lv_nombre }| ).
    ENDIF.


*
*   " Cadena original con nombres separados por espacios
*    DATA(lv_string) = 'daniel Fernando Pedro ramon Sergio'.
*
*    " Eliminar espacios sobrantes por si acaso
*    condense lv_string.
*
*    " Variables para cada nombre
*    DATA: lv_nombre1 TYPE string,
*          lv_nombre2 TYPE string,
*          lv_nombre3 TYPE string,
*          lv_nombre4 TYPE string,
*          lv_nombre5 TYPE string.
*
*    " Extraer los nombres usando SPLIT
*    SPLIT lv_string AT space INTO  lv_nombre1 lv_nombre2 lv_nombre3 lv_nombre4 lv_nombre5.
*
*    " Seleccionamos uno de ellos para analizarlo (puedes cambiarlo)
*    DATA(lv_nombre) = lv_nombre2.
*
*    " Obtener la longitud del nombre
*    DATA(lv_longitud) = strlen( lv_nombre ).
*
*    " Aplicar la lógica con IFs
*    IF lv_longitud > 7.                         "     IF strlen( lv_nombre ) > 7.
*
*      out->write( 'Hola Fernando' ).
*
*    ELSEIF lv_longitud = 6.                      "    ELSEIF strlen( lv_nombre ) = 6.
*
*      IF lv_nombre = 'Sergio'.
*        out->write( 'Hola Sergio' ).
*
*      ELSEIF lv_nombre = 'daniel'.
*        out->write( 'Hola Daniel' ).
*
*      ENDIF.
*
*    ELSE. " longitud < 6
*
*      out->write( 'Hola Pedro' ).
*      lv_nombre = to_upper( lv_nombre ).
*      out->write( |Nombre en mayúsculas: { lv_nombre }| ).
*
*    ENDIF.



  ENDMETHOD.
ENDCLASS.
