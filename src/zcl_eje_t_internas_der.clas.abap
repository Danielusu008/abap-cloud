CLASS zcl_eje_t_internas_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EJE_T_INTERNAS_DER IMPLEMENTATION.


 METHOD if_oo_adt_classrun~main.
     " 1. Definimos un tipo de estructura para guardar los datos de los libros
    TYPES: BEGIN OF ty_libro,
             titulo   TYPE string,
             autor    TYPE string,
             paginas  TYPE i,
           END OF ty_libro.

    " 2. Declaramos una tabla interna y una estructura temporal
    TYPES: ty_tabla_libros TYPE STANDARD TABLE OF ty_libro WITH EMPTY KEY.

    DATA: lt_libros TYPE ty_tabla_libros,
          ls_libro  TYPE ty_libro.

    " 3. Insertamos tres libros en posiciones específicas
    ls_libro = VALUE #( titulo = 'El principito' autor = 'Antoine de Saint-Exupéry' paginas = 96 ).
    INSERT ls_libro INTO lt_libros INDEX 1.

    ls_libro = VALUE #( titulo = 'Don Quijote' autor = 'Miguel de Cervantes' paginas = 863 ).
    INSERT ls_libro INTO lt_libros INDEX 2.

    ls_libro = VALUE #( titulo = 'Cien años de soledad' autor = 'Gabriel García Márquez' paginas = 417 ).
    INSERT ls_libro INTO lt_libros INDEX 2. "Se insertará en el medio

    " 4. Recorremos la tabla y analizamos la longitud de cada libro
    LOOP AT lt_libros INTO ls_libro.

      IF ls_libro-paginas < 150.
        out->write( |Libro corto: { ls_libro-titulo }| ).

      ELSEIF ls_libro-paginas > 500.
        out->write( |Libro largo: { ls_libro-titulo }| ).

      ELSE.
        out->write( |Libro estándar: { ls_libro-titulo }| ).
      ENDIF.

    ENDLOOP.

    " 5. Mostramos la tabla completa
    out->write( data = lt_libros name = 'Catálogo completo de libros' ).
ENDMETHOD.
ENDCLASS.
