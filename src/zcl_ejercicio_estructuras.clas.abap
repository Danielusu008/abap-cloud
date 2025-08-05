CLASS zcl_ejercicio_estructuras DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejercicio_estructuras IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


" Declaramos un tipo de estructura anidada para representar naves espaciales
types: BEGIN OF ty_nave,

         " Subestructura: información general de la nave
         BEGIN OF datos_generales,
           nombre      TYPE string,     " Nombre de la nave
           modelo      TYPE string,     " Modelo identificador
           pais_origen TYPE string,     " País de origen de la nave
         END OF datos_generales,

         " Subestructura: características técnicas
         BEGIN OF especificaciones,
           velocidad_max TYPE i,         " Velocidad máxima en km/h
           autonomia     TYPE i,         " Autonomía de vuelo en horas
         END OF especificaciones,

         " Subestructura: estado de la misión actual
         BEGIN OF estado_mision,
           mision            TYPE string, " Descripción de la misión
           nivel_combustible TYPE i,      " Porcentaje de combustible (0 a 100)
         END OF estado_mision,

       END OF ty_nave.                    " Fin de la definición del tipo de estructura

" Declaramos tres variables estructurales para las naves
DATA: ls_nave1 TYPE ty_nave,
      ls_nave2 TYPE ty_nave,
      lv_nave4 type ty_nave,
      ls_nave3 TYPE ty_nave.

" Inicializamos los valores de cada nave con VALUE #( ) usando subestructuras
*ls_nave1 = VALUE #(
*  datos_generales  = VALUE #( nombre = 'Odisea I' modelo = 'X-45' pais_origen = 'EEUU' )
*  especificaciones = VALUE #( velocidad_max = 26000 autonomia = 1200 )
*  estado_mision    = VALUE #( mision = 'Exploración de Marte' nivel_combustible = 80 )
*).

"he puesto comentada las lineas de arriba para que tengais los dos tipos de forma de asignacion de valores para las estrucutras.
ls_nave1-datos_generales-nombre = 'Odisea I'.
ls_nave1-datos_generales-modelo = 'X-45'.
ls_nave1-datos_generales-pais_origen = 'EEUU'.

ls_nave1-especificaciones-velocidad_max = 26000.
ls_nave1-especificaciones-autonomia = 1200.

ls_nave1-estado_mision-mision = 'Exploración de Marte'.
ls_nave1-estado_mision-nivel_combustible = 80.



ls_nave2 = VALUE #(
  datos_generales  = VALUE #( nombre = 'Estrella Roja'  pais_origen = 'Rusia' )
  especificaciones = VALUE #( velocidad_max = 27000 autonomia = 900 )
  estado_mision    = VALUE #( mision = 'Órbita terrestre' nivel_combustible = 15 )
).

" para que tengais el ejemplo he creado estas dos lineas en las forzamos un nuevo valor a el campo de ls_nave2-datos_generales-nombre y añadimos
"un valor por primera vez al campo ls_nave2-datos_generales-modelo porque se nos "olvido" ponerlo en la declaracion de valores de ls_nave2
ls_nave2-datos_generales-nombre = 'Estrella azul'.
ls_nave2-datos_generales-modelo = 'TRX6000'.




ls_nave3 = VALUE #(
  datos_generales  = VALUE #( nombre = 'Andrómeda' modelo = 'Q-99' pais_origen = 'Japón' )
  especificaciones = VALUE #( velocidad_max = 24000 autonomia = 1500 )
  estado_mision    = VALUE #( mision = 'Colonia en Marte' nivel_combustible = 76 )
).

" Variables auxiliares para facilitar la lectura y análisis de cada nave
DATA: lv_nombre TYPE string,
      lv_mision TYPE string.

" ====================================
" Evaluación de condiciones para nave 1
" ====================================

lv_nombre = ls_nave1-datos_generales-nombre.
lv_mision = to_lower( ls_nave1-estado_mision-mision ).

IF ls_nave1-datos_generales-pais_origen <> 'EEUU' AND ls_nave1-especificaciones-velocidad_max > 25000.

  out->write( |{ lv_nombre }: Nave extranjera de alta velocidad| ).
ENDIF.

IF ls_nave1-especificaciones-autonomia < 1000 OR
   ls_nave1-estado_mision-nivel_combustible < 20.
  out->write( |{ lv_nombre }: Revisión urgente necesaria| ).
ENDIF.

IF lv_mision CP '*marte*' AND
   ls_nave1-estado_mision-nivel_combustible >= 75.
  out->write( |{ lv_nombre }: Misión a Marte en condiciones óptimas| ).
ENDIF.

" Evaluación para nave 2
lv_nombre = ls_nave2-datos_generales-nombre.
lv_mision = to_lower( ls_nave2-estado_mision-mision ).

IF ls_nave2-datos_generales-pais_origen <> 'EEUU' AND
   ls_nave2-especificaciones-velocidad_max > 25000.
  out->write( |{ lv_nombre }: Nave extranjera de alta velocidad| ).
ENDIF.

IF ls_nave2-especificaciones-autonomia < 1000 OR
   ls_nave2-estado_mision-nivel_combustible < 20.
  out->write( |{ lv_nombre }: Revisión urgente necesaria| ).
ENDIF.

IF lv_mision CP '*marte*' AND
   ls_nave2-estado_mision-nivel_combustible >= 75.
  out->write( |{ lv_nombre }: Misión a Marte en condiciones óptimas| ).
ENDIF.

" Evaluación para nave 3
lv_nombre = ls_nave3-datos_generales-nombre.
lv_mision = to_lower( ls_nave3-estado_mision-mision ).

IF ls_nave3-datos_generales-pais_origen <> 'EEUU' AND
   ls_nave3-especificaciones-velocidad_max > 25000.
  out->write( |{ lv_nombre }: Nave extranjera de alta velocidad| ).
ENDIF.

IF ls_nave3-especificaciones-autonomia < 1000 OR
   ls_nave3-estado_mision-nivel_combustible < 20.
  out->write( |{ lv_nombre }: Revisión urgente necesaria| ).
ENDIF.

IF lv_mision CP '*marte*' AND
   ls_nave3-estado_mision-nivel_combustible >= 75.
  out->write( |{ lv_nombre }: Misión a Marte en condiciones óptimas| ).
ENDIF.
out->write( |\n | ).
out->write( ls_nave1 ).
out->write( |\n | ).
out->write( ls_nave2 ).
out->write( |\n | ).
out->write( ls_nave3 ).
  ENDMETHOD.
ENDCLASS.
