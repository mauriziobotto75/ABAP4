Program : ZZEMP_ASSINGMENT

INCLUDE ZZEMP_ASSIGNMENT_TOP                    .    " global Data

* INCLUDE ZZEMP_ASSIGNMENT_O01                    .  " PBO-Modules
* INCLUDE ZZEMP_ASSIGNMENT_I01                    .  " PAI-Modules
* INCLUDE ZZEMP_ASSIGNMENT_F01                    .  " FORM-Routines


INCLUDE zzemp_assingment_pbo.

INCLUDE zzemp_assingment_pai.

INCLUDE zzemp_assingment_fr.





















************************************
INCLUDE ZZEMP_ASSIGNMENT_TOP

data : gs_ass type ZZEMP_ASS,
       gs_emp_master type ZZEMP_MASTER.

*****************************************

ZZEMP_ASSINGMENT_PBO

MODULE STATUS_0100 OUTPUT.
  SET PF-STATUS 'PF1'.
  SET TITLEBAR 'T1'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0200 OUTPUT.
  SET PF-STATUS 'PF2'.
  SET TITLEBAR 'T2'.
ENDMODULE.

******************************************

ZZEMP_ASSINGMENT_PAI

MODULE USER_COMMAND_0100 INPUT.

    case sy-ucomm.

    when 'BACK' or 'EXIT' or 'CANCEL'.
       set SCREEN 0.
    when 'ENT' or 'ENTER' or ' '.
      if GS_ASS-EMPID is NOT INITIAL.

   select SINGLE * from zzemp_master into CORRESPONDING FIELDS OF GS_EMP_MASTER
   WHERE empid = GS_ASS-EMPID.

    CONCATENATE GS_EMP_MASTER-TITLE
                GS_EMP_MASTER-FIRST_NAME
                GS_EMP_MASTER-LAST_NAME INTO GS_ASS-EMP_NAME SEPARATED BY SPACE.

      else.
       clear : gs_ass-EMP_NAME.
      endif.
    when 'SAVE'.
       perform save.
    endcase.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0200 INPUT.

   case sy-ucomm.

   when ' '  or 'ENTER' or 'ENT' or 'GET'.
      if gs_ass-id is NOT INITIAL.

      select SINGLE * from ZZEMP_ASS into CORRESPONDING FIELDS OF GS_ASS
      where id = gs_ass-id.

         call SCREEN 100.
      else.
        message 'Enter the task ID' TYPE 'S'.
      endif.
   when 'BACK' or 'EXIT'.
     set SCREEN 0.
   endcase.

    clear : sy-ucomm.
ENDMODULE.

********************************
ZZEMP_ASSINGMENT_FR

FORM SAVE .

   IF GS_ASS-ID IS INITIAL.

   CALL FUNCTION 'NUMBER_GET_NEXT'
     EXPORTING
       NR_RANGE_NR                   = '01'
       OBJECT                        = 'ZZEMP'
*      QUANTITY                      = '1'
*      SUBOBJECT                     = ' '
*      TOYEAR                        = '0000'
*      IGNORE_BUFFER                 = ' '
    IMPORTING
      NUMBER                        = GS_ASS-ID
*      QUANTITY                      =
*      RETURNCODE                    =
    EXCEPTIONS
      INTERVAL_NOT_FOUND            = 1
      NUMBER_RANGE_NOT_INTERN       = 2
      OBJECT_NOT_FOUND              = 3
      QUANTITY_IS_0                 = 4
      QUANTITY_IS_NOT_1             = 5
      INTERVAL_OVERFLOW             = 6
      BUFFER_OVERFLOW               = 7
      OTHERS                        = 8
             .
   IF SY-SUBRC <> 0.
* Implement suitable error handling here
   ENDIF.

     gs_ass-CREATEDBY  = sy-uname.
     gs_ass-CREATEDON  = sy-datum.
     gs_ass-time       = sy-uzeit.


   ENDIF.


   modify ZZEMP_ASS from gs_ass.
   message 'Record created suuccessfully' TYPE 'S'.
   set SCREEN 0.


ENDFORM.
