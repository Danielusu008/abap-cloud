CLASS zcl_estructuras_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ESTRUCTURAS_DER IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "forma 1 declaracion de estructura
    "declaracion del tipo para la estructura
    TYPES: BEGIN OF ty_persona, "ty_persona: seria el nombre creado para nuestro nuevo tipo

             nombre TYPE char40,
             edad   TYPE numc3,
             email  TYPE /dmo/email_address,

           END OF ty_persona.



    DATA ls_persona TYPE ty_persona. "declaracion de la estructura en si misma

    ls_persona-nombre = 'Pedro'.
    ls_persona-edad = 20.
    ls_persona-email = 'daniel.elviraruiz@experis.es'.

*
*    out->write( ls_persona ).
*    out->write( |\n| ).

    """""""""""""""""""""""""""""""""""""""""""""""""""
    "forma 2 declaracion de una estructura


    DATA(ls_persona2) = VALUE ty_persona( nombre = 'Daniel' edad = 20 email = 'daniel.elviraruiz@experis.es' ).



*    out->write( ls_persona2 ).


    """""""""""""""""""""""""
    "forma 3 declaracion de una estructura y tipo DE GOLPE.


    DATA: BEGIN OF ls_empleado,
            nombre TYPE string VALUE 'Laura',
            id     TYPE i,
            email  TYPE  /dmo/email_address,
          END OF ls_empleado.


*
*    out->write( |\n| ).
*    out->write( ls_empleado ).



    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "TIPOS DE ESTRUCTURAS

    "estructura simple
    DATA: BEGIN OF ls_empleado2,
            nombre TYPE string VALUE 'Laura',
            id     TYPE i,
            email  TYPE  /dmo/email_address,
          END OF ls_empleado2.

    "estructura anidada

*    DATA:BEGIN OF ls_empl_info,
*
*           BEGIN OF info,
*             id       TYPE i VALUE 1234,
*             nombre   TYPE string VALUE 'Pedro',
*             apellido TYPE string VALUE  'Elvira',
*           END OF info,
*
*           BEGIN OF direccion,
*             ciudad TYPE string VALUE 'Madrid',
*             calle  TYPE string VALUE 'c. norfeo',
*             pais   TYPE string VALUE  'España',
*           END OF direccion,
*
*           BEGIN OF puesto,
*             departamento TYPE string VALUE 'IT',
*             sueldo       TYPE p DECIMALS 2 VALUE '2000.20',
*
*           END OF puesto,
*
*         END OF ls_empl_info.

    " out->write( ls_empl_info ).    " para imprimir todo el contenido de la estructura
    " out->write( ls_empl_info-direccion-calle ).  " para imprimir un unico campo de la estructura
    "out->write( data = ls_empl_info name = 'informacion de empleado'). " para imprimir toda la estructura con un mensaje inform

*    "estructura profunda.
*
*    TYPES: BEGIN OF ty_flights,
*             flight_date   TYPE /dmo/flight-flight_date,
*             price         TYPE /dmo/flight-price,
*             currency_code TYPE /dmo/flight-currency_code,
*           END OF ty_flights.
*
*
*DATA: BEGIN OF ls_flight_info,
*      carrier type /dmo/flight-carrier_id VALUE 'AA',
*      connid type /dmo/flight-connection_id value '0018',
*      lt_flights type table of ty_flights WITH EMPTY KEY , " hace referencia tanto al tipo creado en el types "ty_flights como a la tabla de base de datos
*
*      end of LS_FLIGHT_INFO.
*
*
*
* SELECT *
* from /dmo/flight
* where carrier_id = 'AA'
* into corresponding fields of table @ls_flight_info-lt_flights.
*
*
* out->write( data = ls_flight_info name = 'ls_flight_info').
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Añadir datos a las estructuras

*
*    TYPES: BEGIN OF ty_flights,
*             flight_date   TYPE /dmo/flight-flight_date,
*             price         TYPE /dmo/flight-price,
*             currency_code TYPE /dmo/flight-currency_code,
*           END OF ty_flights.
*
*
*    DATA: BEGIN OF ls_flight_info,
*            carrier    TYPE /dmo/flight-carrier_id value 'AA',
*            connid     TYPE /dmo/flight-connection_id ,
*            ls_flights TYPE  ty_flights,  " diferencia con el ejemplo anterior
*
*          END OF ls_flight_info.
*

*    ls_flight_info-carrier = ' '.
*    ls_flight_info-connid  = '0022'.
*    ls_flight_info-ls_flights-flight_date = cl_abap_context_info=>get_system_date(  ).
*    ls_flight_info-ls_flights-currency_code = 'USD'.
*    ls_flight_info-ls_flights-price = '200'.
*    out->write( |\n| ).
    "out->write( data = ls_flight_info name = 'ls_flight_info' ).


    "para las estructuras anidadas

    DATA:BEGIN OF ls_empl_info,

           BEGIN OF info,
             id       TYPE i,
             nombre   TYPE string,
             apellido TYPE string,
           END OF info,

           BEGIN OF direccion,
             ciudad TYPE string,
             calle  TYPE string,
             pais   TYPE string,
           END OF direccion,

           BEGIN OF puesto,
             departamento TYPE string,
             sueldo       TYPE p DECIMALS 2,

           END OF puesto,

         END OF ls_empl_info.

    ls_empl_info = VALUE #(
                           info = VALUE #( id = 1234 nombre ='Juan' apellido = 'Martinez' )
                           direccion = VALUE #( calle = 'Gran via' ciudad = 'Madrid' pais = 'España ')
                           puesto = VALUE #( departamento = 'Finanzas' sueldo = '2000.00')
                         ).


"    out->write( data = ls_empl_info name = 'ls_empl_info' ).


    """""""""""""""""""""""""""""""""""
    " introducir datos en estructuras profundas.



    TYPES: BEGIN OF ty_flights,
             flight_date   TYPE /dmo/flight-flight_date,
             price         TYPE /dmo/flight-price,
             currency_code TYPE /dmo/flight-currency_code,
           END OF ty_flights.


    DATA: BEGIN OF ls_flight_info,
            carrier    TYPE /dmo/flight-carrier_id VALUE 'AA',
            connid     TYPE /dmo/flight-connection_id VALUE '0018',
            ls_flights TYPE  ty_flights,

          END OF ls_flight_info.

    ls_flight_info = VALUE #(
                                carrier = 'SP'
                                connid =  '0035'
                                ls_flights = VALUE #( flight_date = '20250731'
                                                      currency_code = 'EUR'
                                                      price  = '200'           )  ).


"out->write( data = ls_flight_info name = 'ls_flight_info' ).
""""""""""""""""""""""""""""""""""""2
" declaracion de "todo lo necesario" para generar una estructura de forma lineal
"DATA(ls_flight2) = value ty_flights( currency_code = 'USE' flight_date = '20250731'  ).

"out->write( data = ls_flight2 name = 'ls_flight2' ).

""""""""""""""""""""""""""""
"Clear: Se usan para eliminar los datos de una estructura en tiempo de ejecucion, ya sea para aplicarlo dentro de
"un componente de forma individual o para la estructura completea.

*select SINGLE from /dmo/flight
*FIELDS *
*where carrier_id = 'LH'
*into @data(ls_flight2).
*
*
*out->write(  data = ls_flight2  name = 'ls_flight2' ).
*
*Clear ls_flight2-connection_id.
*out->write(  data = ls_flight2  name = 'ls_flight2' ).
*
*clear ls_flight2.
*out->write(  data = ls_flight2  name = 'ls_flight2' ).
*
""""""""""""""""""""""""""""""""""""""2222
"includes
" Estructura reutilizable
" Definimos una estructura para el cliente con nombre y edad
TYPES: BEGIN OF ty_customer,
         name TYPE string,  " Nombre del cliente
         age  TYPE i,       " Edad del cliente
       END OF ty_customer.

" Definimos una estructura para el pedido que incluye:
" - un ID de pedido
" - una subestructura de cliente (ty_customer)
" - la fecha del pedido
TYPES: BEGIN OF ty_order,
         order_id    TYPE string,      " Identificador del pedido
         customer    TYPE ty_customer, " Datos del cliente (estructura anidada)
         order_date  TYPE d,           " Fecha del pedido
       END OF ty_order.

" Creamos una variable 'order' con la estructura del tipo ty_order
DATA: order TYPE ty_order.

" Asignamos valores a los campos de la subestructura 'customer'
order-customer-name = 'Daniel'.    " Asignamos nombre al cliente
order-customer-age  = 32.          " Asignamos edad al cliente

" Asignamos valores a los campos propios de la estructura principal
order-order_id      = 'A001'.      " ID del pedido
order-order_date    = sy-datum.    " Fecha actual del sistema

" Imprimimos todo el contenido de la estructura 'order' en consola
out->write( order ).               " Muestra todos los campos del pedido y del cliente









      ENDMETHOD.
ENDCLASS.
