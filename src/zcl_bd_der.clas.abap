CLASS zcl_bd_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bd_der IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*--- 1) Marcas
    DATA lt_brands TYPE STANDARD TABLE OF ztab_rent_der.
    lt_brands = VALUE #(
      ( marca = 'TESLA'   url = 'https://tesla.com'   )
      ( marca = 'VW'      url = 'https://vw.com'      )
      ( marca = 'FORD'    url = 'https://ford.com'    )
      ( marca = 'TOYOTA'  url = 'https://toyota.com'  )
      ( marca = 'RENAULT' url = 'https://renault.com' )
    ).
    MODIFY ztab_rent_der FROM TABLE @lt_brands.

*--- 2) Coches
    DATA lt_cars TYPE STANDARD TABLE OF ztab_rentcar_der.
    lt_cars = VALUE #(
      ( matricula = 'AA1234AA'  marca = 'TESLA'
        modelo = 'Model 3'        color = 'NEGRO'   motor = 'EV'
        potencia = '258.00'       und_potencia = 'KW'
        combustible = 'ELECTRICO' consumo = '15.20'
        puertas = 4               precio = '37990.00' moneda = 'EUR'
        alquilado = 'X'           alq_desde = '20250601' alq_hasta = '20250701' )

      ( matricula = 'BB4567BB'  marca = 'VW'
        modelo = 'Golf'          color = 'BLANCO'  motor = '1.5 TSI'
        potencia = '96.00'       und_potencia = 'KW'
        combustible = 'GASOLINA' consumo = '5.40'
        puertas = 5               precio = '21990.00' moneda = 'EUR'
        alquilado = ' '           alq_desde = '00000000' alq_hasta = '00000000' )

      ( matricula = 'CC8901CC'  marca = 'FORD'
        modelo = 'Focus'         color = 'AZUL'    motor = '1.0 EcoBoost'
        potencia = '92.00'       und_potencia = 'KW'
        combustible = 'GASOLINA' consumo = '5.00'
        puertas = 5               precio = '19990.00' moneda = 'EUR'
        alquilado = 'X'           alq_desde = '20250515' alq_hasta = '20250615' )

      ( matricula = 'DD2345DD'  marca = 'TOYOTA'
        modelo = 'Corolla Hybrid' color = 'ROJO'   motor = 'HYBRID'
        potencia = '90.00'        und_potencia = 'KW'
        combustible = 'HIBRIDO'   consumo = '4.00'
        puertas = 5               precio = '23990.00' moneda = 'EUR'
        alquilado = ' '           alq_desde = '00000000' alq_hasta = '00000000' )

      ( matricula = 'EE6789EE'  marca = 'RENAULT'
        modelo = 'Clio'          color = 'GRIS'    motor = 'TCe 90'
        potencia = '67.00'       und_potencia = 'KW'
        combustible = 'GASOLINA' consumo = '5.10'
        puertas = 5               precio = '16990.00' moneda = 'EUR'
        alquilado = 'X'           alq_desde = '20250401' alq_hasta = '20250430' )
    ).
    MODIFY ztab_rentcar_der FROM TABLE @lt_cars.

*--- 3) Clientes (referencian matrícula)
    DATA lt_cust TYPE STANDARD TABLE OF ztab_customer.
    lt_cust = VALUE #(
      ( doc_id = 'D001' matricula = 'AA1234AA'
        fecha_inicio = '20250601' fecha_fin = '20250701'
        nombres = 'Laura' apellidos = 'Santos' email = 'laura.santos@example.com'
        cntr_type = 'MENSUAL' )
      ( doc_id = 'D002' matricula = 'BB4567BB'
        fecha_inicio = '00000000' fecha_fin = '00000000'
        nombres = 'Javier' apellidos = 'Gomez' email = 'j.gomez@example.com'
        cntr_type = 'LIBRE' )
      ( doc_id = 'D003' matricula = 'CC8901CC'
        fecha_inicio = '20250515' fecha_fin = '20250615'
        nombres = 'Elena' apellidos = 'Prieto' email = 'elena.prieto@example.com'
        cntr_type = 'MENSUAL' )
      ( doc_id = 'D004' matricula = 'DD2345DD'
        fecha_inicio = '00000000' fecha_fin = '00000000'
        nombres = 'Raul' apellidos = 'Iglesias' email = 'raul.iglesias@example.com'
        cntr_type = 'LIBRE' )
      ( doc_id = 'D005' matricula = 'EE6789EE'
        fecha_inicio = '20250401' fecha_fin = '20250430'
        nombres = 'Nuria' apellidos = 'Lopez' email = 'n.lopez@example.com'
        cntr_type = 'MENSUAL' )
    ).
    MODIFY ztab_customer FROM TABLE @lt_cust.

    COMMIT WORK AND WAIT.

    out->write( |Seed completado: { lines( lt_brands ) } marcas, { lines( lt_cars ) } coches, { lines( lt_cust ) } clientes.| ).
  ENDMETHOD.
ENDCLASS.
