CLASS zcl_09_account_der DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.

    METHODS: set_iban IMPORTING iban TYPE string,
      get_iban EXPORTING iban TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA iban TYPE string value 'aljfdlas '.

ENDCLASS.



CLASS zcl_09_account_der IMPLEMENTATION.
  METHOD get_iban.

    iban = me->iban.
  ENDMETHOD.



  METHOD set_iban.

    me->iban = iban.

  ENDMETHOD.

ENDCLASS.
