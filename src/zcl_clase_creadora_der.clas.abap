CLASS zcl_clase_creadora_der DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  "Definiciones:
  "Instancia: Objeto creado a partir de una clase

  "Atributos de dependencia de instacia y los estaticos :

  "Atributos de dependencia de instancia-> Depende de la instancia de la clase, el contenido es especifico para
  "cada objeto. Se declaran usando la sentencia data

  "resumen - "" son variables que pertenecen a cada objeto, no a la clase. Cada instancia tiene su propia copia

  "Atributos estaticos->  El contenido de los atributos estaticos definen el estado de la clase y es valido para todas las instancias de la clase,
*            se declaran usando class-data.  Son accesible desde todo el entorno de ejecucion de la clase. Todos los objetos de una clase pueden acceder a sus atributos estaticos.
*            Si se cambia un atributo estatico en un objeto, el cambio es visible en todos los demas objetos de la clase.
*
*            resumen- Variables de la clase, NO del objeto. Hay una sola copia por clase en la sesion. todas las instancias lo comparten


  " Metodos estaticos o de instancia
  "los metodos estaticos-> No dependen de la instancia
  "los metodos de instancia-> Dependen de cada instancia que se va a realizar en el contenxto de la memoria de ejecucion

  "  los metodos de instancia ->
  "  los metodos estaticos  =>

  "estatico NO tiene acceso a la instancia
  "instancia tiene acceso al estatico

  " Todos los atributos y metodos son publicos y accesibles
  PUBLIC SECTION.
    "---------------------------------------- public section-------------------------------------------------

    TYPES:BEGIN OF ty_address,
            country     TYPE string,
            city        TYPE string,
            postal_code TYPE string,
            region      TYPE string,
            street      TYPE string,
            numbre      TYPE string,
          END OF ty_address,
          tty_address TYPE TABLE OF ty_address.

    DATA lt_prueba TYPE tty_address.
    DATA ls_prueba TYPE ty_address.

    constants: BEGIN OF cs_currency,
               usd type c LENGTH 3 VALUE 'USD',
               eur type c LENGTH 3 value 'EUR',
             end of CS_CURRENCY.

    METHODS set_address IMPORTING it_address TYPE tty_address.

    CLASS-DATA currency TYPE c LENGTH 3.
    DATA region TYPE string.

    METHODS metodo_optional_ejemplo
      IMPORTING iv_client   TYPE string  OPTIONAL       " los optional se ponen para que desde la "clase objto" no sea necesario introducir datos en los campos que de por si lo son( importing y changing)
                iv_location TYPE string  OPTIONAL
      EXPORTING ev_status   TYPE string
      CHANGING  cv_process  TYPE string OPTIONAL.

    METHODS set_client
      IMPORTING iv_client   TYPE string
                iv_location TYPE string
      EXPORTING ev_status   TYPE string
      CHANGING  cv_process  TYPE string .

    METHODS get_client
      EXPORTING ev_client TYPE string.

    CLASS-METHODS:
      set_cntr_type IMPORTING iv_cntr_type TYPE string,
      get_cntr_type EXPORTING ev_cntr_type TYPE string.

    METHODS: get_client_name IMPORTING iv_client_id TYPE string RETURNING VALUE(rv_client_name) TYPE string.
    CLASS-DATA company TYPE string READ-ONLY. " con el read-only, solo se puede leer el codigo desde otras clases, NO permitie modificarlo.

    METHODS set_sales_org IMPORTING sales_org TYPE string.
    METHODS get_sales_org EXPORTING sales_org TYPE string.

CLASS-METHODS get_instance EXPORTING er_instance TYPE REF TO zcl_clase_creadora_der.





    "---------------------------------------- PROTECTED section-------------------------------------------------
  PROTECTED SECTION.                                                               "Es solo accesible para esta clase y las clases hijas

    DATA creation_date TYPE sydate.                                                "Atributo instancia ( se ha creado con el DATA )

    "---------------------------------------- PRIVATE section-------------------------------------------------
  PRIVATE SECTION.                                                                 "Es accesible solo para esta clase y as clases "friends"

    DATA client TYPE string value 'pepito'.                                                       "Atributo instancia ( se ha creado con el DATA )
    CLASS-DATA cntr_type TYPE string.
    DATA sales_org TYPE string.
                                           "Atributo estatico ( se ha creado con el DATA )
    "----------------------------------------End PRIVATE section-------------------------------------------------
ENDCLASS.



CLASS zcl_clase_creadora_der IMPLEMENTATION.



  METHOD set_client.                                                               "Desarrollo de la logica de la funcion/metodo set_cliente
    me->client = iv_client .
    ev_status = 'Ok'.
    cv_process = 'Started'.
    company = 'Experis academy'.
  ENDMETHOD.

  METHOD get_client.                                                               "Desarrollo de la logica de la funcion/metodo get_cliente
    ev_client = me->client.

  ENDMETHOD.

  METHOD get_cntr_type.                                                            "Desarrollo de la logica de la funcion/metodo get_cntr_type
    ev_cntr_type = cntr_type.

  ENDMETHOD.

  METHOD set_cntr_type.
    cntr_type = iv_cntr_type.                                                      "Desarrollo de la logica de la funcion/metodo set_cntr_type

  ENDMETHOD.



  METHOD get_client_name.
    CASE iv_client_id.
      WHEN '01'.
        rv_client_name = 'client name  Daniel '.
      WHEN '02'.
        rv_client_name = 'Client name Pedro'.
    ENDCASE.
  ENDMETHOD.

  METHOD set_address.



  ENDMETHOD.

  METHOD get_sales_org.
    sales_org = me->sales_org.
  ENDMETHOD.

  METHOD set_sales_org.
    me->sales_org = sales_org.
    me->set_address( it_address = VALUE #( ( country = 'ES' ) ) ).
  ENDMETHOD.

  METHOD metodo_optional_ejemplo.

  ENDMETHOD.

  METHOD get_instance.
    er_instance = new zcl_clase_creadora_der(  ).
  ENDMETHOD.

ENDCLASS.
