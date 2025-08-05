CLASS zcl_if_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_if_der IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*Desarrollar un programa que cuente el número total de vocales presentes en una cadena de
*texto utilizando estructuras de control básicas y funciones de manipulación de cadenas.
*Teneis que crear un programa que recorra letra por letra una cadena de texto y cuente cuántas vocales contiene.
*Para ello deberás usar un bucle DO, la función to_lower para normalizar las letras, y la sentencia CHECK para
*filtrar solo aquellas que sean vocales.

    " Declaramos una cadena con un texto
    DATA lv_texto TYPE string VALUE 'El perro corre por el prado'.

    " Inicializamos un contador para las vocales
    DATA(lv_contador) = 0.
    DATA(lv_contador1) = 0.
    " Variable para ir extrayendo letra por letra
    DATA lv_letra TYPE c LENGTH 1.

    " Bucle que se repite tantas veces como letras tenga el texto
    DO strlen( lv_texto ) TIMES.


      " Extraemos una letra por cada vuelta del bucle
      lv_letra = lv_texto+lv_contador1." sy-index empieza en 1
       lv_contador1 = lv_contador1 + 1.

      " Convertimos la letra a minúscula para que A=a, E=e, etc.
      lv_letra = to_lower( lv_letra ).

      " Usamos CHECK para continuar solo si es una vocal
      CHECK lv_letra = 'a' OR lv_letra = 'e' OR lv_letra = 'i' OR lv_letra = 'o' OR lv_letra = 'u'.
      " Si ha pasado el CHECK, aumentamos el contador
      lv_contador = lv_contador + 1.

    ENDDO.

    " Mostramos el resultado
    out->write( |Número de vocales: { lv_contador }| ).


DATA ls_flight type /dmo/flight.




  ENDMETHOD.


ENDCLASS.
