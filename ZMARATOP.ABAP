 *&---------------------------------------------------------------------*
*& Module Pool      Z1015035_MPP_MARA_
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZMARATOP                                .    " Global Data
START-OF-SELECTION.
CALL SCREEN 100.

* INCLUDE ZMARAO01                                .  " PBO-Modules
* INCLUDE ZMARAI01                                .  " PAI-Modules
* INCLUDE ZMARAF01                                .  " FORM-Routines
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
  CASE SY-UCOMM.
    WHEN 'FC_1'.
      PERFORM GET_DATA.
    WHEN 'FC2'.
      LEAVE PROGRAM.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.


---INCLUDE----

*&---------------------------------------------------------------------*
*& Include ZMARATOP                                 - Module Pool      Z1015035_MPP_MARA_
*&---------------------------------------------------------------------*
PROGRAM Z1015035_MPP_MARA_.
TABLES: MARA.
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA .
  SELECT
    SINGLE
    MATNR
    ERSDA
    CREATED_AT_TIME
    ERNAM
    MTART
    MATKL
    FROM MARA INTO CORRESPONDING FIELDS OF MARA WHERE MATNR = MARA-MATNR.

ENDFORM.
