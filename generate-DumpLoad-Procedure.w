&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

{ DataDigger.i }

/* Parameters Definitions ---                                           */

&IF DEFINED(UIB_IS_RUNNING) = 0 &THEN
  DEFINE INPUT PARAMETER pcDatabase AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER pcTable    AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER TABLE FOR ttField.
  DEFINE INPUT PARAMETER TABLE FOR ttIndex.
&ELSE
  DEFINE VARIABLE pcDatabase AS CHARACTER   NO-UNDO INITIAL 'sports'.
  DEFINE VARIABLE pcTable    AS CHARACTER   NO-UNDO INITIAL 'sales-rep'.
  
  DEFINE VARIABLE hLib AS HANDLE NO-UNDO.
  RUN datadiggerlib.p PERSISTENT SET hLib.
  THIS-PROCEDURE:ADD-SUPER-PROCEDURE(hLib,SEARCH-TARGET).
  
  RUN fillTT.
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frMain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-5 RECT-6 edDefinition rsDumpLoad ~
cbIndent tgLowerCase tgIncludeDb tgDelete tgLoadInChunks tgDisableTriggers ~
btnSave 
&Scoped-Define DISPLAYED-OBJECTS edDefinition rsDumpLoad cbIndent ~
tgLowerCase tgIncludeDb tgDelete tgLoadInChunks tgDisableTriggers 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnSave 
     LABEL "&Save program" 
     SIZE-PIXELS 180 BY 24.

DEFINE VARIABLE cbIndent AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "2 Spaces","2",
                     "3 Spaces","3",
                     "4 Spaces","4",
                     "Tab","Tab"
     DROP-DOWN-LIST
     SIZE-PIXELS 80 BY 21 NO-UNDO.

DEFINE VARIABLE edDefinition AS CHARACTER 
     VIEW-AS EDITOR NO-WORD-WRAP SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL LARGE
     SIZE-PIXELS 700 BY 340
     FONT 0 NO-UNDO.

DEFINE VARIABLE rsDumpLoad AS CHARACTER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Dump", "Dump",
"Load", "Load"
     SIZE-PIXELS 125 BY 25 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE-PIXELS 180 BY 73.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE-PIXELS 180 BY 48.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE-PIXELS 180 BY 130.

DEFINE VARIABLE tgDelete AS LOGICAL INITIAL no 
     LABEL "&Delete record" 
     VIEW-AS TOGGLE-BOX
     SIZE-PIXELS 160 BY 17 TOOLTIP "add delete statement" NO-UNDO.

DEFINE VARIABLE tgDisableTriggers AS LOGICAL INITIAL no 
     LABEL "Disable Load &Triggers" 
     VIEW-AS TOGGLE-BOX
     SIZE-PIXELS 160 BY 17 TOOLTIP "disable load triggers" NO-UNDO.

DEFINE VARIABLE tgIncludeDb AS LOGICAL INITIAL no 
     LABEL "Include DB Name" 
     VIEW-AS TOGGLE-BOX
     SIZE-PIXELS 165 BY 17 TOOLTIP "include DB name in the code" NO-UNDO.

DEFINE VARIABLE tgLoadInChunks AS LOGICAL INITIAL no 
     LABEL "Load In &Chunks" 
     VIEW-AS TOGGLE-BOX
     SIZE-PIXELS 160 BY 17 TOOLTIP "Load data in chunks of 100 records" NO-UNDO.

DEFINE VARIABLE tgLowerCase AS LOGICAL INITIAL no 
     LABEL "Keywords in &Lower Case" 
     VIEW-AS TOGGLE-BOX
     SIZE-PIXELS 165 BY 17 TOOLTIP "use lower case for keywords" NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frMain
     edDefinition AT Y 5 X 205 NO-LABEL WIDGET-ID 2
     rsDumpLoad AT Y 13 X 30 NO-LABEL WIDGET-ID 78
     cbIndent AT Y 44 X 60 COLON-ALIGNED NO-LABEL WIDGET-ID 50
     tgLowerCase AT Y 75 X 25 WIDGET-ID 84
     tgIncludeDb AT Y 100 X 25 WIDGET-ID 86
     tgDelete AT Y 175 X 30 WIDGET-ID 10
     tgLoadInChunks AT Y 245 X 30 WIDGET-ID 12
     tgDisableTriggers AT Y 265 X 30 WIDGET-ID 76
     btnSave AT Y 320 X 15 WIDGET-ID 36
     "Load" VIEW-AS TEXT
          SIZE-PIXELS 50 BY 13 AT Y 220 X 25 WIDGET-ID 74
     "Indent:" VIEW-AS TEXT
          SIZE-PIXELS 40 BY 20 AT Y 45 X 25 WIDGET-ID 68
     "Dump" VIEW-AS TEXT
          SIZE-PIXELS 50 BY 13 AT Y 150 X 25 WIDGET-ID 48
     RECT-2 AT Y 227 X 15 WIDGET-ID 24
     RECT-5 AT Y 157 X 15 WIDGET-ID 58
     RECT-6 AT Y 5 X 15 WIDGET-ID 82
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 182 BY 16.81 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Generate Dump/Load Procedures"
         HEIGHT             = 16.95
         WIDTH              = 183.4
         MAX-HEIGHT         = 40
         MAX-WIDTH          = 320
         VIRTUAL-HEIGHT     = 40
         VIRTUAL-WIDTH      = 320
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME frMain
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Generate Dump/Load Procedures */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Generate Dump/Load Procedures */
DO:
  /* This event will close the window and terminate the procedure.  */
  RUN saveSettings.
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-RESIZED OF C-Win /* Generate Dump/Load Procedures */
DO:

  RUN windowResized.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSave
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSave C-Win
ON CHOOSE OF btnSave IN FRAME frMain /* Save program */
OR 'go' OF FRAME {&FRAME-NAME} ANYWHERE
DO:
  DEFINE VARIABLE lOkay     AS LOGICAL    NO-UNDO.
  DEFINE VARIABLE cFileName AS CHARACTER  NO-UNDO.
  DEFINE VARIABLE cText     AS LONGCHAR   NO-UNDO. 
  
  cFileName = TRIM(STRING('tt' + LC(pcTable), 'xx!x(20)')) + '.i'.

  SYSTEM-DIALOG GET-FILE cFilename
    FILTERS ".i Include file (*.i)" "*.i",
            "Any File (*.*)" "*.*"
    INITIAL-FILTER 1
    ASK-OVERWRITE
    USE-FILENAME
    CREATE-TEST-FILE
    DEFAULT-EXTENSION ".i"
    SAVE-AS
    UPDATE lOkay.

  IF NOT lOkay THEN
    RETURN NO-APPLY.
    
  cText = edDefinition:SCREEN-VALUE IN FRAME frMain.
  COPY-LOB cText TO FILE cFileName.
  
  APPLY "END-ERROR":U TO FRAME frMain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rsDumpLoad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsDumpLoad C-Win
ON VALUE-CHANGED OF rsDumpLoad IN FRAME frMain
DO:

  tgDelete         :SENSITIVE = (SELF:SCREEN-VALUE = 'Dump').
  tgLoadInChunks   :SENSITIVE = (SELF:SCREEN-VALUE = 'Load').
  tgDisableTriggers:SENSITIVE = (SELF:SCREEN-VALUE = 'Load').

  RUN generateCode.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tgDelete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tgDelete C-Win
ON VALUE-CHANGED OF tgDelete IN FRAME frMain /* Delete record */
, cbIndent, tgLowerCase, tgDelete, tgLoadInChunks, tgDisableTriggers
DO:
  RUN generateCode.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  
  SESSION:DEBUG-ALERT = YES.

  RUN enable_UI.
  RUN initObject.
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY edDefinition rsDumpLoad cbIndent tgLowerCase tgIncludeDb tgDelete 
          tgLoadInChunks tgDisableTriggers 
      WITH FRAME frMain IN WINDOW C-Win.
  ENABLE RECT-2 RECT-5 RECT-6 edDefinition rsDumpLoad cbIndent tgLowerCase 
         tgIncludeDb tgDelete tgLoadInChunks tgDisableTriggers btnSave 
      WITH FRAME frMain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE fillTT C-Win 
PROCEDURE fillTT :
/* Fill tt for testing in UIB
  */
  DEFINE BUFFER bField FOR ttField.
  DEFINE BUFFER bIndex FOR ttIndex.
  
  CREATE bField. ASSIGN bField.cFieldName = 'rep-nr'      bField.lShow = TRUE bField.cDataType = 'INTEGER'   bField.cFormat = '>>>9'  bField.cLabel = 'Rep nr'.
  CREATE bField. ASSIGN bField.cFieldName = 'rep-name'    bField.lShow = TRUE bField.cDataType = 'CHARACTER' bField.cFormat = 'x(30)' bField.cLabel = 'Rep name'.
  CREATE bField. ASSIGN bField.cFieldName = 'region'      bField.lShow = FALSE bField.cDataType = 'CHARACTER' bField.cFormat = 'x(8)'  bField.cLabel = 'Region'.
  CREATE bField. ASSIGN bField.cFieldName = 'month-quota' bField.lShow = FALSE bField.cDataType = 'INTEGER'   bField.cFormat = '->,>>>,>>9' bField.cLabel = 'Rep name' bField.iExtent = 12.
         
  CREATE bIndex. ASSIGN bIndex.cIndexName  = 'iPrim'   bIndex.cIndexFlags = 'P U' bIndex.cFieldList  = 'rep-nr'.
  CREATE bIndex. ASSIGN bIndex.cIndexName  = 'iRegion' bIndex.cIndexFlags = ''    bIndex.cFieldList  = 'region,rep-name'.   

END PROCEDURE. /* fillTT */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE generateCode C-Win 
PROCEDURE generateCode :
DEFINE VARIABLE cText         AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE cMask         AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cHeader       AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cIndent       AS CHARACTER NO-UNDO.
  
  DO WITH FRAME frMain:
    
    ASSIGN rsDumpLoad cbIndent tgLowerCase tgDelete tgLoadInChunks tgDisableTriggers.
    
    CASE cbIndent:
      WHEN 'tab' THEN cIndent = '~t'.
      WHEN '2'   THEN cIndent = '  '.
      WHEN '3'   THEN cIndent = '   '.
      WHEN '4'   THEN cIndent = '    '.
    END CASE.

    cHeader = SUBSTITUTE('/*----------------------------------------------------------------------*/ ~n' )
            + SUBSTITUTE('    File        : &1-&2.p ~n', rsDumpLoad, pcTable )
            + SUBSTITUTE('    Description : &1 program for &2.&3 ~n', rsDumpLoad, pcDatabase, pcTable )
            + SUBSTITUTE(' ~n' )
            + SUBSTITUTE('    History: ~n' )
            + SUBSTITUTE('    &1 &2 Created ~n', STRING(TODAY,'99/99/9999'), getUserName() )
            + SUBSTITUTE(' ~n' )
            + SUBSTITUTE('  ----------------------------------------------------------------------*/ ~n' )
            + SUBSTITUTE('/*          This file was generated with the DataDigger                 */ ~n' )
            + SUBSTITUTE('/*----------------------------------------------------------------------*/ ~n' )
            .
            
    CASE rsDumpLoad:
      WHEN 'dump' THEN 
      DO:
        cMask = '~nOUTPUT TO <folder><table>.<ext>.'
              + '~n'
              + '~nFOR EACH <db>.<table> ' + TRIM(STRING(tgDelete,'EXCLUSIVE-LOCK/NO-LOCK')) + ':'
              + '~n<indent>EXPORT <db>.<table>.'
              .
        IF tgDelete THEN
          cMask = cMask + '~n<indent>DELETE <db>.<table>.'.

        cMask = cMask + '~nEND.'
              + '~n '
              + '~nOUTPUT CLOSE.'.
      END. 

      WHEN 'load' THEN
      DO:
      END.

    END CASE.

    cText = cHeader + (IF tgLowerCase THEN LC(cMask) ELSE CAPS(cMask)).

    cText = REPLACE(cText,'<folder>', 'c:\temp\').
    cText = REPLACE(cText,'<ext>'   , 'd').
    IF tgIncludeDb 
      THEN cText = REPLACE(cText,'<db>', pcDatabase + '.').
      ELSE cText = REPLACE(cText,'<db>', '').
    cText = REPLACE(cText,'<table>' , pcTable).
    cText = REPLACE(cText,'<indent>', cIndent).
 
    edDefinition:SCREEN-VALUE = cText.
  END.
  
END PROCEDURE. /* generateCode */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initObject C-Win 
PROCEDURE initObject :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE iSetting AS INTEGER NO-UNDO.
  
  DO WITH FRAME frMain:
    
    /* Prepare window and frame */
    FRAME {&FRAME-NAME}:FONT = getFont('Default').
    edDefinition:FONT = getFont('Fixed').

    {&WINDOW-NAME}:MAX-WIDTH-PIXELS  = SESSION:WIDTH-PIXELS.
    {&WINDOW-NAME}:MAX-HEIGHT-PIXELS = SESSION:HEIGHT-PIXELS.

    /* Init the settings in case they do not yet exist */
    /* Window size */
    IF getRegistry('DataDigger:GenerateDumpLoad', 'Window:width' ) = ? THEN setRegistry('DataDigger:GenerateDumpLoad', 'Window:width' , STRING({&WINDOW-NAME}:WIDTH-PIXELS) ).  
    IF getRegistry('DataDigger:GenerateDumpLoad', 'Window:height') = ? THEN setRegistry('DataDigger:GenerateDumpLoad', 'Window:height', STRING({&WINDOW-NAME}:HEIGHT-PIXELS) ). 

    /* User settings */
    IF getRegistry('DataDigger:GenerateDumpLoad', 'DumpLoad')        = ? THEN setRegistry('DataDigger:GenerateDumpLoad', 'DumpLoad','Dump').
    IF getRegistry('DataDigger:GenerateDumpLoad', 'Indent')          = ? THEN setRegistry('DataDigger:GenerateDumpLoad', 'Indent','2').
    IF getRegistry('DataDigger:GenerateDumpLoad', 'LowerCase')       = ? THEN setRegistry('DataDigger:GenerateDumpLoad', 'LowerCase','no').
    IF getRegistry('DataDigger:GenerateDumpLoad', 'IncludeDbName')   = ? THEN setRegistry('DataDigger:GenerateDumpLoad', 'IncludeDbName','no').
    IF getRegistry('DataDigger:GenerateDumpLoad', 'DeleteRecord')    = ? THEN setRegistry('DataDigger:GenerateDumpLoad', 'DeleteRecord','no').
    IF getRegistry('DataDigger:GenerateDumpLoad', 'LoadInChunks')    = ? THEN setRegistry('DataDigger:GenerateDumpLoad', 'LoadInChunks','no').
    IF getRegistry('DataDigger:GenerateDumpLoad', 'DisableTriggers') = ? THEN setRegistry('DataDigger:GenerateDumpLoad', 'DisableTriggers','no').

    /* Get user settings */
    rsDumpLoad:SCREEN-VALUE   = getRegistry('DataDigger:GenerateDumpLoad', 'DumpLoad').
    cbIndent:SCREEN-VALUE     = getRegistry('DataDigger:GenerateDumpLoad', 'Indent').
    tgLowerCase:CHECKED       = LOGICAL(getRegistry('DataDigger:GenerateDumpLoad', 'LowerCase')).
    tgIncludeDb:CHECKED       = LOGICAL(getRegistry('DataDigger:GenerateDumpLoad', 'IncludeDbName')).
    tgDelete:CHECKED          = LOGICAL(getRegistry('DataDigger:GenerateDumpLoad', 'DeleteRecord')).
    tgLoadInChunks:CHECKED    = LOGICAL(getRegistry('DataDigger:GenerateDumpLoad', 'LoadInChunks')).
    tgDisableTriggers:CHECKED = LOGICAL(getRegistry('DataDigger:GenerateDumpLoad', 'DisableTriggers')).

    APPLY 'VALUE-CHANGED' TO rsDumpLoad.
    
    /* Restore window size */
    iSetting = INTEGER(getRegistry('DataDigger:GenerateDumpLoad', 'Window:width' )) NO-ERROR.
    IF iSetting <> ? THEN {&WINDOW-NAME}:WIDTH-PIXELS = iSetting.

    iSetting = INTEGER(getRegistry('DataDigger:GenerateDumpLoad', 'Window:height')) NO-ERROR.
    IF iSetting <> ? THEN {&WINDOW-NAME}:HEIGHT-PIXELS = iSetting.

    RUN windowResized.
    
  END.
  
END PROCEDURE. /* initObject */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE saveSettings C-Win 
PROCEDURE saveSettings :
/* Save settings */
    
  DO WITH FRAME {&FRAME-NAME}:
    /* Window size (don't save x,y pos because you might place it on a second monitor and 
     * later try to restore it when your second monitor is gone) 
     */
    setRegistry('DataDigger:GenerateDumpLoad', 'Window:width' , STRING({&WINDOW-NAME}:WIDTH-PIXELS) ).
    setRegistry('DataDigger:GenerateDumpLoad', 'Window:height', STRING({&WINDOW-NAME}:HEIGHT-PIXELS) ).

    /* User settings */
    setRegistry('DataDigger:GenerateDumpLoad', 'DumpLoad'       , rsDumpLoad:SCREEN-VALUE  ).
    setRegistry('DataDigger:GenerateDumpLoad', 'Indent'         , cbIndent:SCREEN-VALUE    ).
    setRegistry('DataDigger:GenerateDumpLoad', 'LowerCase'      , tgLowerCase:SCREEN-VALUE    ).
    setRegistry('DataDigger:GenerateDumpLoad', 'IncludeDbName'  , STRING(tgIncludeDb:CHECKED      )).
    setRegistry('DataDigger:GenerateDumpLoad', 'DeleteRecord'   , STRING(tgDelete:CHECKED         )).
    setRegistry('DataDigger:GenerateDumpLoad', 'LoadInChunks'   , STRING(tgLoadInChunks:CHECKED   )).
    setRegistry('DataDigger:GenerateDumpLoad', 'DisableTriggers', STRING(tgDisableTriggers:CHECKED)).

  END.

END PROCEDURE. /* saveSettings */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE windowResized C-Win 
PROCEDURE windowResized :
/* Window has been resized, adjust editor 
  */
  FRAME {&FRAME-NAME}:SCROLLABLE = YES.
  
  {&WINDOW-NAME}:WIDTH-PIXELS  = MAXIMUM(200, {&WINDOW-NAME}:WIDTH-PIXELS).
  {&WINDOW-NAME}:HEIGHT-PIXELS = MAXIMUM(180, {&WINDOW-NAME}:HEIGHT-PIXELS).

  FRAME {&FRAME-NAME}:WIDTH-PIXELS  = {&WINDOW-NAME}:WIDTH-PIXELS .
  FRAME {&FRAME-NAME}:HEIGHT-PIXELS = {&WINDOW-NAME}:HEIGHT-PIXELS.

  edDefinition:WIDTH-PIXELS  = {&WINDOW-NAME}:WIDTH-PIXELS - 210.
  edDefinition:HEIGHT-PIXELS = {&WINDOW-NAME}:HEIGHT-PIXELS - 13.

  FRAME {&FRAME-NAME}:VIRTUAL-WIDTH-PIXELS  = FRAME {&FRAME-NAME}:WIDTH-PIXELS .
  FRAME {&FRAME-NAME}:VIRTUAL-HEIGHT-PIXELS = FRAME {&FRAME-NAME}:HEIGHT-PIXELS.

  FRAME {&FRAME-NAME}:SCROLLABLE = NO.

END PROCEDURE. /* windowResized */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

