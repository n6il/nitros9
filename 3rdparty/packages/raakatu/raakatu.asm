;##$CPU 6809
;##$OriginalBinary raakatu.bin

;##-
;##- Menu structure for CodeToWeb HTML generator
;##-
;##Menu     3                 "Engine"
;##MenuLink Start                    "Program Entry"
;##MenuLink GetKey                   "Get a Key"
;##MenuLink DecodeBuffer             "Decode Input Buffer"
;##MenuLink DecodeWord               "Decode Single Word"
;##MenuLink InputWordTables          "GAME VOCABULARY"
;##MenuLink RAM                      "RAM Usage"
;##MenuLink PrintPackedMessage       "Print Packed Message"
;##MenuLink PrintCharacterAutoWrap   "Print Character (with auto-wrap)"
;##MenuLink UnpackBytes              "Unpack 2 bytes into 3 characters"
;##MenuLink FeedbackPrompts          "Feedback Prompts"
;##MenuLink PhraseList               "List of phrase forms"
;##-
;##Menu     2                    "Virtual Machine"
;##MenuLink ProcessCommand             "Process a Direct or Common Command"
;##MenuLink CommandJumpTable           "VM Command Jump Table"
;##MenuLink RoomDescriptions           "Information for each room"
;##MenuLink ObjectData                 "Object data"
;##MenuLink GeneralCommands            "General command handling"
;##MenuLink HelperCommands             "List of helper commands each with an ID" 
;##-
;##Menu     1                   "Script Commands"
;##MenuLink Com00_MoveActiveObjectToRoomAndLook         "00: Move active object to room and print room description"
;##MenuLink Com01_IsObjectInPackOrRoom                  "01: Check if requested object is here (in pack or room)"
;##MenuLink Com02_CheckObjectIsOwnedByActive            "02: Check if object is owned by active object"
;##MenuLink Com03_IsObjectYAtX                          "03: Check if requested object at target location" 
;##MenuLink Com04_PrintSYSTEMOrPlayerMessage            "04: Print message if SYSTEM or Player"
;##MenuLink Com05_IsRandomLessOrEqual                   "05: If last random is less than or equal"
;##MenuLink Com06_Inventory                             "06: Print inventory"
;##MenuLink Com07_Look                                  "07: Print room description"
;##MenuLink Com08_CompareObjectToFirstNoun              "08: Compare object to first noun"
;##MenuLink Com09_CompareObjectToSecondNoun             "09: Command object to second noun"
;##MenuLink Com0A_CompareToPhraseForm                   "0A: Compare value to current phrase form"
;##MenuLink Com0B_Switch                                "0B: Switch-statement. Execute a script based on a compare function."
;##MenuLink Com0C_FAIL                                  "0C: FAIL"
;##MenuLink Com0D_ExecutePassingList                    "0D: Execute a list of commands as long as they succeed"
;##MenuLink Com0E_ExecuteFailingList                    "0E: Execute a list of commands as long as they fail"
;##MenuLink Com0F_PickUpObject                          "0F: Pick up object"
;##MenuLink Com10_DropObject                            "10: Drop object"
;##MenuLink Com11_Print1stNounShortName                 "11: Print 1st noun short name"
;##MenuLink Com12_Print2ndNounShortName                 "12: Print 2nd noun short name"
;##MenuLink Com13_PhraseWithRoom1st2nd                  "13: Process phrase with room, 2nd noun, then 1st noun"
;##MenuLink Com14_ExecuteCommandAndReverseReturn        "14: Execute a command and reverse the return"
;##MenuLink Com15_CheckObjBits                          "15: Check object bits"
;##MenuLink Com16_PrintVarShortName                     "16: Print var short name"
;##MenuLink Com17_MoveObjectXToLocationY                "17: Move object to new location"
;##MenuLink Com18_CheckVarOwnedByActiveObject           "18: Check var object owned by active object"
;##MenuLink Com19_MoveActiveObjectToRoom                "19: Move active object to room"
;##MenuLink Com1A_SetVarObjectTo1stNoun                 "1A: Set var object to first noun"
;##MenuLink Com1B_SetVarObjectTo2ndNoun                 "1B: Set var object to second noun"
;##MenuLink Com1C_SetVarObject                          "1C: Set var object"
;##MenuLink Com1D_AttackObject                          "1D: Attack object"
;##MenuLink Com1E_SwapObjects                           "1E: Swap objects"
;##MenuLink Com1F_PrintMessage                          "1F: Print message"
;##MenuLink Com20_CheckActiveObject                     "20: Check active object"
;##MenuLink Com21_RunGeneralWithTempPhrase              "21: Execute general script with temporary phrase and nouns"
;##MenuLink Com22_CompareHealthToValue                  "22: Compare health to value"
;##MenuLink Com23_HealVarObject                         "23: Heal var object"
;##MenuLink Com24_EndlessLoop                           "24: Endless loop"
;##MenuLink Com25_RestartGame                           "25: Restart game"
;##MenuLink Com26_PrintScore                            "26: Print score"
;##-

;##RAM

;##+0088..  printCursor           screen pointer used by BASIC
;
;##+01A7..  tmp1A7                used in decoding the input                   
;##+01A9    tmp1A9                used in comparing X to Y                     
;##+01AA    not1AA                never used
;##+01AB    tmp1AB                used in lots of places                       
;##+01AC    not1AC                never used
;##+01AD    tmp1AD                used in the phrase decoding                  
;##+01AE    not1AE                never used
;##+01AF    not1AF                never used
;##+01B0    not1B0                never used
;##+01B1    not1B1                never used
;##+01B2    tmp1B2                used in word decoding                        
;##+01B3    verbWord              input verb word number                       
;##+01B4    perpWord              preposition word number                      
;##+01B5    prepGiven             preposition given flag                       
;##+01B6    phrasePrep            used in phrase decoding                      
;##+01B7    adjWord               adjective word number                        
;##+01B8    commandTarg           target object of input command               
;##+01B9    not1B9                cleared before decode but never used        
;##+01BA    lsbAdj1               screen LSB of 1st adjective                  
;##+01BB    lsbVerb               screen LSB of verb                           
;##+01BC    lsbCursor             screen lsb used in decoding the input line   
;##+01BD    lsbError              screen lsb used for flashing error messages  
;##+01BE    lastChar              last character printed to screen             
;##+01BF      VAR_OBJ_NUMBER      variable object number                       
;##+01C0..    VAR_OBJ_DATA        variable object data                         
;##+01C2    not1C2                never used
;##+01C3      FIRST_NOUN_NUM      first input noun number                      
;##+01C4    firstNounAdj          first input noun adjective word number
;##+01C5    firstNounLSB          first input noun screen LSB                  
;##+01C6..    FIRST_NOUN_DATA     first input noun object data                
;##+01C8    firstNounParams       first input noun parameter bits             
;##+01C9      SECOND_NOUN_NUM     second input noun number                     
;##+01CA    secondNounAdj         second input noun adjective word number
;##+01CB    secondNounLSB         second input noun noun screen LSB           
;##+01CC..    SECOND_NOUN_DATA    second input noun object data                
;##+01CE    secondNounParams      second input noun parameter bits             
;##+01CF    tmp1CF                another screen pointer used in decode       
;##+01D0    tmp1DO                used in making index of data fields         
;##+01D1      PHRASE_FORM         decoded phrase form                          
;##+01D2      ACTIVE_OBJ_NUM      active object                                
;##+01D3..    ACTIVE_OBJ_DATA     active object data                          
;##+01D5      CUR_ROOM            current room number                         
;##+01D6..    CUR_ROOM_DATA       current room data                          
;##+01D8..  nextToken             used in decoding input                      
;##+01DA    tmp1DA                used in unpacking bytes                      
;##+01DB    tmp1DB                used in unpacking bytes                    
;##+01DC    tmp1DC                used in unpacking bytes                     
;##+01DD    tmp1DD                used in unpacking bytes                     
;##+01DE    tmp1DE                used in unpacking bytes                      
;##+01DF    tmp1DF                used in unpacking bytes                     
;##+01E0    tmp1EO                used in unpacking bytes                      
;##+01E1    tmp1E1                used in making index of data fields         
;##+01E2    tmp1E2                used in input processing                    
;##+01E3    tillMORE              rows left until MORE prompt (not used here)               
;
; $01E4     inputTokens           input token buffer
; $03FF     stack                 top of stack (just below screen memory)

;##Start
        CLRA                ; 256 word (512 bytes on screen)
        LDX     #$0400      ; Start of screen
        LDU     #$6060      ; Space-space
        STU     ,X++        ; Clear ...
        DECA                ; ... text ...
        BNE     $607        ; ... screen

        LDS     #$03FF      ; Stack starts just below screen
        LDA     #$1D        ; Player object ...
        STA     $01D2       ; ... is the active object number
        LDX     #$05E0      ; Set cursor to ...
        STX     >$88        ; ... bottom row of screen
        LDB     #$96        ; Starting ...
        STB     $01D5       ; ... room
        LDX     #$1523      ; Room descriptions
        JSR     $0A1F       ; Find room data
        STX     $01D6       ; Store current room data
        JSR     $0D4A       ; Print room description
        LDA     #$0D        ; Print ...
        JSR     $1184       ; ... CR

;##MainLoop
        LDS     #$03FF      ; Initialize stack
        JSR     $0ACC       ; Get user input

        CLR     $01B7       ; Adjective word number
        CLR     $01BA       ; LSB of 1st adjective in buffer (not used)
        CLR     $01BB       ; LSB of verb
        CLR     $01B2       ; Misc
        CLR     $01B3       ; Verb word number
        CLR     $01B9       ; Never used again
        CLR     $01B8       ; Target object of command (not used)
        CLR     $01B4       ; Preposition number
        CLR     $01B5       ; Preposition given flag (not 0 if given)
        CLR     $01BF       ; VAR object number
        CLR     $01C3       ; 1st noun word number
        CLR     $01C9       ; 2nd noun word number

        LDB     #$1D        ; Player object ...
        STB     $01D2       ; ... is active object
        JSR     $1133       ; Get player object data
        STX     $01D3       ; Active object's data
        JSR     $0A42       ; Skip length
        LDB     ,X          ; Get player location
        STB     $01D5       ; Current room
        LDX     #$1523      ; Room scripts
        JSR     $0A1F       ; Find sublist ... script for room
        STX     $01D6       ; Script for current room
        LDX     #$01E3      ; Input token list area
        STX     $01D8       ; Where decoder fills in
        CLR     ,X          ; Empty token ... clear the list
        LDX     #$05E0      ; Bottom row is input buffer
        JSR     $0B42       ; Decode input word
        BEQ     $692        ; All words done
        LDA     ,X+         ; Next character
        CMPA    #$60        ; A space?
        BEQ     $682        ; Yes ... decode next
        CMPX    #$0600      ; End of input buffer?
        BNE     $687        ; No ... look for next word
        CMPX    #$0600      ; End of input buffer?
        BNE     $682        ; No ... keep looking
        CLR     [$01D8]     ; Terminate token list
        LDX     #$01E3      ; Input buffer
        LDA     ,X          ; List number of first word
        LBEQ    $0736       ; Nothing entered
        CMPA    #$02        ; First word a noun?
        BNE     $6B7        ; No ... move on
        LEAX    1,X         ; Point to word number
        LDA     ,X          ; Get word number
        LEAX    -1,X        ; Back to list number
        CMPA    #$06        ; Living things (people, dogs, etc) are <6
        BCC     $6B7        ; Not a living thing
        STA     $01B8       ; Remember living thing. We are giving them a command so process normally
        LEAX    3,X         ; Next word

        LDA     ,X+         ; Word list
        BEQ     $736        ; End of list ... go process
        LDB     ,X          ; Word number to B
        LDU     ,X++        ; LSB to LSB of U
        PSHS    X           ; Hold token buffer
        DECA                ; List 1? Verbs?
        BNE     $6E5        ; No ... continue

; I believe the goal here was to allow multiple verbs given on an input line
; to be translated to a single verb. The code finds a replacement list for the
; newly given verb and then runs the list two bytes at a time comparing one
; of the entries to the last given verb and storing the second byte if there
; is a match. I believe that is what is SUPPOSED to happen, but I believe the
; code has a bug or two. It actually does nothing at all. The replacement
; list for BEDLAM and RAAKATU is empty so the code is never used anyway.
;
        LDX     #$1332      ;  Multi verb translation list (empty list for BEDLAM and RAAKATU)
        JSR     $0A1F       ;  Look for an entry for the given verb
        BCC     $6DF        ;  No entry ... use the word as-is
        JSR     $0A42       ;  Skip length of entry
        JSR     $0A58       ;  End of list?
        TFR     B,A         ;  ?? Held in A but ...
        BCC     $6DF        ;  Reached end of list. This input is the verb.
        LDB     ,X+         ;  ??
        LDA     ,X+         ;  ?? ... A is mangled here?
        CMPB    $01B3       ;  ?? Compare to 01B3 ...
        BNE     $6CF        ;  Continue running list
        STB     $01B3       ;  ?? ... then store if equal?
        JMP     $0731       ;  Continue with next word

        DECA                ;  List 2 Noun
        BNE     $71E        ;  Not a noun
        TST     $01B5       ;  Has prepostion been given?
        BEQ     $70D        ;  No ... this is first noun
        LDX     #$01C9      ;  2nd noun area
        STB     ,X+         ;  Store word number
        LDA     $01B7       ;  Last adjective
        STA     ,X+         ;  Keep with noun
        LDA     $01BA       ;  LSB of adjective
        STA     ,X          ;  Keep with noun
        BNE     $702        ;  There was one ... go on
        TFR     U,D         ;  Use LSB of ...
        STB     ,X          ;  ... noun if no adjective
        CLR     $01B7       ;  Adjective moved
        CLR     $01B5       ;  Preposition moved
        CLR     $01BA       ;  LSB moved
        BRA     $731        ;  Continue with next word

        LDX     $01C3       ;  Copy ...
        STX     $01C9       ;  ... any ...
        LDX     $01C5       ;  ... first noun ...
        STX     $01CB       ;  ... to second
        LDX     #$01C3      ;  First word area
        BRA     $6F0        ;  Go fill out first word

        DECA                ;  List 3 Adjective
        BNE     $72B        ;  Not a proposition
        STB     $01B7       ;  Store adjective number
        TFR     U,D         ;  Store ...
        STB     $01BA       ;  ... adjective LSB in buffer
        BRA     $731        ;  Continue with next word

        STB     $01B4       ;  Preposition
        STB     $01B5       ;  Preoposition given (noun should follow)
        PULS    X           ;  Restore token pointer
        JMP     $06B7       ;  Next word


        TST     $01B3       ;  Verb given?
        LBEQ    $0995       ;  No ... ?VERB? error
        LDX     #$01C9      ;  Second noun
        JSR     $0822       ;  Decode it (only returns if OK)
        STA     $01C9       ;  Hold target object index
        STX     $01CC       ;  Hold target object pointer
        LDX     #$01C3      ;  First noun
        JSR     $0822       ;  Decode it (only returns if OK)
        STA     $01C3       ;  Hold target object index
        STX     $01C6       ;  Hold target object pointer
        CLR     $01B5       ;  Clear preposition flag

        LDX     $01C6       ;  Pointer to first noun object data
        LDA     $01C3       ;  First noun index
        BEQ     $767        ;  No first noun ... store a 0
        JSR     $0A42       ;  Skip ID and load end
        LEAX    2,X         ;  Skip 2 bytes
        LDA     ,X          ;  Object parameter bits
        STA     $01C8       ;  Hold first noun's parameter bits

        LDX     $01CC       ;  Pointer to second noun object data
        LDA     $01C9       ;  Second noun number
        BEQ     $779        ;  No second noun ... store 0
        JSR     $0A42       ;  Skip ID and load end
        LEAX    2,X         ;  Skip 2 bytes
        LDA     ,X          ;  Object parameter bits
        STA     $01CE       ;  Hold second noun's parameter bits

        LDX     #$135B      ;  Syntax list
        LDA     ,X          ;  End of list?
        LBEQ    $0951       ;  Yes ... "?PHRASE?"
        LDA     $01B3       ;  Verb ...
        CMPA    ,X+         ;  ... matches?
        BNE     $7E7        ;  No ... move to next entry
        LDA     ,X          ;  Phrase's proposition
        STA     $01B6       ;  Hold it
        LDA     $01B4       ;  Preposition word number
        BEQ     $79A        ;  None given ... skip prep check
        CMPA    ,X          ;  Given prep matches?
        BNE     $7E7        ;  No ... move to next phrase
        LEAX    1,X         ;  Skip to next phrase component
        LDA     ,X          ;  First noun required by phrase
        BEQ     $7B4        ;  Not given in phrase ... skip check
        LDA     $01C3       ;  1st noun index
        BNE     $7BB        ;  Requested by phrase but not given by user ... next phrase
        LDA     $01BB       ;  LSB of verb ...
        STA     $01BD       ;  ... to location of error
        LDY     #$01C3      ;  Descriptor for 1st noun
        JSR     $08D2       ;  Decode 1st noun as per phrase
        BRA     $7BB        ;  We just processed a first one. We know it is there.
        LDA     $01C3       ;  Is there a 1st noun?

        LBNE    $0951       ; No ... next entry
        LEAX    1,X         ; Next in phrase
        LDA     ,X          ; Phrase wants a second noun?
        BEQ     $7DA        ; No ... skip
        LDA     $01C9       ; User given 2nd noun
        BNE     $7E1        ; Yes ... use this phrase
        LDA     $01BC       ; Location of ...
        STA     $01BD       ; ... error on screen
        LDA     #$01        ; Set preposition ...
        STA     $01B5       ; ... flag to YES
        LDY     #$01C9      ; 2nd noun index
        JSR     $08D2       ; Decode 2nd noun as per phrase
        BRA     $7E1        ; Use this

        LDA     $01C9       ; Is there a second noun?
        LBNE    $0951       ; No ... phrase error
        LEAX    1,X         ; Get matched ...
        LDA     ,X          ; ... phrase number
        BRA     $7F0        ; Store and continue
        LEAX    1,X         ; Skip ...
        LEAX    1,X         ; ... to ...
        LEAX    2,X         ; ... next entry
        JMP     $077F       ; Keep looking

; Unlike BEDLAM, there is no giving a command to something else. Just
; ignore any commanded object and give the phrase to the user.

        STA     $01D1       ; Store the phrase number
        LDX     #$05FF      ; Move cursor to ...
        STX     >$88        ; ... end of line
        LDA     #$0D        ; Print ...
        JSR     $1184       ; ... CR
        LDA     $01C3       ; First noun given?
        BNE     $80E        ; Yes ... keep what we have
        LDX     $01CC       ; Move 2nd ...
        STX     $01C6       ; ... noun to ...
        LDA     $01C9       ; ... first ...
        STA     $01C3       ; ... descriptor
        LDX     #$323C      ; General command scripts
        JSR     $0A42       ; Skip over end delta
        JSR     $0C03       ; Execute script
        JSR     $0F66       ; Allow objects to move
        LDA     #$0D        ; Print ...
        JSR     $1184       ; ... CR
        JMP     $0630       ; Top of game loop


; This function decodes the NOUN descriptor pointed to by X. The AJECTIVE-NOUN
; pair is compared to all objects in the room (and pack). If no adjective
; is given and there are multiple matching objects (like multiple doors with
; different colors) then the "?WHICH?" prompt is given. If there is no 
; matching object then "?WHAT?" is given. If this function returns then
; the mapping was successful.
;
; @param X pointer to the noun descriptor to decode
; @return A index of target object
; @return X pointer to target object data
;
        CLR     $01BF       ; Input object number
        LDB     ,X+         ; Word number of noun
        STB     $01B2       ; Hold it
        BNE     $82E        ; Real object ... go decode
        CLRA                ; Not found
        RTS                 ; Out
        LDA     ,X+         ; Noun's adjective
        STA     $01B7       ; Hold it
        LDA     ,X          ; LSB of word in buffer
        STA     $01CF       ; Hold it
        LDX     #$20FF      ; Object data
        JSR     $0A1F       ; Get pointer to next object that matches word
        BCC     $89A        ; Not found
        PSHS    Y           ; Hold end of object data
        PSHS    X           ; Hold pointer to noun descriptor
        LDA     $01E1       ; Index of object in the object list
        STA     $01E2       ; Remember this
        JSR     $08AA       ; Is object in this room or on player?
        BNE     $8A6        ; No ... can't be target ... out
        LDA     $01B7       ; Noun's adjective
        BEQ     $873        ; No adjective ... skip this
        PULS    X           ; Restore pointer to noun descriptor
        PSHS    X           ; Hold it again
        JSR     $0A42       ; Skip the id and end
        LEAX    3,X         ; Skip the object data
        LDB     #$01        ; Look up adjective ...
        JSR     $0A27       ; ... list for object
        BCC     $873        ; No adjective ... ignore
        JSR     $0A42       ; Skip the id and length
        JSR     $0A58       ; End of adjective list?
        BCC     $8A6        ; Yes ... no match ... next object
        LDA     $01B7       ; Adjective
        CMPA    ,X+         ; In this list?
        BNE     $867        ; No ... keep searching list
        PULS    X           ; Restore object pointer
        LDA     $01BF       ; Last object index that matched
        LBNE    $098C       ; Multiple matches ... do "?WHICH?"
        LDA     $01E2       ; Object index
        STA     $01BF       ; Current guess at matching object index
        STX     $01C0       ; Input object data
        JSR     $0A42       ; Skip id and end
        TFR     Y,X         ; Next object
        PULS    Y           ; End of object data
        LDB     $01B2       ; Restore word number of noun
        LDA     $01E2       ; Current object index
        STA     $01E1       ; Start count for next pass
        JSR     $0A27       ; Find next matching object
        BCS     $840        ; Got one ... go test it
        LDX     $01C0       ; Object data to X
        LDA     $01BF       ; Object found?
        BNE     $8A5        ; Yes ...  out
        JMP     $0948       ; No ... "?WHAT?"
        RTS                 ; Done
        PULS    X           ; Restore object pointer
        BRA     $885        ; Do next object

; This function checks if the target object is in the current room or being
; held by the active object.
;
; @param X pointer to target object
; @return Z=1 for yes or Z=0 for no
;
        JSR     $0A42       ; Skip size
        LDA     $01D5       ; Current room number
        CMPA    ,X          ; Is object in room?
        BEQ     $8A5        ; Yes ... return OK
        LDA     ,X          ; Get object's room number
        BEQ     $8CF        ; 0 ... fail
        CMPA    #$FF        ; FF ...
        BEQ     $8A5        ; ... return OK
        BITA    #$80        ; Upper bit of object location set ...
        BNE     $8CF        ; ... then fail
        LDB     ,X          ; Location again
        CMPB    $01D2       ; Being held by the active object?
        BEQ     $8A5        ; Yes ... return OK
        LDX     #$20FF      ; Strange. 117D does this too.
        JSR     $1133       ; Get object's container object (if any)
        BRA     $8AA        ; Repeat check
        ORA     #$01        ; Mark failure
        RTS                 ; Out

; This function fills the noun descriptor pointed to by Y with the object
; in current room or on user that matches the parameter value from the
; phrase script. If there is not exactly one such object then flash an error
; like "WITH ?WHAT?" using the current preposition or just "?WHAT?" if there
; isn't one.
;
; @param Y pointer to noun descriptor to fill
; @param X pointer to phrase data
; @return descriptor filled out with object
;
        PSHS    X           ; Hold phrase data pointer
        CLR     $01B2       ; Found word flag
        CLR     $01E1       ; Object index starts at 0
        PSHS    Y           ; Hold noun descriptor
        LDA     ,X          ; Object parameter mask bits
        STA     $01AB       ; Hold
        LDX     #$20FF      ; Object data
        JSR     $0A42       ; Skip ID and load end
        JSR     $0A58       ; At end of object data?
        BCC     $92C        ; Yes ... done
        INC     $01E1       ; Bump object index
        PSHS    Y           ; Hold end of object
        PSHS    X           ; Hold pointer to object
        JSR     $08AA       ; Is object in room or on player?
        PULS    X           ; Restore pointer to object
        BNE     $927        ; No ... next object
        LDB     ,X          ; Object word number
        STX     $01D8       ; Pointer to object data
        JSR     $0A42       ; Skip ID and load end
        LEAX    2,X         ; Point to object parameters
        LDA     ,X          ; Get parameters
        ANDA    $01AB       ; Compare to phrase data ...
        CMPA    $01AB       ; ... this is a strange way to do it
        BNE     $921        ; Not a match ... next word
        LDA     $01B2       ; Already got a word number?
        BNE     $95A        ; Yes ... error
        STB     $01B2       ; Found word number
        LDA     ,X          ; Remember ...
        STA     $01B7       ; ... object parameters
        LDX     $01D8       ; Remember ...
        STX     $01AD       ; ... object pointer
        EXG     X,Y         ; Start of next object to X
        PULS    Y           ; Restore end of object pointer
        BRA     $8E7        ; Continue with next object
        JSR     $0A42       ; Skip ID and load end
        BRA     $921        ; Try next object
        LDA     $01B2       ; Did we find an object word?
        BEQ     $95A        ; No .... error
        PULS    Y           ; Noun descriptor
        LDX     $01AD       ; Object data pointer
        LDA     $01E1       ; New ...
        STA     ,Y          ; ... object number
        LEAY    3,Y         ; New ...
        STX     ,Y++        ; ... pointer to object data
        LDA     $01B7       ; New ...
        STA     ,Y          ; ... object parameters
        PULS    X           ; Restore phrase data pointer
        CLRA                ; Set Z=1
        RTS                 ; Done

        LDY     #$1343      ; "?WHAT?"
        LDA     $01CF       ; LSB of screen location
        BRA     $99B        ; Go flash error and try again

        LDY     #$1352      ; "?PHRASE?"
        LDA     $01BC       ; LSB of screen location
        BRA     $99B        ; Go flash error and try again

        LDA     $01B5       ; Preposition given?
        BEQ     $983        ; No ... just plain "?WHAT?"
        LDA     $01B4       ; Preposition word number?
        BNE     $983        ; No word ... just plain "?WHAT?"
        LDX     #$3ECF      ; Prepositions list
        LDB     ,X          ; Length of word
        BEQ     $983        ; Reached the end ... do "?WHAT?"
        PSHS    X           ; Hold start of word
        LDB     ,X+         ; Get length again
        ABX                 ; Point to end of word
        LDA     $01B6       ; Target preposition
        CMPA    ,X+         ; Matches?
        BEQ     $97B        ; Yes ... error includes this word
        PULS    A,B         ; Restore stack
        BRA     $967        ; Next word
        PULS    Y           ; Word text to Y
        LDA     $01BD       ; LSB of error message
        JSR     $09E1       ; Push preposition word
        LDY     #$1343      ; "?WHAT?"
        LDA     $01BD       ; LSB of screen location
        BRA     $99B        ; Go flash error and try again
        LDY     #$134A      ; "?WHICH"?
        LDA     $01CF       ; LSB of screen location
        BRA     $99B        ; Go flash error and try again
        LDY     #$133C      ; "?VERB?"

        LDA     #$E0        ; LSB of start of input line
        LDS     #$03FF      ; Reset the stack (we jump back into the main loop)
        LDX     #$05E0      ; Error goes at start of line
        JSR     $09E1       ; Push error message on and pause
        LDA     ,Y          ; Get length
        STA     $01AB       ; Hold in counter
        PSHS    X           ; Hold X
        LDA     #$60        ; SPACE
        STA     ,X+         ; Flash off ...
        DEC     $01AB       ; ... error ...
        BNE     $9AC        ; ... word
        JSR     $09D6       ; Long delay
        PULS    X           ; Restore insertion point
        DECB                ; All flashes done?
        BNE     $9D1        ; No ... keep flashing error word
        LDA     ,Y          ; Size of error word
        INCA                ; Plus the extra space
        STA     $01AB       ; Hold counter
        JSR     $0ADB       ; Close up the ...
        DEC     $01AB       ; ... error ...
        BNE     $9C3        ; ... word
        JSR     $0A63       ; Get input line
        JMP     $0637       ; Continue processing
        JSR     $0A00       ; Flash message and pause
        BRA     $9A5        ; Continue flashing and read new line

;Long delay
        LDA     #$32        ; Outer loop counts
        DEC     $01AB       ; Decrease inner count (doesn't matter what's there)
        BNE     $9D8        ; Kill inner time
        DECA                ; All 256 loops done?
        BNE     $9D8        ; No ... keep pausing
        RTS                 ; Done

        STA     $01AB       ; Hold LSB of cursor
        LDD     #$05E0      ; Start of input line
        LDB     $01AB       ; Replace LSB
        TFR     D,X         ; Place for error word in X
        LDA     ,Y          ; Get length of message
        INCA                ; Plus a space after
        STA     $01AB       ; Store length
        PSHS    Y           ; Hold message
        JSR     $0B06       ; Slide right past insertion point
        DEC     $01AB       ; Space opened up?
        BNE     $9F4        ; No ... open all the spaces for the error word
        PULS    Y           ; Restore pointer
        LDB     #$08        ; 8 flashes
        LDA     ,Y          ; Count again
        STA     $01AB       ; Size of word
        PSHS    Y,X,B       ; Hold all
        LEAY    1,Y         ; Skip size
        LDA     ,Y+         ; Copy error word ...
        STA     ,X+         ; ... to screen
        DEC     $01AB       ; All done?
        BNE     $A09        ; No ... go back and do all
        LEAX    1,X         ; Bump ...
        TFR     X,D         ; ... LSB ...
        STB     $01BD       ; ... of screen pointer
        JSR     $09D6       ; Long pause
        PULS    B,X,Y       ; Restore
        RTS                 ; Done

; FindSublist
; Find a sublist by ID within a master list.
; X=pointer to master list
; B=sublist ID
; Return sublist pointer in X
; Return C=0 if not found, C=1 if found
        LEAX    1,X         ; Skip list ID
        JSR     $0A44       ; Read end of list to Y
        CLR     $01E1       ; Clear index of sublist
        JSR     $0A58       ; Compare X to Y
        BCS     $A2D        ; X is smaller ... keep going
        RTS                 ; Done (C=0 not found)
        INC     $01E1       ; Keep up with index of sublist
        CMPB    ,X          ; Is this the sublist we want?
        BEQ     $A3F        ; Found ... C=1 and out
        PSHS    Y           ; Hold the end
        JSR     $0A42       ; Skip ID and read end of list to Y
        TFR     Y,X         ; Jump to the end of this list
        PULS    Y           ; Restore the end of the master lsit
        BRA     $A27        ; Keep looking for the sublist
;
        ORCC    #$01        ; C=1
        RTS                 ; Done

;##-SkipIDLoadEnd
; Skip the ID byte and load the end of the list in Y.
        LEAX    1,X         ; Bump script pointer
;
;##LoadEnd
; Load the end of the list in Y.
        CLRA                ; Upper is 0
        PSHS    B           ; Hold lower
        LDB     ,X+         ; Get lower
        BITB    #$80        ; One or two byte value?
        BEQ     $A53        ; Just a one byte ... use it
        ANDB    #$7F        ; This is the ...
        TFR     B,A         ; ... MSB
        LDB     ,X+         ; Now get 2nd byte (LSB)
        LEAY    D,X         ; Offset script
        PULS    B           ; Restore B
        RTS                 ; Done

;##CompareXY
; Compare X to Y (flags = X - Y)
        STY     $01A9       ; Do compare ...
        CMPX    $01A9       ; X - Y
        RTS                 ; Done

;##GetInputLine
        LDX     #$05E0      ; Start of bottom row
        JSR     $0B23       ; Slide bottom row to right after cursor and draw cursor
        JSR     $0B2B       ; Get a key from the keyboard
        CMPA    #$15        ;
        BEQ     $A8D        ; Swap cursor and character to left
        CMPA    #$5D        ; ']' ?
        BEQ     $AA0        ; Swap cursor and character to right
        CMPA    #$09        ; Backspace
        BEQ     $AB3        ; Go handle backspace
        CMPA    #$0D        ; CR?
        BEQ     $AC8        ; Handle it and out
        CMPA    #$0C        ; BREAK?
        BEQ     $ACC        ; Yes ... clear the row
        CMPA    #$08        ; Backspace?
        BEQ     $ABC        ; Yes go handle
        CMPX    #$05FF      ; At the end of the screen?
        BEQ     $A66        ; Yes ... ignore and get another
        JSR     $0B06       ; Slide bottom row beyond insertion
        STA     ,X+         ; Store character
        BRA     $A66        ; Go get another character

        CMPX    #$05E0      ; Nothing typed?
        BEQ     $A66        ; Yes ... ignore and get another
        LEAX    -1,X        ; Swap ...
        LDA     ,X+         ; ... cursor ...
        STA     ,X          ; ... and ...
        LEAX    -1,X        ; ... character ...
        LDA     #$CF        ; ... to the ...
        STA     ,X          ; ... left
        BRA     $A66        ; Go get another character

        CMPX    #$05FF      ; End of screen?
        BEQ     $A66        ; Yes ... go get another key
        LEAX    1,X         ; Swap ...
        LDA     ,X          ; ... cursor ...
        LEAX    -1,X        ; ... and ...
        STA     ,X+         ; ... character ...
        LDA     #$CF        ; ... to the ...
        STA     ,X          ; ... right
        BRA     $A66        ; Go get another key
;
        JSR     $0ADB       ; Back off trailing cursor block
        LDA     #$CF        ; Store ...
        STA     ,X          ; ... cursor block
        BRA     $A66        ; Go get another key
;
        CMPX    #$05E0      ; At the start of the row?
        BEQ     $A66        ; Yes ... go get another key
        LEAX    -1,X        ; Back up one character
        JSR     $0ADB       ; Erase the end
        BRA     $A66        ; Go get another key
;
        JSR     $0ADB       ; Back off cursor character
        RTS                 ; Done
;
        LDX     #$05E0      ; Start of bottom row
        LDB     #$20        ; 32 characters on the row
        LDA     #$60        ; SPACE character
        STA     ,X+         ; Clear ...
        DECB                ; ... the ...
        BNE     $AD3        ; ... bottom row
        JMP     $0A60       ; Go get another key
;
        TFR     X,U         ; Hold X
        LEAY    1,X         ; Clear trailing ...
        LDA     #$60        ; ... cursor ...
        STA     ,X          ; ... block
;
        CMPY    #$0600      ; End of screen?
        BEQ     $ACB        ; Yes out
        CMPY    #$0601      ; End of screen?
        BEQ     $ACB        ; Yes out
        CMPY    #$0602      ; End of screen?
        BEQ     $ACB        ; Yes out
        LDA     ,Y+         ; Back ...
        STA     ,X+         ; ... up ...
        CMPY    #$0600      ; ... row ...
        BNE     $AF5        ; ... over cursor
        LDA     #$60        ; Clear last ...
        STA     ,X          ; ... character
        TFR     U,X         ; Restore X
        RTS                 ; Done
;
        CMPX    #$0600      ; Past end of screen?
        BEQ     $B22        ; Yes ... out
        STX     $01A7       ; Hold insertion point
        LDX     #$0600      ; End+1
        LDY     #$05FF      ; End
        LDB     ,-Y         ; Slide bottom row ...
        STB     ,-X         ; ... to the right
        CMPX    $01A7       ; At the insertion point?
        BNE     $B15        ; No ... slide all
        LDB     #$60        ; SPACE
        STB     ,X          ; Clear first character
        RTS                 ; Done
;
        JSR     $0B06       ; Slide row over from cursor
        LDA     #$CF        ; Cursor character (white block)
        STA     ,X          ; Cursor to screen
        RTS                 ; Done

;##-GetKey
        JSR     $12A8       ; Get random number every key
        JSR     [$A000]     ; Get key from user
        TSTA                ; Anything pressed?
        BEQ     $B2B        ; No ... keep waiting
        CMPA    #$41        ; Letter 'A'
        BCC     $B3F        ; Greater or equal ... use it
        CMPA    #$20        ; Space
        BCS     $B3F        ; Lower .... use it
        ADDA    #$40        ; Not really sure why. '!' becomes 'a'.
        RTS                 ; Done


;##DecodeBuffer
; X=input buffer on screen (1 before)
; 1D8=pointer to result token list
; Return 1CF LSB of first word
; Return 1BB LSB of next word
; Return list of 3-byte tokens filled into buffer pointed to by 1D8:
;   NN WW PP
;     NN = list number
;     WW = word number
;     PP = LSB of word on screen
;
        LEAX    1,X         ; Next in buffer
;
        TFR     X,D         ; Hold ...
        STB     $01CF       ; ... LSB of first word (could be ignored)
        CMPX    #$0600      ; End of buffer?
        BEQ     $B3F        ; Yes ... out
        LDA     ,X          ; Next in input
        CMPA    #$60        ; Valid character?
        BCC     $B40        ; No ... skip till we find one
        LDY     #$3C29      ; Word token table
        JSR     $0B8B       ; Try first list
        BEQ     $B42        ; Found a match ... ignore it
        LDB     #$01        ; Staring list number
        LEAY    1,Y         ; Next list of words
        JSR     $0B8B       ; Try and match
        BEQ     $B6C        ; Found a match ... record it
        INCB                ; Next list of words
        CMPB    #$05        ; All tried?
        BNE     $B5D        ; No ... go back and try all
        ORA     #$01        ; Not-zero ... error
        RTS                 ; Done

        EXG     X,Y         ; X to Y
        LDX     $01D8       ; Current result token pointer
        STB     ,X+         ; Store list number
        STA     ,X+         ; Store word number
        LDA     $01CF       ; Start of word
        STA     ,X+         ; Store word start
        STX     $01D8       ; Bump result token pointer
        EXG     X,Y         ; Restore X
        CMPB    #$01        ; Is this the first (VERB) list?
        BNE     $B89        ; No ... skip marking
        LDA     $01BC       ; Mark the input buffer location ...
        STA     $01BB       ; ... of the verb
        CLRA                ; OK
        RTS                 ; Return

;##DecodeWord
; Y=input match table
; X=pointer to input buffer word
; Return word data in A if found
; Return is-zero if found, not-zero if not found
; Return 1AB with word data (if found)
; Return 1BC with LSB of pointer-to-next-word
;
; 1A7,1A8 Temporary
; 1AB Temporary
; 1D0 Temporary 
;
        LDA     ,Y          ; Length of word
        BNE     $B92        ; It is a word ... go check it
        ORA     #$01        ; End of list ...
        RTS                 ; ... return not-zero
        STA     $01AB       ; Temporary
        STA     $01D0       ; Temporary
        PSHS    X           ; Hold pointer to input word
        LEAY    1,Y         ; Skip over word length in table
        LDA     ,X          ; Character from input (from screen)
        CMPA    #$60        ; Space?
        BEQ     $BF5        ; Yes. Didn't match the target word. Next.
        CMPX    #$0600      ; Past screen (end of buffer)?
        BEQ     $BF5        ; Yes. Didn't match the target word. next
        CMPA    #$60        ; Valid character?
        BCS     $BAF        ; Yes ... do compare
        LEAX    1,X         ; No ... skip this
        BRA     $B9C        ; Look for valid character
        CMPA    ,Y          ; Matches target word?
        BNE     $BF5        ; No ... next word
        LEAX    1,X         ; Next in input
        LEAY    1,Y         ; Next in match
        DEC     $01AB       ; All done?
        BNE     $B9C        ; No ... keep looking
        LDA     $01D0       ; Original length
        CMPA    #$06        ; Six letter input?
        BEQ     $BC9        ; Yes ... could be truncated. That's enough of a match.
        LDA     ,X          ; Next from screen
        CMPA    #$60        ; Space? End of word?
        BCS     $BFC        ; No. Try next word
        LDA     ,Y          ; Get the word data
        PULS    Y           ; Drop the input buffer pointer
        STA     $01AB       ; Hold the word data
        LDA     ,X          ; Next in input buffer?
        CMPA    #$60        ; Is it a space?
        BEQ     $BE2        ; Yes ... ready for next word
        STX     $01A7       ; Start of next word (in case end of buffer)
        CMPX    #$0600      ; Is this the end of the input buffer?
        BEQ     $BE8        ; Yes. Done
        LEAX    1,X         ; Skip to next input word
        BRA     $BD0        ; Keep looking for input
        STX     $01A7       ; Pointer to ending space
        INC     $01A8       ; Point to next character past space (start of next word)
        LDA     $01A8       ; Keep ...
        STA     $01BC       ; ... only LSB
        LDA     $01AB       ; Return word data in A
        CLR     $01A7       ; return is-zero for found
        RTS                 ; Done
;
        LEAY    1,Y         ; Skip next in word data
        DEC     $01AB       ; All skipped
        BNE     $BF5        ; No ... skip all
        PULS    X           ; Restore pointer to word
        LEAY    1,Y         ; Skip word data
        JMP     $0B8B       ; Keep trying
    
;##ProcessCommand
; Either a direct command or a common command
        LDA     ,X+         ; Next in script
        TFR     A,B         ; Hold original command
        BITA    #$80        ; Upper bit set?
        BEQ     $C1E        ; No ... do commands
        PSHS    Y,X         ; Hold
        LDX     #$37FA      ; Common commands
        JSR     $0A1F       ; Find common command
        BCC     $C1B        ; Not found ... skip
        JSR     $0A42       ; Skip length of command
        JSR     $0C03       ; Execute command
        PULS    X,Y         ; Restore
        RTS                 ; Out

        TFR     B,A         ; Hold original command
        LDY     #$12E5      ; Function table
        ASLA                ; Jump to ...
        JMP     [A,Y]       ; ... command

;##Com0D_ExecutePassingList
; Execute a list of commands as long as they pass. Either way end pointing one
; past end.
; Data: LENGTH + list of command
        JSR     $0A44       ; Read length of command
        JSR     $0A58       ; Are we past the end?
        BCC     $C3B        ; Yes ... end successfully
        PSHS    Y           ; Hold the end
        JSR     $0C03       ; Execute the command
        PULS    Y           ; Restore the end
        BEQ     $C2A        ; Command successful? Yes ... keep processing
        EXG     X,Y         ; Fail ... put us at the end
        RTS                 ; Done
        EXG     X,Y         ; Point to end of list
        CLRA                ; Z=1 ... success
        RTS                 ; Done

;##Com0E_ExecuteFailingList
        JSR     $0A44       ; Load the end
        JSR     $0A58       ; Reached end of list?
        BCC     $C53        ; Yes ... error
        PSHS    Y           ; Hold end of command
        JSR     $0C03       ; Execute command
        PULS    Y           ; Restore end
        BNE     $C42        ; Command failed ... try next
        EXG     X,Y         ; Set script pointer to end of list
        RTS                 ; Out
; 
        EXG     X,Y         ; Set script pointer to end of list
        ORA     #$01        ; Return fail
        RTS                 ; Done

;##Com0B_Switch
        JSR     $0A44       ; Get size of switch list
        LDB     ,X+         ; Get function to call
        JSR     $0A58       ; End of options?
        BCC     $C53        ; Yes ... out with error
        PSHS    Y           ; Hold total switch size
        PSHS    B           ; Hold function to call
        TFR     B,A         ; Call the ...
        JSR     $0C20       ; ... target function
        PULS    B           ; Restore function to call
        BEQ     $C78        ; Got our script ... go do it
        JSR     $0A44       ; Size of pass script
        EXG     X,Y         ; Skip over this option
        PULS    Y           ; End of script
        BRA     $C5D        ; Keep looking
        JSR     $0A44       ; Skip length
        JSR     $0C03       ; Execute
        PULS    X           ; Restore script
        RTS                 ; Done

;##Com00_MoveActiveObjectToRoomAndLook
        JSR     $0C8D       ; Move active object to new room
        PSHS    X           ; Hold script
        JSR     $0D4A       ; Print room description and objects
        PULS    X           ; Restore script
        CLRA                ; OK
        RTS                 ; Done

;##Com19_MoveActiveObjectToRoom
        LDA     ,X+         ; New room number
        PSHS    X           ; Hold script
        STA     $01D5       ; Store new actvie room number
        TFR     A,B         ; Store ...
        LDX     #$1523      ; ... pointer ...
        JSR     $0A1F       ; ... to ...
        STX     $01D6       ; ... new room
        LDX     $01D3       ; Active object
        JSR     $0A42       ; Skip size
        LDA     $01D5       ; New location
        STA     ,X          ; Move object to active room
        PULS    X           ; Restore script
        CLRA                ; OK
        RTS                 ; Done

;##Com1A_SetVarObjectTo1stNoun
        LDU     $01C6       ; Copy 1st noun ...
        STU     $01C0       ; ... data pointer
        LDA     $01C3       ; Copy 1st noun ...
        STA     $01BF       ; ... object number
        CLRA                ; Z=1 for OK
        RTS                 ; Done

;##Com1B_SetVarObjectTo2ndNoun
        LDU     $01CC       ; Copy 2nd noun ...
        STU     $01C0       ; ... data pointer
        LDA     $01C9       ; Copy 2nd noun ...
        STA     $01BF       ; ... object number
        CLRA                ; Z=1 for OK
        RTS                 ; Done

;##Com1C_SetVarObject
        LDB     ,X+         ; Get object number from script
        PSHS    X           ; Hold script pointer
        STB     $01BF       ; Store target object number
        BEQ     $CD9        ; 0 ... no-object
        JSR     $1133       ; Find object data
        STX     $01C0       ; Store target object data
        PULS    X           ; Restore script
        CLRA                ; Return OK
        RTS                 ; Done

;##Com21_RunGeneralWithTempPhrase
        LDU     $01C6       ; 1st noun data ...
        PSHS    U           ; ... on stack
        LDU     $01CC       ; 2nd noun data ...
        PSHS    U           ; ... on stack
        LDA     $01C9       ; 2nd noun number
        LDB     $01C3       ; 1st noun number
        PSHS    B,A         ; Hold these
        LDA     $01D1       ; Phrase number
        PSHS    A           ; Hold it
        LDA     ,X+         ; New temporary ...
        STA     $01D1       ; ... phrase number
        LDD     ,X++        ; Temporary 1st and 2nd noun numbers
        STB     $01AB       ; Hold 2nd noun for now
        PSHS    X           ; Hold script
        STA     $01C3       ; Temporary 1st noun
        TFR     A,B         ; To B (for lookup)
        BEQ     $D0D        ; Not one ... skip
        JSR     $1133       ; Lookup object in B
        STX     $01C6       ; Temporary 1st noun data
        LDB     $01AB       ; Temporary 2nd noun ...
        STB     $01C9       ; ... index
        BEQ     $D1B        ; There isn't one ... skip
        JSR     $1133       ; Lookup object in B
        STX     $01CC       ; Temporary 2nd noun
        LDX     #$323C      ; General commands
        JSR     $0A42       ; Skip ID and length
        JSR     $0C03       ; Execute general script
        TFR     CCR,A       ; Hold the result ...
        STA     $01AB       ; ... for a moment
        PULS    Y           ;
        PULS    A           ;
        STA     $01D1       ; Restore ...
        PULS    A,B         ; ... phrase ...
        STB     $01C3       ; ... and ...
        STA     $01C9       ; ... nouns
        PULS    U           ;
        STU     $01CC       ;
        PULS    U           ;
        STU     $01C6       ;
        EXG     X,Y         ;
        LDA     $01AB       ;
        TFR     A,CCR       ; Restore result
        RTS                 ; Done

; Print room description
        LDA     $01D2       ; Actiuve object number
        CMPA    #$1D        ; Is this the SYSTEM object?
        BNE     $D49        ; No ... return
        LDX     $01D6       ; Current room script
        JSR     $0A42       ; Skip length
        LEAX    1,X         ;
        LDB     #$03        ; You are in DESCRIPTION script
        JSR     $0A27       ; Get room description
        BCC     $D65        ; No room description ... print objects in room
        LEAX    1,X         ; Assume length is one byte
        JSR     $114C       ; Print the packed message
;
; Print object descriptions
;
        LDX     #$20FF      ; Object data
        JSR     $0A42       ; Skip length
        PSHS    Y           ; Hold end
        JSR     $0A42       ; Skip this object's length
        LDA     $01D5       ; Current room
        CMPA    ,X          ; Object in room?
        BNE     $D89        ; No ... next object
        LEAX    3,X         ; Skip data
        LDB     #$03        ; Get description ...
        JSR     $0A27       ; ... field
        BCC     $D89        ; No description ... next object
        LEAX    1,X         ; Skip length
        PSHS    Y           ; Hold end of object
        JSR     $114C       ; Print description
        PULS    Y           ; Restore length
        EXG     X,Y         ; Next object
        PULS    Y           ; End of objects
        JSR     $0A58       ; All done?
        BCS     $D6B        ; No ... keep printing
        RTS                 ; Done

;##Com01_IsObjectInPackOrRoom
        LDB     ,X+         ; Get object number from script
        PSHS    X           ; Hold script pointer
        JSR     $1133       ; Get object data
        JSR     $08AA       ; See if it is in pack or room
        PULS    X           ; Restore script
        RTS                 ; Out

;##Com20_CheckActiveObject
        LDA     $01D2       ; Active object
        CMPA    ,X+         ; Matches target?
        RTS                 ; Done

;##Com02_CheckObjectIsOwnedByActive
        LDB     ,X+         
        JMP     $0F5F       

;##Com03_IsObjectYAtX
; Check to see if an object is at a target location.
        LDD     ,X++        ; Room and object
        PSHS    X           ; Hold script
        STA     $01AB       ; Remember the room
        JSR     $1133       ; Locate the object
        JSR     $0A42       ; Skip the length
        LDD     ,X++        ; Get the room to A
        CMPA    $01AB       ; Is this object in the target place?
        PULS    X           ; Restore script
        RTS                 ; Out

;##Com0C_FAIL
; Always fail
        ORA     #$01        ; Set the fail flag
        RTS                 ; Done

;##Com04_PrintSYSTEMOrPlayerMessage
        LDA     $01D2       ; Active object
        CMPA    #$1D        ; Is this the player?

        BNE     $DD8        ; No ... must be system

;##Com1F_PrintMessage
        LDB     #$1D        ; Player number
        PSHS    X           ; Hold script
        JSR     $1133       ; Look up Player
        JSR     $08AA       ; Is Player in current room?
        PULS    X           ; Restore
        BEQ     $DDF        ; Yes ... do printing
        JSR     $0A44       ; Skip to ...
        EXG     X,Y         ; ... end of packed message.
        BRA     $DE2        ; Return OK but no printing
        JSR     $114C       ; Print packed message at X
        CLRA                ; OK
        RTS                 ; Done

;##Com07_Look
        JSR     $0D4A       ; Print room description
        CLRA                ; OK
        RTS                 ; Done

;##Com06_Inventory
        PSHS    X           ; Hold script pointer
        LDA     #$0D        ; Print ...
        JSR     $1184       ; ... CR
        LDX     #$20FF      ; Objects
        JSR     $0A42       ; Skip size of objects
;
        JSR     $0A58       ; CompareXY
        BCC     $E1F        ; End of list ... out
        PSHS    Y           ; Hold end of master list of objects
        JSR     $0A42       ; Get pointer to next object
        LDB     ,X          ; Object location
        CMPB    $01D2       ; Active object?
        BNE     $E19        ; No ... skip this object
        LEAX    3,X         ; Skip data
        LDB     #$02        ; Find short name ...
        JSR     $0A27       ; ... string
        BCC     $E19        ; No short name ... skip
        LEAX    1,X         ; Skip the 02 data id
        PSHS    Y           ; Hold next-object
        JSR     $1143       ; Print packed message and CR
        PULS    Y           ; Restore next-object
        EXG     X,Y         ; Move to next object
        PULS    Y           ; End of master list
        BRA     $DF6        ; Do all objects
        CLRA                ; Success
        PULS    X           ; Restore script pointer
        RTS                 ; Done

;##Com08_CompareObjectToFirstNoun
        LDU     $01C6       ; 1st noun data
        LDA     $01C3       ; 1st noun number
;
        STU     $01D8       ; Hold
        TSTA                ; Is there an object?
        BEQ     $E3F        ; No ... error
        LDB     ,X+         ; Object number from script
        PSHS    X           ; Hold script
        JSR     $1133       ; Find object
        EXG     X,Y         ; Pointer of found object to Y
        PULS    X           ; Restore script pointer
        CMPY    $01D8       ; Object the same?
        RTS                 ; Done
        TSTB                ; B can't be 0 ... Z=0 error
        RTS                 ; Done

;##Com09_CompareObjectToSecondNoun
        LDU     $01CC       ; 2nd noun data
        LDA     $01C9       ; 2nd noun number
        BRA     $E29        ; Do compare

;##Com0A_CompareToPhraseForm
        LDB     ,X+         ; Compare from script ...
        CMPB    $01D1       ; ... to phrase form
        RTS                 ; Done

;##Com0F_PickUpObject
; Move noun object to pack.
        PSHS    X           ; Hold script
        LDX     $01C0       ; Pointer to noun object
        JSR     $0A42       ; Skip length
        LDA     $01D2       ; Back pack "location" value
        STA     ,X          ; Move object to pack
        CLRA                ; OK
        PULS    X           ; Restore script
        RTS                 ; Done

;##Com10_DropObject
; Move noun object to current room.
        PSHS    X           ; Hold script
        LDX     $01C0       ; Pointer to noun object
        JSR     $0A42       ; Skip length
        LDA     $01D5       ; Current room
        STA     ,X          ; Move object to room
        PULS    X           ; Restore script
        CLRA                ; Done
        RTS                 ; Out

;##Com13_PhraseWithRoom1st2nd
        PSHS    X           ; Save script
        LDX     $01D6       ; Current room script
        JSR     $0A42       ; Skip id and length
        LEAX    1,X         ; Skip
        LDB     #$04        ; Get ...
        JSR     $0A27       ; ... phrase script
        BCC     $E8A        ; No phrase script ... skip
        JSR     $0A42       ; Skip id and length
        JSR     $0C03       ; Execute
        BEQ     $EC5        ; Move passed ... OK and out
        LDA     $01C9       ; Is there a 2nd noun?
        BEQ     $EA6        ; No ... skip
        LDX     $01CC       ; Second noun data
        JSR     $0A42       ; Skip ...
        LEAX    3,X         ; ... object header
        LDB     #$06        ; Get "noun is second" ...
        JSR     $0A27       ; ... phrase script
        BCC     $EA6        ; None ... move on
        JSR     $0A42       ; Skip header
        JSR     $0C03       ; Execute script
        BEQ     $EC5        ; Script passed ... OK and out
        LDA     $01C3       ; Is there a 1st noun?
        BNE     $EB0        ; Yes ... go do it
        PULS    X           ; Restore script
        ORA     #$01        ; Nobody took the phrase ..
        RTS                 ; .. error and and out
        LDX     $01C6       ; First noun data
        JSR     $0A42       ; Skip ...
        LEAX    3,X         ; ... object header
        LDB     #$07        ; Get "noun is first" ...
        JSR     $0A27       ; ... phrase script
        BCC     $EAB        ; None ... error and out
        JSR     $0A42       ; Skip the id and length
        JSR     $0C03       ; Execute script (use return)
        PULS    X           ; Restore script pointer
        RTS                 ; Done

;##Com16_PrintVarShortName
        PSHS    X           ; Save script pointer
        LDX     $01C0       ; Var noun data
        LDA     $01BF       ; Var noun index
        BRA     $EDA        ; Print short name

;##Com11_Print1stNounShortName
        PSHS    X           ; Save script pointer
        LDX     $01C6       ; 1st noun data
        LDA     $01C3       ; 1st noun index
;
        BEQ     $EC5        ; Return Z=1 return
        LDB     #$1D        ; User object
        PSHS    X           ; Hold noun data
        JSR     $1133       ; Lookup user object
        JSR     $08AA       ; User in current room?
        PULS    X           ; Restore noun data
        BNE     $EFB        ; Not in current room ... skip print
        JSR     $0A42       ; Skip object ...
        LEAX    3,X         ; ... header
        LDB     #$02        ; Get object ...
        JSR     $0A27       ; ... short name
        BCC     $EFB        ; No short name ... out with OK
        LEAX    1,X         ; Skip the 2
        JSR     $114C       ; Print packed message at X
        PULS    X           ; Restore script
        CLRA                ; Return ...
        RTS                 ; ... OK

;##Com12_Print2ndNounShortName
        PSHS    X           ; Save script pointer
        LDX     $01CC       ; 2nd noun data
        LDA     $01C9       ; 2nd noun index
        BRA     $EDA        ; Print short name

;##Com15_CheckObjBits
; Check target bits in an object.
        PSHS    X           ; Hold script pointer
        LDX     $01C0       ; Input object pointer
        LDA     $01BF       ; Var object number
        BEQ     $F21        ; No object ... return error
        JSR     $0A42       ; Skip the pointer-to-next object
        LEAX    2,X         ; Skip to data byte
        LDA     ,X          ; Get the object data
        PULS    X           ; Restore the script
        ANDA    ,X          ; Mask off all but target bits
        EORA    ,X+         ; Check target bits  (a 1 result in a pass)
        RTS                 ; Done

        PULS    X           ; Restore script pointer
        LEAX    1,X         ; Skip data
        ORA     #$01        ; Set error
        RTS                 ; Return

;##Com14_ExecuteCommandAndReverseReturn
        JSR     $0C03       ; Execute command
        BNE     $F30        ; Command returned a non-zero ... return zero
        ORA     #$01        ; Command returned a zero ... return non-zerio
        RTS                 ; Done
        CLRA                ; Zero
        RTS                 ; Done

;##Com17_MoveObjectXToLocationY
        LDB     ,X+         ; Get object number
        PSHS    X           ; Hold script
        JSR     $1133       ; Find object
        JSR     $0A42       ; Skip over length
        PULS    Y           ; Script to Y
        LDA     ,Y+         ; Get new location
        STA     ,X          ; Set object's new location
        EXG     X,Y         ; X now past data
        CLRA                ; OK
        RTS                 ; Done

;##Com18_CheckVarOwnedByActiveObject
        PSHS    X           ; Save script pointer
        LDX     $01C0       ; Var object data
        JSR     $0A42       ; Skip length
        LDB     ,X          ; Location
        PULS    X           ; Restore script
        LBEQ    $08CF       ; Out-of-game ... error and out
        CMPB    $01D2       ; Is this the active object?
        BEQ     $F45        ; Yes ... return OK
        BITB    #$80        ; Test upper bit
        BNE     $F45        ; It is in a room ... error and out
;
        PSHS    X           ; Hold script
        JSR     $1133       ; Look up owner object
        BRA     $F4B        ; Check again

; Execute any turn-scripts on the objects
        LDX     #$20FF      ; Start of object data
        CLR     $01D0       ; Object number
        JSR     $0A42       ; Skip length
        JSR     $0A58       ; End of objects?
        BCC     $F45        ; Yes ... out
        INC     $01D0       ; Next object number
        PSHS    Y           ; Hold end-of-objects
        JSR     $0A42       ; Skip length
        LDA     ,X          ; Location
        STA     $01AB       ; Hold
        PSHS    Y           ; End of object
        LDA     ,X          ; Location
        BEQ     $FC9        ; If it is out-of-game it doesn't get a turn
        LEAX    3,X         ; Skip data
        LDB     #$08        ; Turn-script
        JSR     $0A27       ; Find turn script
        BCC     $FC9        ; Nothing to do ... next object
        JSR     $0A42       ; Skip length
        PSHS    X           ; Hold pointer
        JSR     $12A8       ; Generate random number
        LDB     $01D0       ; Current object number ...
        STB     $01D2       ; ... is now the active object
        JSR     $1133       ; Get its data pointer
        STX     $01D3       ; Hold pointer to active object data
        LDB     $01AB       ; Object's location
        TSTB                ; Check upper bit
        BMI     $FB8        ; If in a room ... go handle
        JSR     $1133       ; Get object's owner
        JSR     $0A42       ; Skip length
        LDB     ,X          ; Get owner location
        BNE     $FA7        ; Still in game ... find room location of owner chain
        PULS    X           ; Restore pointer
        BRA     $FC9        ; Next object
        STB     $01D5       ; Objects location
        LDX     #$1523      ; Get room ...
        JSR     $0A1F       ; ... scripts for object
        STX     $01D6       ; Hold
        PULS    X           ; Restore turn-script
        JSR     $0C03       ; Execute turn-script
        PULS    X           ; Restore
        PULS    Y           ; Restore
        BRA     $F6F        ; Next object

;##Com05_IsRandomLessOrEqual
        LDA     $1338       ; Random value
        CMPA    ,X+         ; Compare random value to script
        BCS     $FDB        ; If less than ... OK
        BEQ     $FDB        ; If the same ... OK
        ORA     #$01        ; Greater than ... FAIL
        RTS                 ; Done
        CLRA                ; Less than or equal ... OK
        RTS                 ; Done

;##Com1D_AttackObject
        LDA     ,X+         ; Get attack value
        STA     $01AB       ; Hold attack value
        PSHS    X           ; Hold script
        LDX     $01C0       ; Target object data
        JSR     $0A42       ; Skip length
        LEAX    3,X         ; Skip object data
        PSHS    X           ; Hold X ...
        PSHS    Y           ; ... and Y
        LDB     #$09        ; Get target's ...
        JSR     $0A27       ; ... combat info
        BCC     $1020       ; Not found. Do nothing (return OK)
        JSR     $0A42       ; Skip length
        LEAX    1,X         ; Hit points
        LDA     ,X          ; Hit points
        SUBA    $01AB       ; Subtract attack from hit points
        BCC     $1004       ; Not negative ... keep it
        CLRA                ; Floor the hit points
        STA     ,X          ; New hit points
        PULS    Y           ; Restore ...
        PULS    X           ; ... X and Y
        TSTA                ; Hit points zero?
        BEQ     $1011       ; Yes ... object dies
        PULS    X           ; Restore list
        CLRA                ; Return OK
        RTS                 ; Done

;Handle object being killed
        LDB     #$0A        ; Object being killed script
        JSR     $0A27       ; Find a script for handling being killed
        BCC     $100D       ; Not found ... nothing happens (return OK)
        JSR     $0A42       ; Skip id and length
        JSR     $0C03       ; Execute "being killed" script
        BRA     $100D       ; Done (return OK)

        PULS    Y           ; Reset ...
        PULS    X           ; ... stack
        BRA     $100D       ; Return OK

;##Com1E_SwapObjects
        LDB     ,X+         ; 1st object number
        LDA     ,X+         ; 2nd object
        STA     $01AB       ; Hold second object
        PSHS    X           ; Hold script
        JSR     $1133       ; Look up object
        JSR     $0A42       ; Skip length
        TFR     X,U         ; 1st object pointer to U
        LDB     $01AB       ; 2nd object
        JSR     $1133       ; Look up object
        JSR     $0A42       ; Skip length
        LDA     ,X          ; Swap ...
        LDB     ,U          ; ... location ...
        STA     ,U          ; ... of ...
        STB     ,X          ; ... objects

        PULS    X           ; Restore script pointer
        CLRA                ; Z=1 OK
        RTS                 ; Done

;##Com22_CompareHealthToValue
        LDA     ,X+         ; Get value
        PSHS    X           ; Hold script pointer
        STA     $01AB       ; Hold value
        LDX     $01C0       ; Var object data
        JSR     $0A42       ; Skip length
        LEAX    3,X         ; Skip data
        LDB     #$09        ; Get object ...
        JSR     $0A27       ; ... hit points
        BCC     $1070       ; Doesn't have any ... error and out
        JSR     $0A42       ; Skip length
        LEAX    1,X         ; Get current ...
        LDA     ,X          ; ... hit points
        CMPA    $01AB       ; Compare hit points to value
        BCS     $1075       ; Less than ..
        BEQ     $1075       ; ... or equal ... OK and out
        PULS    X           ; Restore script
        ORA     #$01        ; Error
        RTS                 ; Done
        PULS    X           ; Restore script
        CLRA                ; OK
        RTS                 ; Done

;##Com23_HealVarObject
        LDA     ,X+         ; Get healing value
        STA     $01AB       ; Hold it
        PSHS    X           ; Hold script
        LDX     $01C0       ; Var object data
        JSR     $0A42       ; Skip length
        LEAX    3,X         ; Skip data
        LDB     #$09        ; Get object ...
        JSR     $0A27       ; ... hit points
        BCC     $1075       ; No entry ... do nothing (but OK)
        JSR     $0A42       ; Skip length
        LDD     ,X          ; Get HP info
        ADDB    $01AB       ; Add to health
        STA     $01AB       ; Max value
        CMPB    $01AB       ; Over the max?
        BCS     $10A2       ; No ... keep it
        LDB     $01AB       ; Use max value
        LEAX    1,X         ; Store ...
        STB     ,X          ; ... new health
        BRA     $1075       ; OK out

;##Com25_RestartGame
; No return to script
        LDA     #$0D        ; Print first ...
        JSR     $1184       ; ... CR
        LDA     #$0D        ; Print second ...
        JSR     $1184       ; ... CR
        JMP     $060C       ; Restart game

;##Com24_EndlessLoop
        BRA     $10B5       ; Spin forever

; This snippet of code is never called by anyone, but this is a print
; for null-terminate ASCII strings. Presumably the PrintScore function
; used this at one time.

        LDA     ,Y+         ; Get next character
        BEQ     $10C4       ; Null means done
        PSHS    Y           ; Hold Y
        JSR     $1184       ; Print character
        PULS    Y           ; Restore Y
        BRA     $10B7       ; Keep going
        RTS                 ; Done

;##Com26_PrintScore
; Second byte of object data is points. If the object is in the
; treasure room (dropped or carried) it counts double.
        PSHS    X           
        CLR     $01AF       ; Score tally
        CLR     $01B0       
        LDA     $01D5       ; Player location
        CMPA    #$96        ; Player in the treasure room?
        BNE     $10D7       ; No ... regular score
        INC     $01B0       ; Yes ... carried objects count double
        LDX     #$20FF      ; Object data
        JSR     $0A42       ; Skip header
        JSR     $0A58       ; Reached end?
        BCC     $110F       ; Yes ... move on
        PSHS    Y           ; Hold end
        JSR     $0A42       ; Skip object length
        LDB     ,X+         ; Get owner
        CMPB    #$96        ; Treasure room?
        BEQ     $10F1       ; Yes ... count it
        CMPB    #$1D        ; Carried by user?
        BNE     $1109       ; No ... next object
        LDA     $01AF       ; Score tally
        ADDA    ,X          ; Add to score value
        DAA                 ; Decimal adjust
        STA     $01AF       ; New score
        CMPB    #$96        ; Treasure room?
        BEQ     $1103       ; Yes ... counts double
        TST     $01B0       ; Player in treasure room?
        BEQ     $1109       ; No ... just count once
        ADDA    ,X          ; Double ...
        DAA                 ; ... the ...
        STA     $01AF       ; ... score value
        TFR     Y,X         ; Next object
        PULS    Y           ; Restore end of list
        BRA     $10DD       ; Do all objects
;        
        LDA     $01AF       ; Score value
        ASRA                ; Left ...
        ASRA                ; ... most ...
        ASRA                ; ... digit ...
        ASRA                ; ... value
        ADDA    #$30        ; Convert to ASCII
        JSR     $1184       ; Print the left digit
        LDA     $01AF       ; Score value
        ANDA    #$0F        ; Mask off the right digit
        ADDA    #$30        ; Convert ot ASCII
        JSR     $1184       ; Print the right digit
        LDA     #$2E        ; Print ...
        JSR     $1184       ; ... "."
        LDA     #$20        ; Print ...
        JSR     $1184       ; ... SPACE
        PULS    X           ; Restore script
        CLRA                ; OK
        RTS                 ; Done

; Find object index in B
        LDX     #$20FF      ; Start of objects
        JSR     $0A42       ; Skip end
        DECB                ; Found desired object?
        BEQ     $10C4       ; Yes ... out OK
        JSR     $0A42       ; Length of object
        EXG     X,Y         ; Next object
        BRA     $1139       ; Keep looking

; Print packed message and CR
        JSR     $114C       ; Print packed message at X
        LDA     #$0D        ; Print ...
        JSR     $1184       ; ... CR
        RTS                 ; Done

;##PrintPackedMessage
; X points to compressed string. First byte (or two) is the length.
        CLRA                ; Assume MSB is 0
        LDB     ,X          ; Get length
        BITB    #$80        ; Is it single byte length?
        BEQ     $1157       ; Yes ... use D
        LDA     ,X+         ; Get the ...
        ANDA    #$7F        ; ... MSB and ...
        LDB     ,X+         ; ... LSB
        STD     $01AB       ; Store byte count
        LDD     $01AB       ; Number of bytes left in message
        CMPD    #$0002      ; Less than 2?
        BCS     $1173       ; Yes ... these aren't compressed
        JSR     $11EC       ; Decompress and print two bytes pointed to by X
        LDD     $01AB       ; Get byte count
        SUBD    #$0002      ; Handled 2
        STD     $01AB       ; Store count
        BRA     $115C       ; Keep decompressing
        TSTB                ; Any characters on the end to print?
        BEQ     $117E       ; No ... skip
        LDA     ,X+         ; Get character
        JSR     $1184       ; Print the character
        DECB                ; Decrement count
        BRA     $1173       ; Keeop going
        LDA     #$20        ; Print ...
        JSR     $1184       ; ... space on end
        RTS                 ; Done
 
;##PrintCharacterAutoWrap
; Print character in A to screen. This handles auto word-wrapping and
; auto MORE prompting.
;
        PSHS    B,A         ; Hold B and A
        LDA     $01BE       ; Last printed character
        CMPA    #$20        ; Last printed a space?
        BNE     $11A7       ; No ... print this
        PULS    A,B         ; Hold
        CMPA    #$20        ; Space now?
        BEQ     $11EA       ; Yes ... just ignore
        CMPA    #$2E        ; A '.' ?
        BEQ     $119F       ; Yes. Ignore leading space.
        CMPA    #$3F        ; A '?' ?
        BEQ     $119F       ; Yes. Ignore leading space.
        CMPA    #$21        ; A '!' ?
        BNE     $11A9       ; Yes. Ignore leading space.
        LDU     >$88        ; Back screen ...
        LEAU    -1,U        ; ... pointer up ...
        STU     >$88        ; ... over ignored space
        BRA     $11A9       ; Store and print
        PULS    A,B         ; Restore A and B
        STA     $01BE       ; Last printed character
        JSR     [$A002]     ; Output character
        LDA     >$89        ; LSB of screen position
        CMPA    #$FE        ; Reached end of screen?
        BCS     $11EA       ; No ... done
        LDU     >$88        ; Cursor position
        LEAU    $-21,U      ; Back up to end of current row
        LDA     #$0D        ; CR ...
        JSR     [$A002]     ; ... to screen
        LDA     ,U          ; Find the ...
        CMPA    #$60        ; ... space before ...
        BEQ     $11CB       ; ... the last ...
        LEAU    -1,U        ; ... word ...
        BRA     $11C1       ; ... on the line
        LEAU    1,U         ; Now pointing to last word on line
        LDA     ,U          ; Get next character in buffer
        CMPA    #$60        ; Is it a space?
        BEQ     $11EA       ; Yes ... all done
        PSHS    B           ; Hold B
        LDB     #$60        ; Put ...
        STB     ,U          ; ... space
        PULS    B           ; Restore B
        CMPA    #$60        ; Make sure ...
        BCS     $11E1       ; ... upper ...
        SUBA    #$40        ; ... case
        STA     $01BE       ; Last printed character
        JSR     [$A002]     ; Output to screen
        BRA     $11CB       ; Move overhang to next line
        RTS                 ; Done
        RTS                 ; OOPS

;##UnpackBytes
; Unpack three characters stored in 2 bytes pointed to by X and print to screen.
; Every 2 bytes holds 3 characters. Each character can be from 0 to 39.
; 40*40*40 = 64000 ... totally ingenious.
;
        LDY     #$12A4      ;
        LDB     #$03        ;
        STB     $12A1       ;
        LDA     ,X+         ;
        STA     $01DE       ;
        LDA     ,X+         ;
        STA     $01DD       ;
        LEAY    3,Y         ;
        LDU     #$0028      ;
        STU     $12A2       ;
        LDA     #$11        ;
        STA     $01DA       ;
        CLR     $01DB       ;
        CLR     $01DC       ;
        ROL     $01DE       ;
        ROL     $01DD       ;
        DEC     $01DA       ;
        BEQ     $1256       ;
        LDA     #$00        ;
        ADCA    #$00        ; This algorithm is identical to the decompression
        ASL     $01DC       ; used in Pyramid2000. Check the comments there for
        ROL     $01DB       ; more detail.
        ADDA    $01DC       ;
        SUBA    $12A3       ;
        STA     $01E0       ;
        LDA     $01DB       ;
        SBCA    $12A2       ;
        STA     $01DF       ;
        BCC     $1246       ;
        LDD     $01DF       ;
        ADDD    $12A2       ;
        STD     $01DB       ;
        BRA     $124C       ;
        LDD     $01DF       ;
        STD     $01DB       ;
; Compliment C flag and continue
        BCS     $1252       ;
        ORCC    #$01        ;
        BRA     $1212       ;
        ANDCC   #$FE        ;
        BRA     $1212       ;
; Process the result of the division
        LDD     $01DB       ;
        ADDD    #$1279      ;
        TFR     D,U         ;
        LDA     ,U          ;
        STA     ,-Y         ;
        DEC     $12A1       ;
        BNE     $1201       ;
        LDY     #$12A4      ;
        LDB     #$03        ;
        LDA     ,Y+         ;
        JSR     $1184       ; Print character
        DECB                ;
        BNE     $126D       ;
        LDD     $01AB       ;
        RTS                 ;

; Character translation table
;     ?  !  2  .  "  '  <  >  /  0  3  A  B  C  D  E
22 27 3C 3E 2F 30 33 41 42 43 44 45                 
;     F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T  U
4A 4B 4C 4D 4E 4F 50 51 52 53 54 55                 
5A 2D 2C 2E
;     V  W  X  Y  Z  -  ,  .

00 00 00  ; Temporaries for decompression algorithm above            

; Generate random number
        PSHS    X,B         ; Random number generator. Uses seed at 13B8.
        LDX     #$1338      ;
        LDB     #$17        ;
        LDA     ,X          ;
        LEAX    1,X         ;
        ORCC    #$01        ;
        ANDA    #$06        ;
        BEQ     $12C0       ;
        CMPA    #$06        ;
        ORCC    #$01        ;
        BEQ     $12C0       ;
        CLRA                ;
        LDA     ,X          ;
        BCS     $12C7       ;
        LSRA                ;
        BRA     $12CA       ;
        LSRA                ;
        ORA     #$80        ;
        STA     ,X          ;
        LEAX    -1,X        ;
        LDA     ,X          ;
        BCS     $12D5       ;
        LSRA                ;
        BRA     $12D8       ;
        LSRA                ;
        ORA     #$80        ;
        ANDA    #$FE        ;
        STA     ,X          ;
        DECB                ;
        BNE     $12B1       ;
        LDA     $1339       ;
        PULS    B,X         ;
        RTS                 ;

; -----------------------------------------------------------------------------------------------------------------
; Data Here Down
; -----------------------------------------------------------------------------------------------------------------

;##CommandJumpTable 
L12E5: 0C 81  ; 00            
L12E7: 0D 93  ; 01            
L12E9: 0D A6  ; 02            
L12EB: 0D AB  ; 03            
L12ED: 0D C3  ; 04            
L12EF: 0F CF  ; 05            
L12F1: 0D E9  ; 06            
L12F3: 0D E4  ; 07            
L12F5: 0E 23  ; 08            
L12F7: 0E 41  ; 09           
L12F9: 0E 49  ; 0A            
L12FB: 0C 58  ; 0B            
L12FD: 0D C0  ; 0C           
L12FF: 0C 27  ; 0D           
L1301: 0C 3F  ; 0E            
L1303: 0E 4F  ; 0F           
L1305: 0E 60  ; 10            
L1307: 0E D2  ; 11           
L1309: 0E FF  ; 12            
L130B: 0E 71  ; 13            
L130D: 0F 28  ; 14           
L130F: 0F 09  ; 15            
L1311: 0E C8  ; 16            
L1313: 0F 32  ; 17            
L1315: 0F 46  ; 18            
L1317: 0C 8D  ; 19           
L1319: 0C AE  ; 1A           
L131B: 0C BC  ; 1B            
L131D: 0C CA  ; 1C           
L131F: 0F DD  ; 1D            
L1321: 10 26  ; 1E
L1323: 0D CA  ; 1F          
L1325: 0D A0  ; 20            
L1327: 0C DD  ; 21            
L1329: 10 4C  ; 22                
L132B: 10 79  ; 23               
L132D: 10 B5  ; 24                
L132F: 10 A8  ; 25               
L1331: 10 C5  ; 26
  
; Multi-verb replacement list (code doesn't work that uses this anyway)              
L1333: 00  ; List is the length. List is pointed to by 1331 which is ignored

; Random number seed
L1334: 12 23 44  1D     27 4D  2D 13  
       
;##FeedbackPrompts
; "?VERB?"  
L133C: 06 3F 56 45 52 42 3F                  
;       
; "?WHAT?"
L1343: 06 3F 57 48 41 54 3F          
;          
; "?WHICH?"        
L134A: 07 3F 57 48 49 43 48 3F         
;           
; "?PHRASE?"         
L1352: 08 3F 50 48 52 41 53 45 3F                  

;##PhraseList 
L135B: 05 00 00 00 01                                            ; 01: NORTH *     *          *       
L1360: 06 00 00 00 02                                            ; 02: SOUTH *     *          *       
L1365: 07 00 00 00 03                                            ; 03: EAST *      *          *       
L136A: 08 00 00 00 04                                            ; 04: WEST *      *          *       
L136F: 09 00 20 00 05                                            ; 05: GET *       ..C.....   *       
L1374: 34 07 00 80 05                                            ; 05: PICK UP     *          u.......
L1379: 34 07 80 00 05                                            ; 05: PICK UP     u.......   *       
L137E: 0A 00 20 00 06                                            ; 06: DROP *      ..C.....   *       
L1383: 0A 05 80 80 0F                                            ; 0F: DROP IN     u.......   u.......
L1388: 0A 06 00 88 16                                            ; 16: DROP OUT    *          u...A...
L138D: 0B 00 00 00 07                                            ; 07: INVENT *    *          *       
L1392: 01 00 04 00 08                                            ; 08: READ *      .....X..   *       
L1397: 04 02 10 40 09                                            ; 09: ATTACK WITH ...P....   .v......
L139C: 0C 00 00 00 0A                                            ; 0A: LOOK *      *          *       
L13A1: 0C 03 00 80 0B                                            ; 0B: LOOK AT     *          u.......
L13A6: 0C 04 00 80 0C                                            ; 0C: LOOK UNDER  *          u.......
L13AB: 0C 05 00 80 10                                            ; 10: LOOK IN     *          u.......
L13B0: 03 03 40 10 0D                                            ; 0D: THROW AT    .v......   ...P....
L13B5: 03 05 80 80 39                                            ; 39: THROW IN    u.......   u.......
L13BA: 03 08 00 20 06                                            ; 06: THROW DOWN  *          ..C.....
L13BF: 03 01 80 10 0E                                            ; 0E: THROW TO    u.......   ...P....
L13C4: 0D 01 80 10 0E                                            ; 0E: GIVE TO     u.......   ...P....
L13C9: 0E 00 80 00 0B                                            ; 0B: EXAMIN *    u.......   *       
L13CE: 0E 05 00 80 0B                                            ; 0B: EXAMIN IN   *          u.......
L13D3: 0F 00 80 00 11                                            ; 11: OPEN *      u.......   *       
L13D8: 0F 02 80 80 3A                                            ; 3A: OPEN WITH   u.......   u.......
L13DD: 10 00 80 00 12                                            ; 12: PULL *      u.......   *       
L13E2: 10 08 00 80 12                                            ; 12: PULL DOWN   *          u.......
L13E7: 10 06 00 80 05                                            ; 05: PULL OUT    *          u.......
L13EC: 10 06 80 00 05                                            ; 05: PULL OUT    u.......   *       
L13F1: 10 07 00 80 2D                                            ; 2D: PULL UP     *          u.......
L13F6: 10 07 80 00 2D                                            ; 2D: PULL UP     u.......   *       
L13FB: 11 02 88 88 14                                            ; 14: LIGHT WITH  u...A...   u...A...
L1400: 12 00 80 00 15                                            ; 15: EAT *       u.......   *       
L1405: 13 06 00 88 16                                            ; 16: BLOW OUT    *          u...A...
L140A: 14 00 88 00 16                                            ; 16: EXTING *    u...A...   *       
L140F: 15 00 80 00 17                                            ; 17: CLIMB *     u.......   *       
L1414: 15 07 00 80 17                                            ; 17: CLIMB UP    *          u.......
L1419: 15 08 00 80 17                                            ; 17: CLIMB DOWN  *          u.......
L141E: 15 09 00 80 17                                            ; 17: CLIMB OVER  *          u.......
L1423: 15 0C 00 80 17                                            ; 17: CLIMB ON    *          u.......
L1428: 15 05 00 00 36                                            ; 36: CLIMB IN    *          *       
L142D: 15 05 00 80 36                                            ; 36: CLIMB IN    *          u.......
L1432: 15 06 00 00 37                                            ; 37: CLIMB OUT   *          *       
L1437: 15 06 00 80 37                                            ; 37: CLIMB OUT   *          u.......
L143C: 15 04 00 80 38                                            ; 38: CLIMB UNDER *          u.......
L1441: 16 00 80 00 18                                            ; 18: RUB *       u.......   *       
L1446: 18 00 00 00 1A                                            ; 1A: ??? *       *          *       
L144B: 05 01 00 00 01                                            ; 01: NORTH TO    *          *       
L1450: 06 01 00 00 02                                            ; 02: SOUTH TO    *          *       
L1455: 07 01 00 00 03                                            ; 03: EAST TO     *          *       
L145A: 08 01 00 00 04                                            ; 04: WEST TO     *          *       
L145F: 0A 08 00 20 06                                            ; 06: DROP DOWN   *          ..C.....
L1464: 0A 08 20 00 06                                            ; 06: DROP DOWN   ..C.....   *       
L1469: 0A 0A 20 80 06                                            ; 06: DROP BEHIND ..C.....   u.......
L146E: 0A 04 20 80 06                                            ; 06: DROP UNDER  ..C.....   u.......
L1473: 0A 0C 20 80 06                                            ; 06: DROP ON     ..C.....   u.......
L1478: 0C 07 00 00 0A                                            ; 0A: LOOK UP     *          *       
L147D: 0C 08 00 00 0A                                            ; 0A: LOOK DOWN   *          *       
L1482: 0C 09 80 00 0B                                            ; 0B: LOOK OVER   u.......   *       
L1487: 0C 09 00 80 0B                                            ; 0B: LOOK OVER   *          u.......
L148C: 0C 0B 00 00 0A                                            ; 0A: LOOK AROUND *          *       
L1491: 0C 0A 00 00 0A                                            ; 0A: LOOK BEHIND *          *       
L1496: 0C 0B 00 80 1B                                            ; 1B: LOOK AROUND *          u.......
L149B: 0C 0A 00 80 1C                                            ; 1C: LOOK BEHIND *          u.......
L14A0: 32 00 00 00 21                                            ; 21: PLUGH *     *          *       
L14A5: 2B 00 00 00 22                                            ; 22: SCREAM *    *          *       
L14AA: 2D 00 00 00 23                                            ; 23: QUIT *      *          *       
L14AF: 2C 00 00 00 25                                            ; 25: LEAVE *     *          *       
L14B4: 2C 00 20 00 06                                            ; 06: LEAVE *     ..C.....   *       
L14B9: 21 00 00 00 25                                            ; 25: GO *        *          *       
L14BE: 21 01 00 80 3D                                            ; 3D: GO TO       *          u.......
L14C3: 21 05 00 80 36                                            ; 36: GO IN       *          u.......
L14C8: 21 06 00 80 37                                            ; 37: GO OUT      *          u.......
L14CD: 21 04 00 80 38                                            ; 38: GO UNDER    *          u.......
L14D2: 21 07 00 80 17                                            ; 17: GO UP       *          u.......
L14D7: 21 08 00 80 17                                            ; 17: GO DOWN     *          u.......
L14DC: 21 0B 00 80 26                                            ; 26: GO AROUND   *          u.......
L14E1: 23 00 80 00 27                                            ; 27: KICK *      u.......   *       
L14E6: 23 08 00 80 27                                            ; 27: KICK DOWN   *          u.......
L14EB: 23 05 00 80 27                                            ; 27: KICK IN     *          u.......
L14F0: 24 02 10 80 28                                            ; 28: FEED WITH   ...P....   u.......
L14F5: 24 01 80 10 29                                            ; 29: FEED TO     u.......   ...P....
L14FA: 28 00 00 00 2C                                            ; 2C: SCORE *     *          *       
L14FF: 1C 00 80 00 2D                                            ; 2D: LIFT *      u.......   *       
L1504: 1F 00 00 00 2F                                            ; 2F: WAIT *      *          *       
L1509: 1F 0B 00 00 2F                                            ; 2F: WAIT AROUND *          *       
L150E: 09 07 00 00 2F                                            ; 2F: GET UP      *          *       
L1513: 20 09 00 80 34                                            ; 34: JUMP OVER   *          u.......
L1518: 20 05 00 80 36                                            ; 36: JUMP IN     *          u.......
L151D: 20 06 00 80 37                                            ; 37: JUMP OUT    *          u.......
L1522: 00 


;##RoomDescriptions
L1523: 00 8B D9                                                  ; Script list size=0BD9
L1526:   81 5E 00                                                ;   Script number=81 size=005E data=00
L1529:     03 52                                                 ;     Data tag=03 size=0052
L152B:       C7 DE 94 14 4B 5E 83 96 5F 17 46 48                 ;       YOU ARE IN A SMALL ROOM WITH GRANITE WALLS
L1537:       39 17 DB 9F 56 D1 09 71 D0 B0 7F 7B                 ;       AND FLOOR. THERE IS A SMALL OPENING TO THE
L1543:       F3 17 0D 8D 90 14 08 58 81 8D 1B B5                 ;       EAST AND A LARGE HOLE IN THE CEILING.
L154F:       5F BE 5B B1 4B 7B 55 45 8E 91 11 8A                 ;       .
L155B:       F0 A4 91 7A 89 17 82 17 47 5E 66 49                 ;       .
L1567:       90 14 03 58 3B 16 B7 B1 A9 15 DB 8B                 ;       .
L1573:       83 7A 5F BE D7 14 43 7A CF 98                       ;       .
L157D:   04 07                                                   ;     Data tag=04 size=0007
L157F:         0B 05                                             ;         Command_0B_SWITCH size=05
L1581:           0A 03                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1583:           02                                              ;           IF_NOT_JUMP address=1586
L1584:             00 82                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=82
L1586:   82 80 C4 00                                             ;   Script number=82 size=00C4 data=00
L158A:     03 80 AB                                              ;     Data tag=03 size=00AB
L158D:       C7 DE 94 14 4B 5E 83 96 3B 16 B7 B1                 ;       YOU ARE IN A LARGE RECTANGULAR ROOM. ON THE
L1599:       2F 17 FB 55 C7 98 54 8B 39 17 FF 9F                 ;       FLOOR OF THE EAST SIDE OF THE ROOM IS AN
L15A5:       C0 16 82 17 48 5E 81 8D 91 AF 96 64                 ;       INTRICATE ORIENTAL RUG STRETCHING BETWEEN
L15B1:       DB 72 95 5F 15 BC FF 78 B8 16 82 17                 ;       THE NORTH AND SOUTH WALLS. IN THE EAST WALL
L15BD:       54 5E 3F A0 D5 15 90 14 D0 15 F3 BF                 ;       IS A HUGE CARVED WOODEN DOOR. TO THE SOUTH,
L15C9:       16 53 51 5E 07 B2 BB 9A 14 8A 6B C4                 ;       A SMALL HOLE LEADS TO A DARK PASSAGE WAY.
L15D5:       0C BA 7D 62 90 73 C4 6A 91 62 30 60                 ;       .
L15E1:       82 17 50 5E BE A0 03 71 33 98 47 B9                 ;       .
L15ED:       53 BE 0E D0 2F 8E D0 15 82 17 47 5E                 ;       .
L15F9:       66 49 F3 17 F3 8C 4B 7B 4A 45 77 C4                 ;       .
L1605:       D3 14 0F B4 19 58 36 A0 83 61 81 5B                 ;       .
L1611:       1B B5 6B BF 5F BE 61 17 82 C6 03 EE                 ;       .
L161D:       5F 17 46 48 A9 15 DB 8B E3 8B 0B 5C                 ;       .
L1629:       6B BF 46 45 35 49 DB 16 D3 B9 9B 6C                 ;       .
L1635:       1B D0 2E                                            ;       .
L1638:     04 13                                                 ;     Data tag=04 size=0013
L163A:         0B 11                                             ;         Command_0B_SWITCH size=11
L163C:           0A 04                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L163E:           02                                              ;           IF_NOT_JUMP address=1641
L163F:             00 81                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=81
L1641:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1642:           02                                              ;           IF_NOT_JUMP address=1645
L1643:             00 83                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=83
L1645:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1646:           06                                              ;           IF_NOT_JUMP address=164D
L1647:             0D 04                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=4
L1649:               20 1D                                       ;               Command_20_CHECK_ACTIVE_OBJECT object=1D(USER)
L164B:               8B                                          ;               CommonCommand_8B
L164C:               81                                          ;               CommonCommand_81
L164D:   83 3A 00                                                ;   Script number=83 size=003A data=00
L1650:     03 2A                                                 ;     Data tag=03 size=002A
L1652:       C7 DE 94 14 4B 5E 83 96 FB 14 4B B2                 ;       YOU ARE IN A DARK PASSAGE WAY WHICH SLOPES
L165E:       55 A4 09 B7 59 5E 3B 4A 23 D1 13 54                 ;       UP AND TO THE SOUTH.
L166A:       C9 B8 F5 A4 B2 17 90 14 16 58 D6 9C                 ;       .
L1676:       DB 72 47 B9 77 BE                                   ;       .
L167C:     04 0B                                                 ;     Data tag=04 size=000B
L167E:         0B 09                                             ;         Command_0B_SWITCH size=09
L1680:           0A 01                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L1682:           02                                              ;           IF_NOT_JUMP address=1685
L1683:             00 82                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=82
L1685:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1686:           02                                              ;           IF_NOT_JUMP address=1689
L1687:             00 84                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=84
L1689:   84 67 00                                                ;   Script number=84 size=0067 data=00
L168C:     03 53                                                 ;     Data tag=03 size=0053
L168E:       C7 DE 94 14 43 5E 16 BC DB 72 82 BF                 ;       YOU ARE AT THE TOP OF A PASSAGE WHICH SLOPES
L169A:       B8 16 7B 14 55 A4 09 B7 59 5E 85 73                 ;       DOWN AND TO THE NORTH. THERE IS A CORRIDOR
L16A6:       15 71 82 8D 4B 62 89 5B 83 96 33 98                 ;       TO THE EAST AND ANOTHER TO THE WEST.
L16B2:       6B BF 5F BE 99 16 C2 B3 56 F4 F4 72                 ;       .
L16BE:       4B 5E C3 B5 E1 14 73 B3 84 5B 89 17                 ;       .
L16CA:       82 17 47 5E 66 49 90 14 03 58 06 9A                 ;       .
L16D6:       F4 72 89 17 82 17 59 5E 66 62 2E                    ;       .
L16E1:     04 0F                                                 ;     Data tag=04 size=000F
L16E3:         0B 0D                                             ;         Command_0B_SWITCH size=0D
L16E5:           0A 01                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L16E7:           02                                              ;           IF_NOT_JUMP address=16EA
L16E8:             00 83                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=83
L16EA:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L16EB:           02                                              ;           IF_NOT_JUMP address=16EE
L16EC:             00 A1                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A1
L16EE:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L16EF:           02                                              ;           IF_NOT_JUMP address=16F2
L16F0:             00 85                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=85
L16F2:   85 44 00                                                ;   Script number=85 size=0044 data=00
L16F5:     03 26                                                 ;     Data tag=03 size=0026
L16F7:       63 BE CB B5 C3 B5 73 17 1B B8 E6 A4                 ;       THIS IS A T SHAPED ROOM WITH EXITS EAST,
L1703:       39 17 DB 9F 56 D1 07 71 96 D7 C7 B5                 ;       SOUTH, AND WEST.
L170F:       66 49 15 EE 36 A1 73 76 8E 48 F7 17                 ;       .
L171B:       17 BA                                               ;       .
L171D:     04 19                                                 ;     Data tag=04 size=0019
L171F:         0B 17                                             ;         Command_0B_SWITCH size=17
L1721:           0A 04                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1723:           02                                              ;           IF_NOT_JUMP address=1726
L1724:             00 84                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=84
L1726:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1727:           02                                              ;           IF_NOT_JUMP address=172A
L1728:             00 86                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=86
L172A:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L172B:           0C                                              ;           IF_NOT_JUMP address=1738
L172C:             0D 0A                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=10
L172E:               00 88                                       ;               Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=88
L1730:               14                                          ;               Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L1731:                 0D 05                                     ;                 Command_0D_EXECUTE_LIST_WHILE_PASS size=5
L1733:                   20 1D                                   ;                   Command_20_CHECK_ACTIVE_OBJECT object=1D(USER)
L1735:                   01 07                                   ;                   Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=07(StatueWest)
L1737:                   82                                      ;                   CommonCommand_82
L1738:   86 3F 00                                                ;   Script number=86 size=003F data=00
L173B:     03 2F                                                 ;     Data tag=03 size=002F
L173D:       C7 DE 94 14 4B 5E 83 96 39 17 DB 9F                 ;       YOU ARE IN A ROOM WITH GRAY STONE WALLS.
L1749:       56 D1 09 71 DB B0 66 17 0F A0 F3 17                 ;       PASSAGES LEAD NORTH AND EAST.
L1755:       0D 8D 52 F4 65 49 77 47 CE B5 86 5F                 ;       .
L1761:       99 16 C2 B3 90 14 07 58 66 49 2E                    ;       .
L176C:     04 0B                                                 ;     Data tag=04 size=000B
L176E:         0B 09                                             ;         Command_0B_SWITCH size=09
L1770:           0A 01                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L1772:           02                                              ;           IF_NOT_JUMP address=1775
L1773:             00 85                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=85
L1775:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1776:           02                                              ;           IF_NOT_JUMP address=1779
L1777:             00 87                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=87
L1779:   87 44 00                                                ;   Script number=87 size=0044 data=00
L177C:     03 2F                                                 ;     Data tag=03 size=002F
L177E:       63 BE CB B5 C3 B5 39 17 8E C5 39 17                 ;       THIS IS A ROUND ROOM WITH HIGH WALLS. THE
L178A:       DB 9F 56 D1 0A 71 7A 79 F3 17 0D 8D                 ;       ONLY OPENING IS TO THE WEST.
L1796:       56 F4 DB 72 16 A0 51 DB F0 A4 91 7A                 ;       .
L17A2:       D5 15 89 17 82 17 59 5E 66 62 2E                    ;       .
L17AD:     04 10                                                 ;     Data tag=04 size=0010
L17AF:         0B 0E                                             ;         Command_0B_SWITCH size=0E
L17B1:           0A 05                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=05 phrase="05: GET *       ..C.....   *       "
L17B3:           07                                              ;           IF_NOT_JUMP address=17BB
L17B4:             0D 05                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=5
L17B6:               08 08                                       ;               Command_08_COMPARE_OBJECT_TO_FIRST_NOUN object=08(GoldRing
L17B8:               19 8C                                       ;               Command_19_MOVE_ACTIVE_OBJECT_TO_ROOM room=8C
L17BA:               0C                                          ;               Command_0C_FAIL
L17BB:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L17BC:           02                                              ;           IF_NOT_JUMP address=17BF
L17BD:             00 86                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=86
L17BF:   88 79 00                                                ;   Script number=88 size=0079 data=00
L17C2:     03 57                                                 ;     Data tag=03 size=0057
L17C4:       C7 DE 94 14 4B 5E 83 96 8C 17 90 78                 ;       YOU ARE IN A TRIANGULAR ROOM WITH OPENINGS
L17D0:       2E 6F 23 49 01 B3 59 90 82 7B C2 16                 ;       IN THE EAST AND WEST CORNERS. THERE IS A
L17DC:       93 61 C5 98 D0 15 82 17 47 5E 66 49                 ;       STATUE IN THE SOUTH CORNER WITH BOW AND
L17E8:       90 14 19 58 66 62 E1 14 CF B2 AF B3                 ;       ARROW.
L17F4:       82 17 2F 62 D5 15 7B 14 FB B9 67 C0                 ;       .
L1800:       D0 15 82 17 55 5E 36 A1 05 71 B8 A0                 ;       .
L180C:       23 62 56 D1 04 71 6B A1 8E 48 94 14                 ;       .
L1818:       09 B3 2E                                            ;       .
L181B:     04 1D                                                 ;     Data tag=04 size=001D
L181D:         0B 1B                                             ;         Command_0B_SWITCH size=1B
L181F:           0A 04                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1821:           0B                                              ;           IF_NOT_JUMP address=182D
L1822:             0E 09                                         ;             Command_0E_EXECUTE_LIST_WHILE_FAIL size=9
L1824:               0D 05                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=5
L1826:                 20 1D                                     ;                 Command_20_CHECK_ACTIVE_OBJECT object=1D(USER)
L1828:                 01 07                                     ;                 Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=07(StatueWest)
L182A:                 82                                        ;                 CommonCommand_82
L182B:               00 85                                       ;               Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=85
L182D:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L182E:           0B                                              ;           IF_NOT_JUMP address=183A
L182F:             0E 09                                         ;             Command_0E_EXECUTE_LIST_WHILE_FAIL size=9
L1831:               0D 05                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=5
L1833:                 20 1D                                     ;                 Command_20_CHECK_ACTIVE_OBJECT object=1D(USER)
L1835:                 01 06                                     ;                 Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=06(StatueEast)
L1837:                 82                                        ;                 CommonCommand_82
L1838:               00 89                                       ;               Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=89
L183A:   89 5D 00                                                ;   Script number=89 size=005D data=00
L183D:     03 3F                                                 ;     Data tag=03 size=003F
L183F:       C7 DE 94 14 43 5E 16 BC DB 72 47 B9                 ;       YOU ARE AT THE SOUTH END OF THE GREAT
L184B:       53 BE 8E 61 B8 16 82 17 49 5E 63 B1                 ;       CENTRAL HALLWAY. EXITS EXIST IN THE EAST AND
L1857:       05 BC 9E 61 CE B0 9B 15 11 8D 5F 4A                 ;       WEST WALLS.
L1863:       3A 15 8D 7B 3A 15 66 7B D0 15 82 17                 ;       .
L186F:       47 5E 66 49 90 14 19 58 66 62 F3 17                 ;       .
L187B:       0D 8D 2E                                            ;       .
L187E:     04 19                                                 ;     Data tag=04 size=0019
L1880:         0B 17                                             ;         Command_0B_SWITCH size=17
L1882:           0A 04                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1884:           0C                                              ;           IF_NOT_JUMP address=1891
L1885:             0D 0A                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=10
L1887:               00 88                                       ;               Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=88
L1889:               14                                          ;               Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L188A:                 0D 05                                     ;                 Command_0D_EXECUTE_LIST_WHILE_PASS size=5
L188C:                   20 1D                                   ;                   Command_20_CHECK_ACTIVE_OBJECT object=1D(USER)
L188E:                   01 06                                   ;                   Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=06(StatueEast)
L1890:                   82                                      ;                   CommonCommand_82
L1891:           01                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L1892:           02                                              ;           IF_NOT_JUMP address=1895
L1893:             00 90                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=90
L1895:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1896:           02                                              ;           IF_NOT_JUMP address=1899
L1897:             00 8A                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=8A
L1899:   8A 3A 00                                                ;   Script number=8A size=003A data=00
L189C:     03 26                                                 ;     Data tag=03 size=0026
L189E:       63 BE CB B5 C3 B5 73 17 1B B8 E6 A4                 ;       THIS IS A T SHAPED ROOM WITH EXITS EAST,
L18AA:       39 17 DB 9F 56 D1 07 71 96 D7 C7 B5                 ;       SOUTH, AND WEST.
L18B6:       66 49 15 EE 36 A1 73 76 8E 48 F7 17                 ;       .
L18C2:       17 BA                                               ;       .
L18C4:     04 0F                                                 ;     Data tag=04 size=000F
L18C6:         0B 0D                                             ;         Command_0B_SWITCH size=0D
L18C8:           0A 04                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L18CA:           02                                              ;           IF_NOT_JUMP address=18CD
L18CB:             00 89                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=89
L18CD:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L18CE:           02                                              ;           IF_NOT_JUMP address=18D1
L18CF:             00 8B                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=8B
L18D1:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L18D2:           02                                              ;           IF_NOT_JUMP address=18D5
L18D3:             00 8D                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=8D
L18D5:   8B 3F 00                                                ;   Script number=8B size=003F data=00
L18D8:     03 2F                                                 ;     Data tag=03 size=002F
L18DA:       C7 DE 94 14 4B 5E 83 96 39 17 DB 9F                 ;       YOU ARE IN A ROOM WITH GREY STONE WALLS.
L18E6:       56 D1 09 71 7B B1 66 17 0F A0 F3 17                 ;       PASSAGES LEAD NORTH AND EAST.
L18F2:       0D 8D 52 F4 65 49 77 47 CE B5 86 5F                 ;       .
L18FE:       99 16 C2 B3 90 14 07 58 66 49 2E                    ;       .
L1909:     04 0B                                                 ;     Data tag=04 size=000B
L190B:         0B 09                                             ;         Command_0B_SWITCH size=09
L190D:           0A 01                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L190F:           02                                              ;           IF_NOT_JUMP address=1912
L1910:             00 8A                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=8A
L1912:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1913:           02                                              ;           IF_NOT_JUMP address=1916
L1914:             00 8C                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=8C
L1916:   8C 44 00                                                ;   Script number=8C size=0044 data=00
L1919:     03 2F                                                 ;     Data tag=03 size=002F
L191B:       63 BE CB B5 C3 B5 39 17 8E C5 39 17                 ;       THIS IS A ROUND ROOM WITH HIGH WALLS. THE
L1927:       DB 9F 56 D1 0A 71 7A 79 F3 17 0D 8D                 ;       ONLY OPENING IS TO THE WEST.
L1933:       56 F4 DB 72 16 A0 51 DB F0 A4 91 7A                 ;       .
L193F:       D5 15 89 17 82 17 59 5E 66 62 2E                    ;       .
L194A:     04 10                                                 ;     Data tag=04 size=0010
L194C:         0B 0E                                             ;         Command_0B_SWITCH size=0E
L194E:           0A 05                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=05 phrase="05: GET *       ..C.....   *       "
L1950:           07                                              ;           IF_NOT_JUMP address=1958
L1951:             0D 05                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=5
L1953:               08 08                                       ;               Command_08_COMPARE_OBJECT_TO_FIRST_NOUN object=08(GoldRing
L1955:               19 87                                       ;               Command_19_MOVE_ACTIVE_OBJECT_TO_ROOM room=87
L1957:               0C                                          ;               Command_0C_FAIL
L1958:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1959:           02                                              ;           IF_NOT_JUMP address=195C
L195A:             00 8B                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=8B
L195C:   8D 4D 00                                                ;   Script number=8D size=004D data=00
L195F:     03 3D                                                 ;     Data tag=03 size=003D
L1961:       C7 DE 94 14 4B 5E 83 96 DF 16 96 BE                 ;       YOU ARE IN A PETITE CHAMBER. THERE IS A
L196D:       45 5E 4F 72 74 4D 56 F4 F4 72 4B 5E                 ;       LARGER ROOM TO THE NORTH AND A PASSAGE TO
L1979:       C3 B5 3B 16 B7 B1 94 AF 3F A0 89 17                 ;       THE WEST.
L1985:       82 17 50 5E BE A0 03 71 33 98 52 45                 ;       .
L1991:       65 49 77 47 89 17 82 17 59 5E 66 62                 ;       .
L199D:       2E                                                  ;       .
L199E:     04 0B                                                 ;     Data tag=04 size=000B
L19A0:         0B 09                                             ;         Command_0B_SWITCH size=09
L19A2:           0A 04                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L19A4:           02                                              ;           IF_NOT_JUMP address=19A7
L19A5:             00 8A                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=8A
L19A7:           01                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L19A8:           02                                              ;           IF_NOT_JUMP address=19AB
L19A9:             00 8E                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=8E
L19AB:   8E 80 A2 00                                             ;   Script number=8E size=00A2 data=00
L19AF:     03 3B                                                 ;     Data tag=03 size=003B
L19B1:       C7 DE 94 14 4B 5E 83 96 3B 16 B7 B1                 ;       YOU ARE IN A LARGE ROOM WHICH SMELLS OF
L19BD:       39 17 DB 9F 23 D1 13 54 E7 B8 0D 8D                 ;       DECAYING FLESH. THERE ARE EXITS NORTH AND
L19C9:       B8 16 FF 14 1B 53 91 7A 56 15 5A 62                 ;       SOUTH.
L19D5:       56 F4 F4 72 43 5E 5B B1 23 63 0B C0                 ;       .
L19E1:       04 9A 53 BE 8E 48 61 17 82 C6 2E                    ;       .
L19EC:     04 62                                                 ;     Data tag=04 size=0062
L19EE:         0B 60                                             ;         Command_0B_SWITCH size=60
L19F0:           0A 02                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L19F2:           02                                              ;           IF_NOT_JUMP address=19F5
L19F3:             00 8D                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=8D
L19F5:           01                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L19F6:           59                                              ;           IF_NOT_JUMP address=1A50
L19F7:             0E 57                                         ;             Command_0E_EXECUTE_LIST_WHILE_FAIL size=87
L19F9:               0D 1D                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=29
L19FB:                 01 1E                                     ;                 Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=1E(LiveGargoyle)
L19FD:                 20 1D                                     ;                 Command_20_CHECK_ACTIVE_OBJECT object=1D(USER)
L19FF:                 04                                        ;                 Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L1A00:                   17 5F BE 73 15 C1 B1 3F DE B6 14 5D     ;                   THE GARGOYLE BLOCKS THE WAY NORTH.
L1A0C:                   9E D6 B5 DB 72 1B D0 99 16 C2 B3 2E     ;                   .
L1A18:               0D 34                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=52
L1A1A:                 20 1D                                     ;                 Command_20_CHECK_ACTIVE_OBJECT object=1D(USER)
L1A1C:                 01 0A                                     ;                 Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=0A(StoneGargoyle)
L1A1E:                 17 0A 00                                  ;                 Command_17_MOVE_OBJECT_TO_LOCATION object=0A(StoneGargoyle) location=00
L1A21:                 17 1E 8E                                  ;                 Command_17_MOVE_OBJECT_TO_LOCATION object=1E(LiveGargoyle) location=8E
L1A24:                 04                                        ;                 Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L1A25:                   28 5F BE 73 15 C1 B1 3F DE E1 14 35     ;                   THE GARGOYLE COMES TO LIFE AND JUMPS DOWN TO
L1A31:                   92 89 17 43 16 5B 66 8E 48 FF 15 ED     ;                   BLOCK YOUR WAY!
L1A3D:                   93 09 15 03 D2 6B BF 89 4E 8B 54 C7     ;                   .
L1A49:                   DE 99 AF 39 4A                          ;                   .
L1A4E:               00 8F                                       ;               Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=8F
L1A50:   8F 3A 00                                                ;   Script number=8F size=003A data=00
L1A53:     03 2E                                                 ;     Data tag=03 size=002E
L1A55:       63 BE CB B5 C3 B5 7B 17 F3 8C 01 B3                 ;       THIS IS A TALL ROOM CARVED OF STONE WITH A
L1A61:       45 90 40 49 F3 5F C3 9E 09 BA 5B 98                 ;       SINGLE EXIT TO THE SOUTH. 
L1A6D:       56 D1 03 71 5B 17 BE 98 47 5E 96 D7                 ;       .
L1A79:       89 17 82 17 55 5E 36 A1 9B 76                       ;       .
L1A83:     04 07                                                 ;     Data tag=04 size=0007
L1A85:         0B 05                                             ;         Command_0B_SWITCH size=05
L1A87:           0A 02                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1A89:           02                                              ;           IF_NOT_JUMP address=1A8C
L1A8A:             00 8E                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=8E
L1A8C:   90 80 A2 00                                             ;   Script number=90 size=00A2 data=00
L1A90:     03 56                                                 ;     Data tag=03 size=0056
L1A92:       C7 DE 94 14 43 5E 16 BC DB 72 04 9A                 ;       YOU ARE AT THE NORTH END OF THE GREAT
L1A9E:       53 BE 8E 61 B8 16 82 17 49 5E 63 B1                 ;       CENTRAL HALLWAY. EXITS EXIST IN THE EAST AND
L1AAA:       05 BC 9E 61 CE B0 9B 15 11 8D 5F 4A                 ;       WEST WALLS. THERE IS A DOOR ON THE NORTH
L1AB6:       3A 15 8D 7B 3A 15 66 7B D0 15 82 17                 ;       WALL.
L1AC2:       47 5E 66 49 90 14 19 58 66 62 F3 17                 ;       .
L1ACE:       0D 8D 56 F4 F4 72 4B 5E C3 B5 09 15                 ;       .
L1ADA:       A3 A0 03 A0 5F BE 99 16 C2 B3 F3 17                 ;       .
L1AE6:       17 8D                                               ;       .
L1AE8:     04 47                                                 ;     Data tag=04 size=0047
L1AEA:         0B 45                                             ;         Command_0B_SWITCH size=45
L1AEC:           0A 02                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1AEE:           02                                              ;           IF_NOT_JUMP address=1AF1
L1AEF:             00 89                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=89
L1AF1:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1AF2:           02                                              ;           IF_NOT_JUMP address=1AF5
L1AF3:             00 A0                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A0
L1AF5:           01                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L1AF6:           36                                              ;           IF_NOT_JUMP address=1B2D
L1AF7:             0E 34                                         ;             Command_0E_EXECUTE_LIST_WHILE_FAIL size=52
L1AF9:               0D 14                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=20
L1AFB:                 01 1B                                     ;                 Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=1B(ClosedDoor)
L1AFD:                 04                                        ;                 Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L1AFE:                   10 5F BE 09 15 A3 A0 89 4E A5 54 DB     ;                   THE DOOR BLOCKS PASSAGE.
L1B0A:                   16 D3 B9 BF 6C                          ;                   .
L1B0F:               0D 1C                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=28
L1B11:                 00 91                                     ;                 Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=91
L1B13:                 17 1B 91                                  ;                 Command_17_MOVE_OBJECT_TO_LOCATION object=1B(ClosedDoor) location=91
L1B16:                 04                                        ;                 Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L1B17:                   12 5F BE 09 15 A3 A0 C9 54 B5 B7 AF     ;                   THE DOOR CLOSES BEHIND YOU.
L1B23:                   14 90 73 1B 58 3F A1                    ;                   .
L1B2A:                 17 1C 00                                  ;                 Command_17_MOVE_OBJECT_TO_LOCATION object=1C(OpenDoor) location=00
L1B2D:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1B2E:           02                                              ;           IF_NOT_JUMP address=1B31
L1B2F:             00 92                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=92
L1B31:   91 80 8F 00                                             ;   Script number=91 size=008F data=00
L1B35:     03 22                                                 ;     Data tag=03 size=0022
L1B37:       C7 DE 94 14 4B 5E 83 96 CB 17 4E C5                 ;       YOU ARE IN A VAULT WITH A LARGE DOOR TO THE
L1B43:       FB 17 53 BE 4E 45 31 49 46 5E 44 A0                 ;       SOUTH. 
L1B4F:       89 17 82 17 55 5E 36 A1 9B 76                       ;       .
L1B59:     04 68                                                 ;     Data tag=04 size=0068
L1B5B:         0B 66                                             ;         Command_0B_SWITCH size=66
L1B5D:           0A 02                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1B5F:           2F                                              ;           IF_NOT_JUMP address=1B8F
L1B60:             0E 2D                                         ;             Command_0E_EXECUTE_LIST_WHILE_FAIL size=45
L1B62:               0D 10                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=16
L1B64:                 01 1B                                     ;                 Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=1B(ClosedDoor)
L1B66:                 04                                        ;                 Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L1B67:                   0C 5F BE 09 15 A3 A0 4B 7B 2F B8 9B     ;                   THE DOOR IS SHUT. 
L1B73:                   C1                                      ;                   .
L1B74:               0D 19                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=25
L1B76:                 00 90                                     ;                 Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=90
L1B78:                 17 1B 90                                  ;                 Command_17_MOVE_OBJECT_TO_LOCATION object=1B(ClosedDoor) location=90
L1B7B:                 04                                        ;                 Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L1B7C:                   0F 5F BE 09 15 A3 A0 C9 54 B5 B7 89     ;                   THE DOOR CLOSES AGAIN.
L1B88:                   14 D0 47 2E                             ;                   .
L1B8C:                 17 1C 00                                  ;                 Command_17_MOVE_OBJECT_TO_LOCATION object=1C(OpenDoor) location=00
L1B8F:           11                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=11 phrase="11: OPEN *      u.......   *       "
L1B90:           32                                              ;           IF_NOT_JUMP address=1BC3
L1B91:             0E 30                                         ;             Command_0E_EXECUTE_LIST_WHILE_FAIL size=48
L1B93:               0D 10                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=16
L1B95:                 08 1C                                     ;                 Command_08_COMPARE_OBJECT_TO_FIRST_NOUN object=1C(OpenDoor
L1B97:                 04                                        ;                 Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L1B98:                   0C 8D 7B 8E 14 63 B1 FB 5C 5F A0 1B     ;                   ITS ALREADY OPEN. 
L1BA4:                   9C                                      ;                   .
L1BA5:               0D 1C                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=28
L1BA7:                 08 1B                                     ;                 Command_08_COMPARE_OBJECT_TO_FIRST_NOUN object=1B(ClosedDoor
L1BA9:                 17 1C 91                                  ;                 Command_17_MOVE_OBJECT_TO_LOCATION object=1C(OpenDoor) location=91
L1BAC:                 17 1B 00                                  ;                 Command_17_MOVE_OBJECT_TO_LOCATION object=1B(ClosedDoor) location=00
L1BAF:                 04                                        ;                 Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L1BB0:                   12 64 B7 B7 C6 B0 C6 D6 6A DB 72 81     ;                   SCRUUUUUNG THE DOOR OPENS. 
L1BBC:                   5B 91 AF F0 A4 5B BB                    ;                   .
L1BC3:   92 4B 00                                                ;   Script number=92 size=004B data=00
L1BC6:     03 3B                                                 ;     Data tag=03 size=003B
L1BC8:       C7 DE 94 14 43 5E 16 BC DB 72 9E 61                 ;       YOU ARE AT THE ENTRANCE TO A LONG DARK
L1BD4:       D0 B0 9B 53 6B BF 4E 45 11 A0 FB 14                 ;       TUNNEL WHICH LEADS WEST. THERE IS A PASSAGE
L1BE0:       4B B2 70 C0 6E 98 FA 17 DA 78 3F 16                 ;       EAST.
L1BEC:       0D 47 F7 17 17 BA 82 17 2F 62 D5 15                 ;       .
L1BF8:       7B 14 55 A4 09 B7 47 5E 66 49 2E                    ;       .
L1C03:     04 0B                                                 ;     Data tag=04 size=000B
L1C05:         0B 09                                             ;         Command_0B_SWITCH size=09
L1C07:           0A 03                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1C09:           02                                              ;           IF_NOT_JUMP address=1C0C
L1C0A:             00 90                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=90
L1C0C:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1C0D:           02                                              ;           IF_NOT_JUMP address=1C10
L1C0E:             00 93                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=93
L1C10:   93 22 00                                                ;   Script number=93 size=0022 data=00
L1C13:     03 12                                                 ;     Data tag=03 size=0012
L1C15:       C7 DE 94 14 4B 5E 96 96 DB 72 54 59                 ;       YOU ARE IN THE DARK TUNNEL.
L1C21:       D6 83 98 C5 57 61                                   ;       .
L1C27:     04 0B                                                 ;     Data tag=04 size=000B
L1C29:         0B 09                                             ;         Command_0B_SWITCH size=09
L1C2B:           0A 03                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1C2D:           02                                              ;           IF_NOT_JUMP address=1C30
L1C2E:             00 92                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=92
L1C30:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1C31:           02                                              ;           IF_NOT_JUMP address=1C34
L1C32:             00 94                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=94
L1C34:   94 58 00                                                ;   Script number=94 size=0058 data=00
L1C37:     03 3B                                                 ;     Data tag=03 size=003B
L1C39:       C7 DE 94 14 43 5E 16 BC DB 72 9E 61                 ;       YOU ARE AT THE ENTRANCE TO A LONG DARK
L1C45:       D0 B0 9B 53 6B BF 4E 45 11 A0 FB 14                 ;       TUNNEL WHICH LEADS EAST. THERE IS A PASSAGE
L1C51:       4B B2 70 C0 6E 98 FA 17 DA 78 3F 16                 ;       WEST.
L1C5D:       0D 47 23 15 17 BA 82 17 2F 62 D5 15                 ;       .
L1C69:       7B 14 55 A4 09 B7 59 5E 66 62 2E                    ;       .
L1C74:     04 18                                                 ;     Data tag=04 size=0018
L1C76:         0B 16                                             ;         Command_0B_SWITCH size=16
L1C78:           0A 03                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1C7A:           02                                              ;           IF_NOT_JUMP address=1C7D
L1C7B:             00 93                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=93
L1C7D:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1C7E:           0F                                              ;           IF_NOT_JUMP address=1C8E
L1C7F:             0E 0D                                         ;             Command_0E_EXECUTE_LIST_WHILE_FAIL size=13
L1C81:               0D 09                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=9
L1C83:                 20 1D                                     ;                 Command_20_CHECK_ACTIVE_OBJECT object=1D(USER)
L1C85:                 03 00 16                                  ;                 Command_03_IS_OBJECT_AT_LOCATION object=16(DeadSerpent) location=00
L1C88:                 17 15 95                                  ;                 Command_17_MOVE_OBJECT_TO_LOCATION object=15(LiveSerpent) location=95
L1C8B:                 0C                                        ;                 Command_0C_FAIL
L1C8C:               00 95                                       ;               Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=95
L1C8E:   95 32 00                                                ;   Script number=95 size=0032 data=00
L1C91:     03 20                                                 ;     Data tag=03 size=0020
L1C93:       C7 DE 94 14 4B 5E 83 96 3B 16 B7 B1                 ;       YOU ARE IN A LARGE ROOM WITH A SINGLE EXIT
L1C9F:       39 17 DB 9F 56 D1 03 71 5B 17 BE 98                 ;       EAST.
L1CAB:       47 5E 96 D7 23 15 17 BA                             ;       .
L1CB3:     04 0D                                                 ;     Data tag=04 size=000D
L1CB5:         0B 0B                                             ;         Command_0B_SWITCH size=0B
L1CB7:           0A 36                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=36 phrase="36: CLIMB IN    *          *       "
L1CB9:           01                                              ;           IF_NOT_JUMP address=1CBB
L1CBA:             8F                                            ;             CommonCommand_8F
L1CBB:           17                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=17 phrase="17: CLIMB *     u.......   *       "
L1CBC:           01                                              ;           IF_NOT_JUMP address=1CBE
L1CBD:             8F                                            ;             CommonCommand_8F
L1CBE:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1CBF:           02                                              ;           IF_NOT_JUMP address=1CC2
L1CC0:             00 94                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=94
L1CC2:   96 30 00                                                ;   Script number=96 size=0030 data=00
L1CC5:     03 18                                                 ;     Data tag=03 size=0018
L1CC7:       C7 DE 94 14 4B 5E 83 96 FF 14 97 9A                 ;       YOU ARE IN A DENSE DARK DAMP JUNGLE.
L1CD3:       FB 14 4B B2 4F 59 0C A3 91 C5 FF 8B                 ;       .
L1CDF:     04 13                                                 ;     Data tag=04 size=0013
L1CE1:         0B 11                                             ;         Command_0B_SWITCH size=11
L1CE3:           0A 01                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L1CE5:           02                                              ;           IF_NOT_JUMP address=1CE8
L1CE6:             00 A3                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A3
L1CE8:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1CE9:           02                                              ;           IF_NOT_JUMP address=1CEC
L1CEA:             00 A4                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A4
L1CEC:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1CED:           02                                              ;           IF_NOT_JUMP address=1CF0
L1CEE:             00 97                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=97
L1CF0:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1CF1:           02                                              ;           IF_NOT_JUMP address=1CF4
L1CF2:             00 A4                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A4
L1CF4:   97 30 00                                                ;   Script number=97 size=0030 data=00
L1CF7:     03 18                                                 ;     Data tag=03 size=0018
L1CF9:       C7 DE 94 14 4B 5E 83 96 FB 14 4B B2                 ;       YOU ARE IN A DARK DENSE DAMP JUNGLE.
L1D05:       F0 59 9B B7 4F 59 0C A3 91 C5 FF 8B                 ;       .
L1D11:     04 13                                                 ;     Data tag=04 size=0013
L1D13:         0B 11                                             ;         Command_0B_SWITCH size=11
L1D15:           0A 01                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L1D17:           02                                              ;           IF_NOT_JUMP address=1D1A
L1D18:             00 A2                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A2
L1D1A:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1D1B:           02                                              ;           IF_NOT_JUMP address=1D1E
L1D1C:             00 96                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=96
L1D1E:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1D1F:           02                                              ;           IF_NOT_JUMP address=1D22
L1D20:             00 A3                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A3
L1D22:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1D23:           02                                              ;           IF_NOT_JUMP address=1D26
L1D24:             00 98                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=98
L1D26:   98 40 00                                                ;   Script number=98 size=0040 data=00
L1D29:     03 28                                                 ;     Data tag=03 size=0028
L1D2B:       6C BE 29 A1 16 71 DB 72 F0 81 BF 6D                 ;       THROUGH THE JUNGLE YOU SEE THE EAST WALL OF
L1D37:       51 18 55 C2 1B 60 5F BE 23 15 F3 B9                 ;       A GREAT TEMPLE. 
L1D43:       0E D0 11 8A 83 64 84 15 96 5F 7F 17                 ;       .
L1D4F:       E6 93 DB 63                                         ;       .
L1D53:     04 13                                                 ;     Data tag=04 size=0013
L1D55:         0B 11                                             ;         Command_0B_SWITCH size=11
L1D57:           0A 01                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L1D59:           02                                              ;           IF_NOT_JUMP address=1D5C
L1D5A:             00 9B                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9B
L1D5C:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1D5D:           02                                              ;           IF_NOT_JUMP address=1D60
L1D5E:             00 99                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=99
L1D60:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1D61:           02                                              ;           IF_NOT_JUMP address=1D64
L1D62:             00 97                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=97
L1D64:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1D65:           02                                              ;           IF_NOT_JUMP address=1D68
L1D66:             00 9E                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9E
L1D68:   99 44 00                                                ;   Script number=99 size=0044 data=00
L1D6B:     03 2C                                                 ;     Data tag=03 size=002C
L1D6D:       83 7A 45 45 E3 8B 10 B2 C4 6A 59 60                 ;       IN A CLEARING BEFORE YOU STANDS THE SOUTH
L1D79:       5B B1 C7 DE 66 17 8E 48 D6 B5 DB 72                 ;       WALL OF A GREAT TEMPLE. 
L1D85:       47 B9 53 BE 0E D0 11 8A 83 64 84 15                 ;       .
L1D91:       96 5F 7F 17 E6 93 DB 63                             ;       .
L1D99:     04 13                                                 ;     Data tag=04 size=0013
L1D9B:         0B 11                                             ;         Command_0B_SWITCH size=11
L1D9D:           0A 01                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L1D9F:           02                                              ;           IF_NOT_JUMP address=1DA2
L1DA0:             00 9F                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9F
L1DA2:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1DA3:           02                                              ;           IF_NOT_JUMP address=1DA6
L1DA4:             00 96                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=96
L1DA6:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1DA7:           02                                              ;           IF_NOT_JUMP address=1DAA
L1DA8:             00 98                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=98
L1DAA:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1DAB:           02                                              ;           IF_NOT_JUMP address=1DAE
L1DAC:             00 9A                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9A
L1DAE:   9A 59 00                                                ;   Script number=9A size=0059 data=00
L1DB1:     03 41                                                 ;     Data tag=03 size=0041
L1DB3:       6C BE 29 A1 16 71 DB 72 F0 59 9B B7                 ;       THROUGH THE DENSE UNDERGROWTH, YOU CAN SEE
L1DBF:       8E C5 31 62 09 B3 76 BE 51 18 45 C2                 ;       THE GREAT BRONZE GATES ON THE WEST WALL OF
L1DCB:       83 48 A7 B7 82 17 49 5E 63 B1 04 BC                 ;       THE TEMPLE.
L1DD7:       00 B3 5B E3 16 6C 4B 62 03 A0 5F BE                 ;       .
L1DE3:       F7 17 F3 B9 0E D0 11 8A 96 64 DB 72                 ;       .
L1DEF:       EF BD FF A5 2E                                      ;       .
L1DF4:     04 13                                                 ;     Data tag=04 size=0013
L1DF6:         0B 11                                             ;         Command_0B_SWITCH size=11
L1DF8:           0A 01                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L1DFA:           02                                              ;           IF_NOT_JUMP address=1DFD
L1DFB:             00 9B                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9B
L1DFD:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1DFE:           02                                              ;           IF_NOT_JUMP address=1E01
L1DFF:             00 99                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=99
L1E01:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1E02:           02                                              ;           IF_NOT_JUMP address=1E05
L1E03:             00 9C                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9C
L1E05:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1E06:           02                                              ;           IF_NOT_JUMP address=1E09
L1E07:             00 A4                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A4
L1E09:   9B 4D 00                                                ;   Script number=9B size=004D data=00
L1E0C:     03 35                                                 ;     Data tag=03 size=0035
L1E0E:       6C BE 29 A1 03 71 73 15 0B A3 96 96                 ;       THROUGH A GAP IN THE JUNGLE YOU CAN SEE THE
L1E1A:       DB 72 F0 81 BF 6D 51 18 45 C2 83 48                 ;       NORTH WALL OF A MAGNIFICENT TEMPLE.
L1E26:       A7 B7 82 17 50 5E BE A0 19 71 46 48                 ;       .
L1E32:       B8 16 7B 14 89 91 08 99 D7 78 B3 9A                 ;       .
L1E3E:       EF BD FF A5 2E                                      ;       .
L1E43:     04 13                                                 ;     Data tag=04 size=0013
L1E45:         0B 11                                             ;         Command_0B_SWITCH size=11
L1E47:           0A 01                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L1E49:           02                                              ;           IF_NOT_JUMP address=1E4C
L1E4A:             00 A2                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A2
L1E4C:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1E4D:           02                                              ;           IF_NOT_JUMP address=1E50
L1E4E:             00 9D                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9D
L1E50:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1E51:           02                                              ;           IF_NOT_JUMP address=1E54
L1E52:             00 9A                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9A
L1E54:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1E55:           02                                              ;           IF_NOT_JUMP address=1E58
L1E56:             00 98                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=98
L1E58:   9C 3A 00                                                ;   Script number=9C size=003A data=00
L1E5B:     03 26                                                 ;     Data tag=03 size=0026
L1E5D:       C7 DE 94 14 55 5E 50 BD 90 5A C4 6A                 ;       YOU ARE STANDING BEFORE THE WEST ENTRANCE OF
L1E69:       59 60 5B B1 5F BE F7 17 F3 B9 9E 61                 ;       THE TEMPLE. 
L1E75:       D0 B0 9B 53 C3 9E 5F BE 7F 17 E6 93                 ;       .
L1E81:       DB 63                                               ;       .
L1E83:     04 0F                                                 ;     Data tag=04 size=000F
L1E85:         0B 0D                                             ;         Command_0B_SWITCH size=0D
L1E87:           0A 01                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L1E89:           02                                              ;           IF_NOT_JUMP address=1E8C
L1E8A:             00 9D                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9D
L1E8C:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1E8D:           02                                              ;           IF_NOT_JUMP address=1E90
L1E8E:             00 9F                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9F
L1E90:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1E91:           02                                              ;           IF_NOT_JUMP address=1E94
L1E92:             00 9A                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9A
L1E94:   9D 80 B3 00                                             ;   Script number=9D size=00B3 data=00
L1E98:     03 12                                                 ;     Data tag=03 size=0012
L1E9A:       C7 DE 94 14 43 5E 16 BC DB 72 04 9A                 ;       YOU ARE AT THE NORTH WALL. 
L1EA6:       53 BE 0E D0 9B 8F                                   ;       .
L1EAC:     04 80 9B                                              ;     Data tag=04 size=009B
L1EAF:         0B 80 98                                          ;         Command_0B_SWITCH size=98
L1EB2:           0A 01                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L1EB4:           02                                              ;           IF_NOT_JUMP address=1EB7
L1EB5:             00 9B                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9B
L1EB7:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1EB8:           02                                              ;           IF_NOT_JUMP address=1EBB
L1EB9:             00 9E                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9E
L1EBB:           17                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=17 phrase="17: CLIMB *     u.......   *       "
L1EBC:           80 88                                           ;           IF_NOT_JUMP address=1F46
L1EBE:             0D 80 85                                      ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=133
L1EC1:               08 21                                       ;               Command_08_COMPARE_OBJECT_TO_FIRST_NOUN object=21(Vines
L1EC3:               0E 80 80                                    ;               Command_0E_EXECUTE_LIST_WHILE_FAIL size=128
L1EC6:                 0D 54                                     ;                 Command_0D_EXECUTE_LIST_WHILE_PASS size=84
L1EC8:                   05 7F                                   ;                   Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=7F
L1ECA:                   04                                      ;                   Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L1ECB:                     2A C7 DE DE 14 64 7A 89 17 82 17 54   ;                     YOU CLIMB TO THE ROOF.  AS YOU STEP ON THE
L1ED7:                     5E 38 A0 3B F4 4B 49 C7 DE 66 17 D3   ;                     ROOF, IT COLLAPSES. 
L1EE3:                     61 03 A0 5F BE 39 17 E6 9E D6 15 E1   ;                     .
L1EEF:                     14 FB 8C 17 A7 5B BB                  ;                     .
L1EF6:                   17 36 00                                ;                   Command_17_MOVE_OBJECT_TO_LOCATION object=36(Jungle) location=00
L1EF9:                   17 29 FF                                ;                   Command_17_MOVE_OBJECT_TO_LOCATION object=29(Floor) location=FF
L1EFC:                   17 2A FF                                ;                   Command_17_MOVE_OBJECT_TO_LOCATION object=2A(Exit) location=FF
L1EFF:                   17 2B FF                                ;                   Command_17_MOVE_OBJECT_TO_LOCATION object=2B(Passage) location=FF
L1F02:                   17 2C FF                                ;                   Command_17_MOVE_OBJECT_TO_LOCATION object=2C(Hole) location=FF
L1F05:                   17 2D FF                                ;                   Command_17_MOVE_OBJECT_TO_LOCATION object=2D(Corridor) location=FF
L1F08:                   17 2E FF                                ;                   Command_17_MOVE_OBJECT_TO_LOCATION object=2E(Corner) location=FF
L1F0B:                   17 31 FF                                ;                   Command_17_MOVE_OBJECT_TO_LOCATION object=31(Hallway) location=FF
L1F0E:                   17 34 FF                                ;                   Command_17_MOVE_OBJECT_TO_LOCATION object=34(Entrance) location=FF
L1F11:                   17 35 FF                                ;                   Command_17_MOVE_OBJECT_TO_LOCATION object=35(Tunnel) location=FF
L1F14:                   17 3A FF                                ;                   Command_17_MOVE_OBJECT_TO_LOCATION object=3A(Ceiling) location=FF
L1F17:                   17 3C 00                                ;                   Command_17_MOVE_OBJECT_TO_LOCATION object=3C(Object3C) location=00
L1F1A:                   00 81                                   ;                   Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=81
L1F1C:                 04                                        ;                 Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L1F1D:                   28 4B 49 C7 DE DE 14 64 7A 16 EE DB     ;                   AS YOU CLIMB, THE VINE GIVES WAY AND YOU
L1F29:                   72 10 CB 49 5E CF 7B D9 B5 3B 4A 8E     ;                   FALL TO THE GROUND.
L1F35:                   48 51 18 48 C2 46 48 89 17 82 17 49     ;                   .
L1F41:                   5E 07 B3 57 98                          ;                   .
L1F46:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1F47:           02                                              ;           IF_NOT_JUMP address=1F4A
L1F48:             00 9C                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9C
L1F4A:   9E 25 00                                                ;   Script number=9E size=0025 data=00
L1F4D:     03 11                                                 ;     Data tag=03 size=0011
L1F4F:       C7 DE 94 14 43 5E 16 BC DB 72 95 5F                 ;       YOU ARE AT THE EAST WALL.
L1F5B:       19 BC 46 48 2E                                      ;       .
L1F60:     04 0F                                                 ;     Data tag=04 size=000F
L1F62:         0B 0D                                             ;         Command_0B_SWITCH size=0D
L1F64:           0A 01                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L1F66:           02                                              ;           IF_NOT_JUMP address=1F69
L1F67:             00 9D                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9D
L1F69:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1F6A:           02                                              ;           IF_NOT_JUMP address=1F6D
L1F6B:             00 9F                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9F
L1F6D:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1F6E:           02                                              ;           IF_NOT_JUMP address=1F71
L1F6F:             00 98                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=98
L1F71:   9F 26 00                                                ;   Script number=9F size=0026 data=00
L1F74:     03 12                                                 ;     Data tag=03 size=0012
L1F76:       C7 DE 94 14 43 5E 16 BC DB 72 47 B9                 ;       YOU ARE AT THE SOUTH WALL. 
L1F82:       53 BE 0E D0 9B 8F                                   ;       .
L1F88:     04 0F                                                 ;     Data tag=04 size=000F
L1F8A:         0B 0D                                             ;         Command_0B_SWITCH size=0D
L1F8C:           0A 04                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1F8E:           02                                              ;           IF_NOT_JUMP address=1F91
L1F8F:             00 9C                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9C
L1F91:           03                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1F92:           02                                              ;           IF_NOT_JUMP address=1F95
L1F93:             00 9E                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9E
L1F95:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L1F96:           02                                              ;           IF_NOT_JUMP address=1F99
L1F97:             00 99                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=99
L1F99:   A0 20 00                                                ;   Script number=A0 size=0020 data=00
L1F9C:     03 14                                                 ;     Data tag=03 size=0014
L1F9E:       C7 DE 94 14 4B 5E 83 96 CF 17 7B B4                 ;       YOU ARE IN A VERY SMALL ROOM. 
L1FAA:       E3 B8 F3 8C 01 B3 DB 95                             ;       .
L1FB2:     04 07                                                 ;     Data tag=04 size=0007
L1FB4:         0B 05                                             ;         Command_0B_SWITCH size=05
L1FB6:           0A 04                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L1FB8:           02                                              ;           IF_NOT_JUMP address=1FBB
L1FB9:             00 90                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=90
L1FBB:   A1 2C 00                                                ;   Script number=A1 size=002C data=00
L1FBE:     03 20                                                 ;     Data tag=03 size=0020
L1FC0:       C7 DE 94 14 4B 5E 83 96 5F 17 46 48                 ;       YOU ARE IN A SMALL ROOM WITH A SINGLE EXIT
L1FCC:       39 17 DB 9F 56 D1 03 71 5B 17 BE 98                 ;       EAST.
L1FD8:       47 5E 96 D7 23 15 17 BA                             ;       .
L1FE0:     04 07                                                 ;     Data tag=04 size=0007
L1FE2:         0B 05                                             ;         Command_0B_SWITCH size=05
L1FE4:           0A 03                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L1FE6:           02                                              ;           IF_NOT_JUMP address=1FE9
L1FE7:             00 84                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=84
L1FE9:   A2 30 00                                                ;   Script number=A2 size=0030 data=00
L1FEC:     03 18                                                 ;     Data tag=03 size=0018
L1FEE:       C7 DE 94 14 4B 5E 83 96 FB 14 4B B2                 ;       YOU ARE IN A DARK DAMP DENSE JUNGLE.
L1FFA:       4F 59 06 A3 9D 61 4C 5E 91 C5 FF 8B                 ;       .
L2006:     04 13                                                 ;     Data tag=04 size=0013
L2008:         0B 11                                             ;         Command_0B_SWITCH size=11
L200A:           0A 03                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L200C:           02                                              ;           IF_NOT_JUMP address=200F
L200D:             00 A4                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A4
L200F:           01                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L2010:           02                                              ;           IF_NOT_JUMP address=2013
L2011:             00 96                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=96
L2013:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L2014:           02                                              ;           IF_NOT_JUMP address=2017
L2015:             00 A3                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A3
L2017:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L2018:           02                                              ;           IF_NOT_JUMP address=201B
L2019:             00 97                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=97
L201B:   A3 30 00                                                ;   Script number=A3 size=0030 data=00
L201E:     03 18                                                 ;     Data tag=03 size=0018
L2020:       C7 DE 94 14 4B 5E 83 96 FF 14 97 9A                 ;       YOU ARE IN A DENSE DAMP DARK JUNGLE.
L202C:       FB 14 D3 93 54 59 CC 83 91 C5 FF 8B                 ;       .
L2038:     04 13                                                 ;     Data tag=04 size=0013
L203A:         0B 11                                             ;         Command_0B_SWITCH size=11
L203C:           0A 03                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L203E:           02                                              ;           IF_NOT_JUMP address=2041
L203F:             00 A4                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A4
L2041:           01                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L2042:           02                                              ;           IF_NOT_JUMP address=2045
L2043:             00 A2                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A2
L2045:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L2046:           02                                              ;           IF_NOT_JUMP address=2049
L2047:             00 96                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=96
L2049:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L204A:           02                                              ;           IF_NOT_JUMP address=204D
L204B:             00 97                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=97
L204D:   A4 30 00                                                ;   Script number=A4 size=0030 data=00
L2050:     03 18                                                 ;     Data tag=03 size=0018
L2052:       C7 DE 94 14 4B 5E 83 96 FB 14 D3 93                 ;       YOU ARE IN A DAMP DARK DENSE JUNGLE.
L205E:       54 59 C6 83 9D 61 4C 5E 91 C5 FF 8B                 ;       .
L206A:     04 13                                                 ;     Data tag=04 size=0013
L206C:         0B 11                                             ;         Command_0B_SWITCH size=11
L206E:           0A 03                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L2070:           02                                              ;           IF_NOT_JUMP address=2073
L2071:             00 A3                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A3
L2073:           01                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L2074:           02                                              ;           IF_NOT_JUMP address=2077
L2075:             00 A2                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A2
L2077:           02                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L2078:           02                                              ;           IF_NOT_JUMP address=207B
L2079:             00 96                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=96
L207B:           04                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L207C:           02                                              ;           IF_NOT_JUMP address=207F
L207D:             00 A3                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A3
L207F:   A5 2C 00                                                ;   Script number=A5 size=002C data=00
L2082:     03 20                                                 ;     Data tag=03 size=0020
L2084:       C7 DE 94 14 4B 5E 96 96 DB 72 A5 B7                 ;       YOU ARE IN THE SECRET PASSAGE WHICH LEADS
L2090:       76 B1 DB 16 D3 B9 9B 6C 23 D1 13 54                 ;       EAST. 
L209C:       E3 8B 0B 5C 95 5F 9B C1                             ;       .
L20A4:     04 07                                                 ;     Data tag=04 size=0007
L20A6:         0B 05                                             ;         Command_0B_SWITCH size=05
L20A8:           0A 03                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L20AA:           02                                              ;           IF_NOT_JUMP address=20AD
L20AB:             00 A6                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A6
L20AD:   A6 50 00                                                ;   Script number=A6 size=0050 data=00
L20B0:     03 2C                                                 ;     Data tag=03 size=002C
L20B2:       C7 DE 94 14 43 5E 16 BC DB 72 8E 61                 ;       YOU ARE AT THE END OF THE PASSAGE. THERE IS
L20BE:       B8 16 82 17 52 5E 65 49 77 47 56 F4                 ;       A HOLE IN THE CEILING.
L20CA:       F4 72 4B 5E C3 B5 A9 15 DB 8B 83 7A                 ;       .
L20D6:       5F BE D7 14 43 7A CF 98                             ;       .
L20DE:     04 1F                                                 ;     Data tag=04 size=001F
L20E0:         0B 1D                                             ;         Command_0B_SWITCH size=1D
L20E2:           0A 04                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L20E4:           02                                              ;           IF_NOT_JUMP address=20E7
L20E5:             00 A5                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A5
L20E7:           17                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=17 phrase="17: CLIMB *     u.......   *       "
L20E8:           05                                              ;           IF_NOT_JUMP address=20EE
L20E9:             0D 03                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=3
L20EB:               08 2C                                       ;               Command_08_COMPARE_OBJECT_TO_FIRST_NOUN object=2C(Hole
L20ED:               91                                          ;               CommonCommand_91
L20EE:           36                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=36 phrase="36: CLIMB IN    *          *       "
L20EF:           05                                              ;           IF_NOT_JUMP address=20F5
L20F0:             0D 03                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=3
L20F2:               08 2C                                       ;               Command_08_COMPARE_OBJECT_TO_FIRST_NOUN object=2C(Hole
L20F4:               91                                          ;               CommonCommand_91
L20F5:           37                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=37 phrase="37: CLIMB OUT   *          *       "
L20F6:           05                                              ;           IF_NOT_JUMP address=20FC
L20F7:             0D 03                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=3
L20F9:               08 2C                                       ;               Command_08_COMPARE_OBJECT_TO_FIRST_NOUN object=2C(Hole
L20FB:               91                                          ;               CommonCommand_91
L20FC:           33                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=33 phrase="??"
L20FD:           01                                              ;           IF_NOT_JUMP address=20FF
L20FE:             91                                            ;             CommonCommand_91
; ENDOF 1523

;##ObjectData
; Objects are referenced by index in this list with the first object being "Object 1".
; The first three data bytes are as follows AA BB CC:
;   AA = location. If >80 then it is a room. If <80 then it is held by an object.
;   BB = score points
;   CC = --CPAXOL
;    C=1 if object can be carried
;    P=1 if object is a person;
;    A=1 if open/close-able
;    X=1 if lock/unlock-able 
;    O=1 if closed
;    L=1 if locked
;
; Objects can have various fields tagged as follows:
;   01 = list of adjectives (size+bytes) not used in RAAKATU
;   02 = short name (packed string)
;   03 = long description (packed string)
;   04 (never used)
;   05 (never used)
;   06 = command handling if object is second noun (script)
;   07 = command handling if object is first noun (script)
;   08 = turn-script executed for objects turn in game (script)
;   09 = hitpoint information (2 bytess) AA BB. AA=max hit points  BB=current hit points
;   0A = script executed with killed (script) 
;   0B = script executed if command is given to object (script) not used in RAAKATU
;
L20FF: 00 91 3A                                                  ; Number=00 size=113A
; Object_01 Object1
L2102:   01 03                                                   ;   Number=01 size=0003
L2104:     00 00 00                                              ;     room=00 scorePoints=00 bits=00 *       
; Object_02 Object2
L2107:   03 03                                                   ;   Number=03 size=0003
L2109:     00 00 00                                              ;     room=00 scorePoints=00 bits=00 *       
; Object_03 Rug
L210C:   06 48                                                   ;   Number=06 size=0048
L210E:     82 00 80                                              ;     room=82 scorePoints=00 bits=80 u.......
L2111:     02                                                    ;     02 SHORT NAME
L2112:       02 E9 B3                                            ;       RUG
L2115:     07 3F                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L2117:       0B 3D                                               ;       Command_0B_SWITCH size=3D
L2119:         0A 0C                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=0C phrase="0C: LOOK UNDER  *          u......."
L211B:         01                                                ;         IF_NOT_JUMP address=211D
L211C:           8C                                              ;           CommonCommand_8C
L211D:         36                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=36 phrase="36: CLIMB IN    *          *       "
L211E:         01                                                ;         IF_NOT_JUMP address=2120
L211F:           8A                                              ;           CommonCommand_8A
L2120:         33                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=33 phrase="??"
L2121:         01                                                ;         IF_NOT_JUMP address=2123
L2122:           8A                                              ;           CommonCommand_8A
L2123:         34                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=34 phrase="34: JUMP OVER   *          u......."
L2124:         01                                                ;         IF_NOT_JUMP address=2126
L2125:           8A                                              ;           CommonCommand_8A
L2126:         35                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=35 phrase="??"
L2127:         01                                                ;         IF_NOT_JUMP address=2129
L2128:           8B                                              ;           CommonCommand_8B
L2129:         2D                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=2D phrase="2D: PULL UP     *          u......."
L212A:         01                                                ;         IF_NOT_JUMP address=212C
L212B:           8C                                              ;           CommonCommand_8C
L212C:         26                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=26 phrase="26: GO AROUND   *          u......."
L212D:         28                                                ;         IF_NOT_JUMP address=2156
L212E:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L212F:             26 C7 DE D3 14 E6 96 16 EE DB 72 E9           ;             YOU CAN'T, THE RUG STRETCHES ALL THE WAY
L213B:             B3 66 17 76 B1 1F 54 C3 B5 F3 8C 5F           ;             ACROSS THE ROOM.
L2147:             BE F3 17 43 DB B9 55 CB B9 5F BE 39           ;             .
L2153:             17 FF 9F                                      ;             .
; Object_04 DoorCarvings
L2156:   09 5E                                                   ;   Number=09 size=005E
L2158:     82 00 84                                              ;     room=82 scorePoints=00 bits=84 u....X..
L215B:     02                                                    ;     02 SHORT NAME
L215C:       03 81 5B 52                                         ;       DOOR
L2160:     07 54                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L2162:       0E 52                                               ;       Command_0E_EXECUTE_LIST_WHILE_FAIL size=82
L2164:         0D 22                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=34
L2166:           0A 08                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=08 phrase="08: READ *      .....X..   *       "
L2168:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2169:             1E 5F BE D3 14 13 B4 C5 98 C0 16 82           ;             THE CARVINGS ON THE DOOR SAY, "DO NOT
L2175:             17 46 5E 44 A0 53 17 B3 E0 49 1B 99           ;             ENTER."
L2181:             16 07 BC BF 9A 1C B5                          ;             .
L2188:         0D 2C                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=44
L218A:           14                                              ;           Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L218B:             0A 0B                                         ;             Command_0A_COMPARE_TO_PHRASE_FORM val=0B phrase="0B: LOOK AT     *          u......."
L218D:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L218E:             27 C7 DE C6 22 9B 15 5B CA 6B BF 2B           ;             YOU'LL HAVE TO GO TO THE EAST SIDE OF THE
L219A:             6E 6B BF 5F BE 23 15 F3 B9 46 B8 51           ;             ROOM TO DO THAT.
L21A6:             5E 96 64 DB 72 01 B3 56 90 C6 9C D6           ;             .
L21B2:             9C 56 72 2E                                   ;             .
; Object_05 Food
L21B6:   0C 2A                                                   ;   Number=0C size=002A
L21B8:     84 00 A0                                              ;     room=84 scorePoints=00 bits=A0 u.C.....
L21BB:     03                                                    ;     03 DESCRIPTION
L21BC:       0D 5F BE 5B B1 4B 7B 01 68 0A 58 2F                 ;       THERE IS FOOD HERE.
L21C8:       62 2E                                               ;       .
L21CA:     07 11                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L21CC:       0D 0F                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=15
L21CE:         0A 15                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=15 phrase="15: EAT *       u.......   *       "
L21D0:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L21D1:           04 F4 4F AB A2                                  ;           BURP! 
L21D6:         17 05 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=05(Food) location=00
L21D9:         1C 1D                                             ;         Command_1C_SET_VAR_OBJECT object=1D (USER)
L21DB:         23 0F                                             ;         Command_23_HEAL_VAR_OBJECT value=0F
L21DD:     02                                                    ;     02 SHORT NAME
L21DE:       03 01 68 44                                         ;       FOOD
; Object_06 StatueEast
L21E2:   0D 2A                                                   ;   Number=0D size=002A
L21E4:     88 00 80                                              ;     room=88 scorePoints=00 bits=80 u.......
L21E7:     02                                                    ;     02 SHORT NAME
L21E8:       04 FB B9 67 C0                                      ;       STATUE
L21ED:     07 05                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L21EF:       0D 03                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=3
L21F1:         0A 12                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=12 phrase="12: PULL *      u.......   *       "
L21F3:         8D                                                ;         CommonCommand_8D
L21F4:     03                                                    ;     03 DESCRIPTION
L21F5:       18 5F BE 66 17 8F 49 4B 5E C8 B5 DB                 ;       THE STATUE IS FACING THE EAST DOOR. 
L2201:       46 AB 98 5F BE 23 15 F3 B9 81 5B 1B                 ;       .
L220D:       B5                                                  ;       .
; Object_07 StatueWest
L220E:   0D 2A                                                   ;   Number=0D size=002A
L2210:     00 00 80                                              ;     room=00 scorePoints=00 bits=80 u.......
L2213:     02                                                    ;     02 SHORT NAME
L2214:       04 FB B9 67 C0                                      ;       STATUE
L2219:     07 05                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L221B:       0D 03                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=3
L221D:         0A 12                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=12 phrase="12: PULL *      u.......   *       "
L221F:         8D                                                ;         CommonCommand_8D
L2220:     03                                                    ;     03 DESCRIPTION
L2221:       18 5F BE 66 17 8F 49 4B 5E C8 B5 DB                 ;       THE STATUE IS FACING THE WEST DOOR. 
L222D:       46 AB 98 5F BE F7 17 F3 B9 81 5B 1B                 ;       .
L2239:       B5                                                  ;       .
; Object_08 GoldRing
L223A:   12 44                                                   ;   Number=12 size=0044
L223C:     8C 05 A4                                              ;     room=8C scorePoints=05 bits=A4 u.C..X..
L223F:     03                                                    ;     03 DESCRIPTION
L2240:       14 54 45 91 7A B8 16 53 15 75 98 09                 ;       A RING OF FINEST GOLD IS HERE.
L224C:       BC BE 9F D5 15 9F 15 7F B1                          ;       .
L2255:     02                                                    ;     02 SHORT NAME
L2256:       06 3E 6E 14 58 91 7A                                ;       GOLD RING
L225D:     07 21                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L225F:       0D 1F                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=31
L2261:         0A 08                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=08 phrase="08: READ *      .....X..   *       "
L2263:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2264:           1B 5F BE D0 15 64 B7 EE 7A C0 7A 2F             ;           THE INSCRIPTION READS, "RING OF MOTION."
L2270:           17 0D 47 FC ED 10 B2 D1 6A 8F 64 03             ;           .
L227C:           A1 27 A0 22                                     ;           .
; Object_09 Sword
L2280:   0E 42                                                   ;   Number=0E size=0042
L2282:     A1 00 E4                                              ;     room=A1 scorePoints=00 bits=E4 uvC..X..
L2285:     03                                                    ;     03 DESCRIPTION
L2286:       19 5F BE 5B B1 4B 7B 4E 45 31 49 55                 ;       THERE IS A LARGE SWORD LAYING NEARBY.
L2292:       5E 44 D2 0E 58 4B 4A AB 98 63 98 03                 ;       .
L229E:       B1 2E                                               ;       .
L22A0:     07 18                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L22A2:       0D 16                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=22
L22A4:         0A 08                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=08 phrase="08: READ *      .....X..   *       "
L22A6:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L22A7:           12 2C 1D 5F A0 D3 B3 B8 16 43 16 57             ;           "PROPERTY OF LIEYUCHNEBST" 
L22B3:           63 28 54 BD 5F 23 BC                            ;           .
L22BA:     02                                                    ;     02 SHORT NAME
L22BB:       08 54 8B 9B 6C 81 BA 33 B1                          ;       LARGE SWORD 
; Object_0A StoneGargoyle
L22C4:   0F 6B                                                   ;   Number=0F size=006B
L22C6:     8E 00 80                                              ;     room=8E scorePoints=00 bits=80 u.......
L22C9:     03                                                    ;     03 DESCRIPTION
L22CA:       34 5F BE 5B B1 4B 7B 4A 45 FF 78 35                 ;       THERE IS A HIDEOUS STONE GARGOYLE PERCHED ON
L22D6:       A1 66 17 0F A0 73 15 C1 B1 3F DE DF                 ;       A LEDGE ABOVE THE NORTH PASSAGE. 
L22E2:       16 1A B1 F3 5F 03 A0 4E 45 01 60 43                 ;       .
L22EE:       5E 08 4F 56 5E DB 72 04 9A 53 BE 55                 ;       .
L22FA:       A4 09 B7 DB 63                                      ;       .
L22FF:     07 24                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L2301:       0D 22                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=34
L2303:         0A 0B                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=0B phrase="0B: LOOK AT     *          u......."
L2305:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2306:           1E 5F BE 5B B1 EA 48 94 5F D6 B5 C4             ;           THERE APPEARS TO BE DRIED BLOOD ON HIS
L2312:           9C 46 5E 07 B2 04 58 81 8D 11 58 8A             ;           CLAWS!
L231E:           96 4B 7B BB 54 C9 D2                            ;           .
L2325:     02                                                    ;     02 SHORT NAME
L2326:       0A 09 BA 5B 98 14 6C 4B 6E DB 8B                    ;       STONE GARGOYLE 
; Object_0B AlterA
L2331:   22 58                                                   ;   Number=22 size=0058
L2333:     95 00 80                                              ;     room=95 scorePoints=00 bits=80 u.......
L2336:     03                                                    ;     03 DESCRIPTION
L2337:       32 68 4D AF A0 51 18 55 C2 50 BD 0B                 ;       BEFORE YOU STANDS AN ALTAR, STAINED WITH THE
L2343:       5C 83 48 4E 48 46 49 66 17 D0 47 F3                 ;       BLOOD OF COUNTLESS SACRIFICES.
L234F:       5F 56 D1 16 71 DB 72 89 4E 73 9E C3                 ;       .
L235B:       9E 47 55 C6 9A 65 62 53 17 B3 55 05                 ;       .
L2367:       67 6F 62                                            ;       .
L236A:     07 10                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L236C:       0B 0E                                               ;       Command_0B_SWITCH size=0E
L236E:         0A 12                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=12 phrase="12: PULL *      u.......   *       "
L2370:         01                                                ;         IF_NOT_JUMP address=2372
L2371:           8E                                              ;           CommonCommand_8E
L2372:         0C                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=0C phrase="0C: LOOK UNDER  *          u......."
L2373:         01                                                ;         IF_NOT_JUMP address=2375
L2374:           8E                                              ;           CommonCommand_8E
L2375:         38                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=38 phrase="38: CLIMB UNDER *          u......."
L2376:         05                                                ;         IF_NOT_JUMP address=237C
L2377:           0D 03                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=3
L2379:             00 A5                                         ;             Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A5
L237B:             90                                            ;             CommonCommand_90
L237C:     02                                                    ;     02 SHORT NAME
L237D:       0D 89 4E 73 9E FB B9 8F 7A 03 58 3B                 ;       BLOOD STAINED ALTAR
L2389:       8E 52                                               ;       .
; Object_0C Idol
L238B:   23 2F                                                   ;   Number=23 size=002F
L238D:     95 05 A0                                              ;     room=95 scorePoints=05 bits=A0 u.C.....
L2390:     03                                                    ;     03 DESCRIPTION
L2391:       20 49 45 BE 9F 83 61 09 79 15 8A 50                 ;       A GOLDEN IDOL STANDS IN THE CENTER OF THE
L239D:       BD 0B 5C 83 7A 5F BE D7 14 BF 9A 91                 ;       ROOM. 
L23A9:       AF 96 64 DB 72 01 B3 DB 95                          ;       .
L23B2:     02                                                    ;     02 SHORT NAME
L23B3:       08 3E 6E F0 59 C6 15 B3 9F                          ;       GOLDEN IDOL 
; Object_0D BronzeGates
L23BC:   27 80 9A                                                ;   Number=27 size=009A
L23BF:     9C 00 80                                              ;     room=9C scorePoints=00 bits=80 u.......
L23C2:     03                                                    ;     03 DESCRIPTION
L23C3:       34 AF 6E 73 49 79 4F AF 9B 73 15 F5                 ;       GREAT BRONZE GATES ENGRAVED WITH IMAGES OF
L23CF:       BD 30 15 AB 6E 66 CA FB 17 53 BE 63                 ;       SERPENTS STAND SILENTLY BEFORE YOU.
L23DB:       7A B5 6C B8 16 57 17 1F B3 CD 9A 66                 ;       .
L23E7:       17 8E 48 5B 17 F0 8B 13 BF AF 14 04                 ;       .
L23F3:       68 5B 5E 3F A1                                      ;       .
L23F8:     07 55                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L23FA:       0B 53                                               ;       Command_0B_SWITCH size=53
L23FC:         0A 11                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=11 phrase="11: OPEN *      u.......   *       "
L23FE:         20                                                ;         IF_NOT_JUMP address=241F
L23FF:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2400:             1E 5F BE 73 15 F5 BD 94 14 4E 5E 5D           ;             THE GATES ARE LOCKED, YOU CAN NOT OPEN THEM.
L240C:             9E 16 60 51 18 45 C2 83 48 06 9A C2           ;             
L2418:             16 83 61 5F BE DB 95                          ;             .
L241F:         36                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=36 phrase="36: CLIMB IN    *          *       "
L2420:         10                                                ;         IF_NOT_JUMP address=2431
L2421:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2422:             0E 5F BE 73 15 F5 BD 94 14 45 5E 85           ;             THE GATES ARE CLOSED.
L242E:             8D 17 60                                      ;             .
L2431:         17                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=17 phrase="17: CLIMB *     u.......   *       "
L2432:         19                                                ;         IF_NOT_JUMP address=244C
L2433:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2434:             17 5F BE 73 15 F5 BD 94 14 56 5E 2B           ;             THE GATES ARE TOO SMOOTH TO CLIMB.
L2440:             A0 F1 B8 02 A1 89 17 DE 14 64 7A 2E           ;             .
L244C:         34                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=34 phrase="34: JUMP OVER   *          u......."
L244D:         01                                                ;         IF_NOT_JUMP address=244F
L244E:           89                                              ;           CommonCommand_89
L244F:     02                                                    ;     02 SHORT NAME
L2450:       08 79 4F AF 9B 73 15 F5 BD                          ;       BRONZE GATES
; Object_0E UnpulledLever
L2459:   16 59                                                   ;   Number=16 size=0059
L245B:     91 00 A0                                              ;     room=91 scorePoints=00 bits=A0 u.C.....
L245E:     02                                                    ;     02 SHORT NAME
L245F:       04 F8 8B 23 62                                      ;       LEVER 
L2464:     03                                                    ;     03 DESCRIPTION
L2465:       16 44 45 EF 60 AE D0 F3 5F F8 8B 23                 ;       A BEJEWELED LEVER IS ON ONE WALL.
L2471:       62 4B 7B 03 A0 0F A0 F3 17 17 8D                    ;       .
L247C:     07 36                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L247E:       0D 34                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=52
L2480:         0A 12                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=12 phrase="12: PULL *      u.......   *       "
L2482:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2483:           2F 56 45 D2 B0 09 15 A3 A0 5F A0 8B             ;           A TRAP DOOR OPENS ABOVE YOU.  GOLD DUST
L248F:           9A B9 46 5B CA C7 DE 3B F4 3E 6E 06             ;           FILLS THE ROOM AND DROWNS YOU.
L249B:           58 66 C6 53 15 0D 8D 82 17 54 5E 3F             ;           .
L24A7:           A0 90 14 06 58 09 B3 8B 9A C7 DE 2E             ;           .
L24B3:         81                                                ;         CommonCommand_81
; Object_0F PulledLever
L24B4:   16 42                                                   ;   Number=16 size=0042
L24B6:     00 05 A0                                              ;     room=00 scorePoints=05 bits=A0 u.C.....
L24B9:     03                                                    ;     03 DESCRIPTION
L24BA:       12 44 45 EF 60 AE D0 F3 5F F8 8B 23                 ;       A BEJEWELED LEVER IS HERE. 
L24C6:       62 4B 7B F4 72 DB 63                                ;       .
L24CD:     02                                                    ;     02 SHORT NAME
L24CE:       0A 6C 4D F7 62 E6 8B 3F 16 74 CA                    ;       BEJEWELED LEVER
L24D9:     07 1D                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L24DB:       0D 1B                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=27
L24DD:         0A 12                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=12 phrase="12: PULL *      u.......   *       "
L24DF:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L24E0:           17 5F BE 3F 16 74 CA D3 14 90 96 CE             ;           THE LEVER CAN NO LONGER BE PULLED.
L24EC:           9C 11 A0 23 62 5B 4D 6E A7 E6 8B 2E             ;           .
; Object_10 LeverPlaque
L24F8:   18 80 C5                                                ;   Number=18 size=00C5
L24FB:     91 00 84                                              ;     room=91 scorePoints=00 bits=84 u....X..
L24FE:     07 80 98                                              ;     07 COMMAND HANDLING IF FIRST NOUN
L2501:       0D 80 95                                            ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=149
L2504:         0A 08                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=08 phrase="08: READ *      .....X..   *       "
L2506:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2507:           80 90 9E C5 BE 9F 33 17 1F 54 CE B5             ;           UNTOLD RICHES LIE WITHIN REACH, HERE- TO ANY
L2513:           1B 79 56 D1 90 73 2F 17 DA 46 0A EE             ;           KNOWING, LIVING CREATURE. BE WARY THOUGH, NO
L251F:           2F 62 D6 E7 C3 9C 7B 9B 19 87 50 D1             ;           MATTER WHAT THY CREED, THAT THOU HARNESS AND
L252B:           33 70 98 8C 91 7A E4 14 96 5F 2F C6             ;           LIMIT THY POWERFUL GREED.  PULL THE LEVER TO
L2537:           44 F4 59 5E 43 49 82 17 29 A1 73 76             ;           GAIN THY WEALTH, BE PREPARED TO ... 
L2543:           EB 99 96 91 F4 BD FA 17 73 49 73 BE             ;           .
L254F:           E4 14 26 60 16 EE 56 72 82 17 1B A1             ;           .
L255B:           54 72 75 98 C3 B5 33 98 8F 8C 73 7B             ;           .
L2567:           73 BE E9 16 B4 D0 EE 68 84 15 26 60             ;           .
L2573:           3B F4 6E A7 16 8A DB 72 F8 8B 23 62             ;           .
L257F:           6B BF 0B 6C 96 96 FB 75 A3 D0 42 8E             ;           .
L258B:           04 EE 52 5E 72 B1 2F 49 16 58 DF 9C             ;           .
L2597:           DB F9                                           ;           .
L2599:     03                                                    ;     03 DESCRIPTION
L259A:       1F 5F BE 5B B1 4B 7B 52 45 53 8B 1B                 ;       THERE IS A PLAQUE ON THE WALL ABOVE THE
L25A6:       C4 03 A0 5F BE F3 17 F3 8C B9 46 5B                 ;       LEVER.
L25B2:       CA 5F BE 3F 16 74 CA 2E                             ;       .
L25BA:     02                                                    ;     02 SHORT NAME
L25BB:       04 FB A5 A7 AD                                      ;       PLAQUE
; Object_11 UnlitCandle
L25C0:   19 6F                                                   ;   Number=19 size=006F
L25C2:     92 00 A8                                              ;     room=92 scorePoints=00 bits=A8 u.C.A...
L25C5:     03                                                    ;     03 DESCRIPTION
L25C6:       10 45 45 8E 48 DB 8B 4B 7B 83 7A 5F                 ;       A CANDLE IS IN THE ROOM.
L25D2:       BE 39 17 FF 9F                                      ;       .
L25D7:     02                                                    ;     02 SHORT NAME
L25D8:       04 10 53 FF 5A                                      ;       CANDLE
L25DD:     07 52                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L25DF:       0B 50                                               ;       Command_0B_SWITCH size=50
L25E1:         0A 14                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=14 phrase="14: LIGHT WITH  u...A...   u...A..."
L25E3:         34                                                ;         IF_NOT_JUMP address=2618
L25E4:           0E 32                                           ;           Command_0E_EXECUTE_LIST_WHILE_FAIL size=50
L25E6:             0D 2F                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=47
L25E8:               09 14                                       ;               Command_09_COMPARE_OBJECT_TO_SECOND_NOUN object=14(LitLamp
L25EA:               1E 11 12                                    ;               Command_1E_SWAP_OBJECTS objectA=11(UnlitCandle) objectB=12(LitCandle)
L25ED:               04                                          ;               Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L25EE:                 28 5F BE D3 14 46 98 4B 5E D0 B5 6B       ;                 THE CANDLE IS NOW BURNING, A SWEET SCENT
L25FA:                 A1 F4 4F 10 99 33 70 55 45 A7 D0 15       ;                 PERMEATES THE ROOM.
L2606:                 BC B0 53 12 BC 37 62 96 5F 4B 62 5F       ;                 .
L2612:                 BE 39 17 FF 9F                            ;                 .
L2617:             88                                            ;             CommonCommand_88
L2618:         15                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=15 phrase="15: EAT *       u.......   *       "
L2619:         17                                                ;         IF_NOT_JUMP address=2631
L261A:           0D 15                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=21
L261C:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L261D:               12 55 BD F5 BD F3 17 1E DA D6 15 D2         ;               TASTES WAXY, ITS POISONOUS!
L2629:               B5 55 9F 19 A0 49 C6                        ;               .
L2630:             81                                            ;             CommonCommand_81
; Object_12 LitCandle
L2631:   19 80 C6                                                ;   Number=19 size=00C6
L2634:     00 00 A8                                              ;     room=00 scorePoints=00 bits=A8 u.C.A...
L2637:     03                                                    ;     03 DESCRIPTION
L2638:       12 45 45 8E 48 DB 8B 4B 7B F4 4F 10                 ;       A CANDLE IS BURNING DIMLY. 
L2644:       99 C6 6A 6E 7A DB E0                                ;       .
L264B:     02                                                    ;     02 SHORT NAME
L264C:       0A F4 4F 10 99 C5 6A 8E 48 DB 8B                    ;       BURNING CANDLE 
L2657:     07 59                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L2659:       0E 57                                               ;       Command_0E_EXECUTE_LIST_WHILE_FAIL size=87
L265B:         0D 1C                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=28
L265D:           0E 04                                           ;           Command_0E_EXECUTE_LIST_WHILE_FAIL size=4
L265F:             0A 13                                         ;             Command_0A_COMPARE_TO_PHRASE_FORM val=13 phrase="??"
L2661:             0A 14                                         ;             Command_0A_COMPARE_TO_PHRASE_FORM val=14 phrase="14: LIGHT WITH  u...A...   u...A..."
L2663:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2664:             14 5F BE D3 14 46 98 4B 5E C3 B5 EF           ;             THE CANDLE IS ALREADY BURNING.
L2670:             8D 13 47 BF 14 D3 B2 CF 98                    ;             .
L2679:         0D 19                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=25
L267B:           0A 16                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=16 phrase="16: DROP OUT    *          u...A..."
L267D:           1E 11 12                                        ;           Command_1E_SWAP_OBJECTS objectA=11(UnlitCandle) objectB=12(LitCandle)
L2680:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2681:             12 5F BE D3 14 46 98 4B 5E C7 B5 43           ;             THE CANDLE IS EXTINGUISHED.
L268D:             D9 C7 98 5A 7B 17 60                          ;             .
L2694:         0D 1C                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=28
L2696:           0A 15                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=15 phrase="15: EAT *       u.......   *       "
L2698:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2699:             18 C7 DE 2F 17 46 48 55 DB 87 74 B3           ;             YOU REALLY SHOULD PUT IT OUT FIRST. 
L26A5:             8B 76 A7 D6 15 C7 16 08 BC 3D 7B 9B           ;             .
L26B1:             C1                                            ;             .
L26B2:     08 46                                                 ;     08 TURN SCRIPT
L26B4:       0D 44                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=68
L26B6:         1F                                                ;         Command_1F_PRINT_MESSAGE
L26B7:           24 5F BE 43 16 2E 6D 5C 15 DB 9F 5F             ;           THE LIGHT FROM THE CANDLE SEEMS TO BE
L26C3:           BE D3 14 46 98 55 5E 2F 60 D6 B5 C4             ;           GROWING DIMMER. 
L26CF:           9C 49 5E 09 B3 91 7A 03 15 67 93 1B             ;           .
L26DB:           B5                                              ;           .
L26DC:         0B 1C                                             ;         Command_0B_SWITCH size=1C
L26DE:           01 1D                                           ;           Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=1D(USER)
L26E0:           07                                              ;           IF_NOT_JUMP address=26E8
L26E1:             0D 05                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=5
L26E3:               1C 1D                                       ;               Command_1C_SET_VAR_OBJECT object=1D (USER)
L26E5:               1D 14                                       ;               Command_1D_ATTACK_OBJECT damage=14
L26E7:               0C                                          ;               Command_0C_FAIL
L26E8:           1E                                              ;           Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=1E(LiveGargoyle)
L26E9:           07                                              ;           IF_NOT_JUMP address=26F1
L26EA:             0D 05                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=5
L26EC:               1C 1E                                       ;               Command_1C_SET_VAR_OBJECT object=1E (LiveGargoyle)
L26EE:               1D 32                                       ;               Command_1D_ATTACK_OBJECT damage=32
L26F0:               0C                                          ;               Command_0C_FAIL
L26F1:           15                                              ;           Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=15(LiveSerpent)
L26F2:           07                                              ;           IF_NOT_JUMP address=26FA
L26F3:             0D 05                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=5
L26F5:               1C 15                                       ;               Command_1C_SET_VAR_OBJECT object=15 (LiveSerpent)
L26F7:               1D 0F                                       ;               Command_1D_ATTACK_OBJECT damage=0F
L26F9:               0C                                          ;               Command_0C_FAIL
; Object_13 CrypticRunes
L26FA:   18 80 84                                                ;   Number=18 size=0084
L26FD:     92 00 84                                              ;     room=92 scorePoints=00 bits=84 u....X..
L2700:     07 5B                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L2702:       0D 59                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=89
L2704:         0A 08                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=08 phrase="08: READ *      .....X..   *       "
L2706:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2707:           55 9E 7A D6 9C DB 72 70 C0 6E 98 30             ;           INTO THE TUNNEL ENTERS THE SEEKER, BRAVELY
L2713:           15 F4 BD D6 B5 DB 72 A7 B7 B4 85 04             ;           AND WISELY HE GOES. FOR HE WILL RECOGNIZE
L271F:           EE D8 B0 53 61 90 14 19 58 57 7B FB             ;           THE REAPER, AS THE LIGHT BEFORE HIM GLOWS.
L272B:           8E DB 72 37 6E 5B BB 04 68 9F 15 FB             ;           .
L2737:           17 F3 8C 65 B1 00 9F 6F 7C 82 17 54             ;           .
L2743:           5E 92 5F 46 62 95 14 82 17 4E 5E 7A             ;           .
L274F:           79 04 BC 59 60 5B B1 8F 73 7E 15 85             ;           .
L275B:           A1 2E                                           ;           .
L275D:     03                                                    ;     03 DESCRIPTION
L275E:       1C 5F BE 5B B1 2F 49 E4 14 EE DE CB                 ;       THERE ARE CRYPTIC RUNES ABOVE THE TUNNEL. 
L276A:       78 F0 B3 4B 62 B9 46 5B CA 5F BE 8F                 ;       .
L2776:       17 CF 99 9B 8F                                      ;       .
L277B:     02                                                    ;     02 SHORT NAME
L277C:       04 F0 B3 4B 62                                      ;       RUNES 
; Object_14 LitLamp
L2781:   1B 80 B5                                                ;   Number=1B size=00B5
L2784:     A0 00 AC                                              ;     room=A0 scorePoints=00 bits=AC u.C.AX..
L2787:     03                                                    ;     03 DESCRIPTION
L2788:       14 5F BE 5B B1 4B 7B 44 45 38 C6 91                 ;       THERE IS A BURNING LAMP HERE. 
L2794:       7A 3B 16 D3 93 F4 72 DB 63                          ;       .
L279D:     07 80 8F                                              ;     07 COMMAND HANDLING IF FIRST NOUN
L27A0:       0E 80 8C                                            ;       Command_0E_EXECUTE_LIST_WHILE_FAIL size=140
L27A3:         0D 1B                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=27
L27A5:           0E 04                                           ;           Command_0E_EXECUTE_LIST_WHILE_FAIL size=4
L27A7:             0A 13                                         ;             Command_0A_COMPARE_TO_PHRASE_FORM val=13 phrase="??"
L27A9:             0A 14                                         ;             Command_0A_COMPARE_TO_PHRASE_FORM val=14 phrase="14: LIGHT WITH  u...A...   u...A..."
L27AB:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L27AC:             13 5F BE 3B 16 D3 93 4B 7B 4C 48 86           ;             THE LAMP IS ALREADY BURNING.
L27B8:             5F 44 DB 38 C6 91 7A 2E                       ;             .
L27C0:         0B 6D                                             ;         Command_0B_SWITCH size=6D
L27C2:           0A 16                                           ;           Command_0A_COMPARE_TO_PHRASE_FORM val=16 phrase="16: DROP OUT    *          u...A..."
L27C4:           12                                              ;           IF_NOT_JUMP address=27D7
L27C5:             0D 10                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=16
L27C7:               1E 28 14                                    ;               Command_1E_SWAP_OBJECTS objectA=28(UnlitLamp) objectB=14(LitLamp)
L27CA:               04                                          ;               Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L27CB:                 0B 5F BE 3B 16 D3 93 4B 7B 36 A1 2E       ;                 THE LAMP IS OUT.
L27D7:           18                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=18 phrase="18: RUB *       u.......   *       "
L27D8:           2D                                              ;           IF_NOT_JUMP address=2806
L27D9:             0D 2B                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=43
L27DB:               04                                          ;               Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L27DC:                 26 5F BE 3B 16 D3 93 37 6E D1 B5 97       ;                 THE LAMP GOES OUT. YOU MUST HAVE RUBBED IT
L27E8:                 C6 51 18 4F C2 66 C6 9B 15 5B CA E4       ;                 THE WRONG WAY!
L27F4:                 B3 66 4D D6 15 82 17 59 5E 00 B3 D9       ;                 .
L2800:                 6A 39 4A                                  ;                 .
L2803:               1E 28 14                                    ;               Command_1E_SWAP_OBJECTS objectA=28(UnlitLamp) objectB=14(LitLamp)
L2806:           08                                              ;           Command_0A_COMPARE_TO_PHRASE_FORM val=08 phrase="08: READ *      .....X..   *       "
L2807:           27                                              ;           IF_NOT_JUMP address=282F
L2808:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2809:               25 5F BE 3B 16 D3 93 4B 7B 48 55 2F         ;               THE LAMP IS COVERED WITH TARNISH AND YOU
L2815:               62 19 58 82 7B 7B 17 D3 B2 13 B8 8E         ;               CAN'T READ IT.
L2821:               48 51 18 45 C2 85 48 14 BC 86 5F D6         ;               .
L282D:               15 2E                                       ;               .
L282F:     02                                                    ;     02 SHORT NAME
L2830:       08 F4 4F 10 99 CE 6A 72 48                          ;       BURNING LAMP
; Object_15 LiveSerpent
L2839:   24 81 C0                                                ;   Number=24 size=01C0
L283C:     00 00 90                                              ;     room=00 scorePoints=00 bits=90 u..P....
L283F:     03                                                    ;     03 DESCRIPTION
L2840:       1C 4E 45 31 49 55 5E 3A 62 9E 61 43                 ;       A LARGE SERPENT LIES COILED ON THE FLOOR. 
L284C:       16 4B 62 3B 55 E6 8B C0 16 82 17 48                 ;       .
L2858:       5E 81 8D 1B B5                                      ;       .
L285D:     09 02 3C 3C                                           ;     09 HIT POINTS maxHitPoints=3C currentHitPoints=3C
L2861:     07 80 B3                                              ;     07 COMMAND HANDLING IF FIRST NOUN
L2864:       0B 80 B0                                            ;       Command_0B_SWITCH size=B0
L2867:         0A 09                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=09 phrase="09: ATTACK WITH ...P....   .v......"
L2869:         80 9A                                             ;         IF_NOT_JUMP address=2905
L286B:           0D 80 97                                        ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=151
L286E:             1A                                            ;             Command_1A_SET_VAR_OBJECT_TO_FIRST_NOUN
L286F:             09 09                                         ;             Command_09_COMPARE_OBJECT_TO_SECOND_NOUN object=09(Sword
L2871:             0B 80 91                                      ;             Command_0B_SWITCH size=91
L2874:               05 99                                       ;               Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=99
L2876:               2B                                          ;               IF_NOT_JUMP address=28A2
L2877:                 0D 29                                     ;                 Command_0D_EXECUTE_LIST_WHILE_PASS size=41
L2879:                   04                                      ;                   Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L287A:                     03 C7 DE 52                           ;                     YOUR
L287E:                   12                                      ;                   Command_12_PRINT_SECOND_NOUN_SHORT_NAME
L287F:                   04                                      ;                   Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2880:                     1F 50 B8 CB 87 6B BF 5F BE A3 15 33   ;                     SINKS TO THE HILT IN THE SERPENT'S SCALY
L288C:                     8E 83 7A 5F BE 57 17 1F B3 B5 9A D5   ;                     BODY!
L2898:                     B5 0E 53 44 DB 93 9E 21               ;                     .
L28A0:                   1D 11                                   ;                   Command_1D_ATTACK_OBJECT damage=11
L28A2:               CC                                          ;               Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=CC
L28A3:               2E                                          ;               IF_NOT_JUMP address=28D2
L28A4:                 0D 2C                                     ;                 Command_0D_EXECUTE_LIST_WHILE_PASS size=44
L28A6:                   04                                      ;                   Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L28A7:                     03 C7 DE 52                           ;                     YOUR
L28AB:                   12                                      ;                   Command_12_PRINT_SECOND_NOUN_SHORT_NAME
L28AC:                   04                                      ;                   Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L28AD:                     24 6C BE 85 A1 7B 14 29 B8 B4 D0 B8   ;                     THROWS A SHOWER OF SPARKS AS IT GLANCES OFF
L28B9:                     16 62 17 35 49 C3 B5 CB B5 09 BC 50   ;                     THE WALL! 
L28C5:                     8B B5 53 B8 16 96 64 DB 72 0E D0 AB   ;                     .
L28D1:                     89                                    ;                     .
L28D2:               FF                                          ;               Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=FF
L28D3:               31                                          ;               IF_NOT_JUMP address=2905
L28D4:                 0D 2F                                     ;                 Command_0D_EXECUTE_LIST_WHILE_PASS size=47
L28D6:                   04                                      ;                   Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L28D7:                     2B 5F BE 57 17 1F B3 B5 9A CA B5 86   ;                     THE SERPENT'S HEAD IS SEVERED FROM HIS BODY!
L28E3:                     5F D5 15 57 17 74 CA F3 5F 79 68 4A   ;                     A MAGNIFICENT BLOW!
L28EF:                     90 4B 7B F6 4E EB DA 4F 45 80 47 53   ;                     .
L28FB:                     79 B0 53 04 BC 89 8D 21               ;                     .
L2903:                   1D FF                                   ;                   Command_1D_ATTACK_OBJECT damage=FF
L2905:         15                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=15 phrase="15: EAT *       u.......   *       "
L2906:         10                                                ;         IF_NOT_JUMP address=2917
L2907:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2908:             0E 76 4D F4 BD 1B 16 F3 8C 73 7B 14           ;             BETTER KILL IT FIRST!
L2914:             67 F1 B9                                      ;             .
L2917:     08 80 C4                                              ;     08 TURN SCRIPT
L291A:       0D 80 C1                                            ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=193
L291D:         0E 3E                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=62
L291F:           0D 32                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=50
L2921:             14                                            ;             Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L2922:               01 1D                                       ;               Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=1D(USER)
L2924:             0B 19                                         ;             Command_0B_SWITCH size=19
L2926:               0A 04                                       ;               Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L2928:               04                                          ;               IF_NOT_JUMP address=292D
L2929:                 21 04 00 00                               ;                 Command_21_EXECUTE_PHRASE phrase="04: WEST *      *          *       " first=00(NONE)  second=00(NONE)
L292D:               03                                          ;               Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L292E:               04                                          ;               IF_NOT_JUMP address=2933
L292F:                 21 03 00 00                               ;                 Command_21_EXECUTE_PHRASE phrase="03: EAST *      *          *       " first=00(NONE)  second=00(NONE)
L2933:               01                                          ;               Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L2934:               04                                          ;               IF_NOT_JUMP address=2939
L2935:                 21 01 00 00                               ;                 Command_21_EXECUTE_PHRASE phrase="01: NORTH *     *          *       " first=00(NONE)  second=00(NONE)
L2939:               02                                          ;               Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L293A:               04                                          ;               IF_NOT_JUMP address=293F
L293B:                 21 02 00 00                               ;                 Command_21_EXECUTE_PHRASE phrase="02: SOUTH *     *          *       " first=00(NONE)  second=00(NONE)
L293F:             1F                                            ;             Command_1F_PRINT_MESSAGE
L2940:               12 5F BE 57 17 1F B3 B3 9A 74 A7 27         ;               THE SERPENT PURSUES YOU AND
L294C:               BA DB B5 1B A1 8E 48                        ;               .
L2953:           1F                                              ;           Command_1F_PRINT_MESSAGE
L2954:             08 5F BE 57 17 1F B3 B3 9A                    ;             THE SERPENT 
L295D:         0D 7F                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=127
L295F:           01 1D                                           ;           Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=1D(USER)
L2961:           1C 1D                                           ;           Command_1C_SET_VAR_OBJECT object=1D (USER)
L2963:           0B 79                                           ;           Command_0B_SWITCH size=79
L2965:             05 33                                         ;             Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=33
L2967:             23                                            ;             IF_NOT_JUMP address=298B
L2968:               0D 21                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=33
L296A:                 1F                                        ;                 Command_1F_PRINT_MESSAGE
L296B:                   1D 0C BA 17 7A 33 BB 7B A6 40 B9 E1     ;                   STRIKES, POISON COURSES THROUGH YOUR VEINS!
L2977:                   14 3D C6 4B 62 6C BE 29 A1 1B 71 34     ;                   .
L2983:                   A1 CF 17 9D 7A 21                       ;                   .
L2989:                 1D 14                                     ;                 Command_1D_ATTACK_OBJECT damage=14
L298B:             99                                            ;             Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=99
L298C:             16                                            ;             IF_NOT_JUMP address=29A3
L298D:               1F                                          ;               Command_1F_PRINT_MESSAGE
L298E:                 14 0C BA 17 7A 33 BB C7 DE 09 15 37       ;                 STRIKES, YOU DODGE HIS LUNGE! 
L299A:                 5A A3 15 CE B5 91 C5 EB 5D                ;                 .
L29A3:             CC                                            ;             Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=CC
L29A4:             21                                            ;             IF_NOT_JUMP address=29C6
L29A5:               0D 1F                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=31
L29A7:                 1F                                        ;                 Command_1F_PRINT_MESSAGE
L29A8:                   1B 3B 55 0B 8E D2 B0 06 79 43 DB 07     ;                   COILS RAPIDLY AROUND YOU AND CONSTRICTS!
L29B4:                   B3 33 98 C7 DE 90 14 05 58 1D A0 F3     ;                   .
L29C0:                   BF 0D 56 21                             ;                   .
L29C4:                 1D 14                                     ;                 Command_1D_ATTACK_OBJECT damage=14
L29C6:             FF                                            ;             Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=FF
L29C7:             16                                            ;             IF_NOT_JUMP address=29DE
L29C8:               1F                                          ;               Command_1F_PRINT_MESSAGE
L29C9:                 14 16 6C F4 72 CB B5 17 C0 03 8C 04       ;                 GATHERS ITSELF FOR AN ATTACK. 
L29D5:                 68 90 14 96 14 45 BD 5B 89                ;                 .
L29DE:     0A 15                                                 ;     0A UPON DEATH SCRIPT
L29E0:       0D 13                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=19
L29E2:         1F                                                ;         Command_1F_PRINT_MESSAGE
L29E3:           0E 5F BE 57 17 1F B3 B3 9A 4B 7B E3             ;           THE SERPENT IS DEAD. 
L29EF:           59 9B 5D                                        ;           .
L29F2:         1E 15 16                                          ;         Command_1E_SWAP_OBJECTS objectA=15(LiveSerpent) objectB=16(DeadSerpent)
L29F5:     02                                                    ;     02 SHORT NAME
L29F6:       05 B4 B7 F0 A4 54                                   ;       SERPENT
; Object_16 DeadSerpent
L29FC:   24 40                                                   ;   Number=24 size=0040
L29FE:     00 00 80                                              ;     room=00 scorePoints=00 bits=80 u.......
L2A01:     03                                                    ;     03 DESCRIPTION
L2A02:       1A 4E 45 31 49 46 5E 86 5F 57 17 1F                 ;       A LARGE DEAD SERPENT LIES ON THE FLOOR.
L2A0E:       B3 B3 9A 87 8C D1 B5 96 96 DB 72 89                 ;       .
L2A1A:       67 C7 A0                                            ;       .
L2A1D:     07 15                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L2A1F:       0D 13                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=19
L2A21:         0A 15                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=15 phrase="15: EAT *       u.......   *       "
L2A23:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2A24:           0F A8 77 4E 5E E6 A0 7B 16 92 14 F6             ;           I'VE LOST MY APPETITE!
L2A30:           A4 7F 7B 21                                     ;           .
L2A34:     02                                                    ;     02 SHORT NAME
L2A35:       08 E3 59 15 58 3A 62 9E 61                          ;       DEAD SERPENT
; Object_17 Hands
L2A3E:   1F 09                                                   ;   Number=1F size=0009
L2A40:     FF 00 80                                              ;     room=FF scorePoints=00 bits=80 u.......
L2A43:     02                                                    ;     02 SHORT NAME
L2A44:       04 50 72 0B 5C                                      ;       HANDS 
; Object_18 Coin
L2A49:   20 34                                                   ;   Number=20 size=0034
L2A4B:     9C 05 A4                                              ;     room=9C scorePoints=05 bits=A4 u.C..X..
L2A4E:     03                                                    ;     03 DESCRIPTION
L2A4F:       14 5F BE 5B B1 4B 7B 45 45 50 9F C0                 ;       THERE IS A COIN ON THE GROUND.
L2A5B:       16 82 17 49 5E 07 B3 57 98                          ;       .
L2A64:     07 14                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L2A66:       0D 12                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=18
L2A68:         0A 08                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=08 phrase="08: READ *      .....X..   *       "
L2A6A:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2A6B:           0E 2C 1D D5 47 F3 5F 5B 4D C3 B0 1D             ;           "PRAISED BE RAAKA-TU"
L2A77:           85 5C C0                                        ;           .
L2A7A:     02                                                    ;     02 SHORT NAME
L2A7B:       03 3B 55 4E                                         ;       COIN
; Object_19 TinySlot
L2A7F:   21 7F                                                   ;   Number=21 size=007F
L2A81:     88 00 80                                              ;     room=88 scorePoints=00 bits=80 u.......
L2A84:     03                                                    ;     03 DESCRIPTION
L2A85:       1D 5F BE 5B B1 4B 7B 56 45 A3 7A 5E                 ;       THERE IS A TINY SLOT CUT IN THE NORTH WALL.
L2A91:       17 F3 A0 36 56 D0 15 82 17 50 5E BE                 ;       .
L2A9D:       A0 19 71 46 48 2E                                   ;       .
L2AA3:     02                                                    ;     02 SHORT NAME
L2AA4:       06 90 BE 55 DB 86 8D                                ;       TINY SLOT
L2AAB:     06 53                                                 ;     06 COMMAND HANDLING IF SECOND NOUN
L2AAD:       0D 51                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=81
L2AAF:         0A 0F                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=0F phrase="0F: DROP IN     u.......   u......."
L2AB1:         0E 4D                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=77
L2AB3:           0D 24                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=36
L2AB5:             14                                            ;             Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L2AB6:               08 18                                       ;               Command_08_COMPARE_OBJECT_TO_FIRST_NOUN object=18(Coin
L2AB8:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2AB9:               02 5F BE                                    ;               THE
L2ABC:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L2ABD:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2ABE:               1A 4B 7B 81 BF B3 14 D6 6A C8 9C 73         ;               IS TOO BIG TO FIT IN SUCH A TINY SLOT. 
L2ACA:               7B 83 7A 25 BA 03 71 83 17 7B 9B C9         ;               .
L2AD6:               B8 9B C1                                    ;               .
L2AD9:           0D 25                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=37
L2ADB:             17 06 00                                      ;             Command_17_MOVE_OBJECT_TO_LOCATION object=06(StatueEast) location=00
L2ADE:             17 07 88                                      ;             Command_17_MOVE_OBJECT_TO_LOCATION object=07(StatueWest) location=88
L2AE1:             17 18 00                                      ;             Command_17_MOVE_OBJECT_TO_LOCATION object=18(Coin) location=00
L2AE4:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2AE5:               1A 5F BE 66 17 8F 49 56 5E 38 C6 D6         ;               THE STATUE TURNS TO FACE THE WEST DOOR.
L2AF1:               B5 C8 9C D7 46 82 17 59 5E 66 62 09         ;               .
L2AFD:               15 C7 A0                                    ;               .
; Object_1A MessageUnderSlot
L2B00:   18 53                                                   ;   Number=18 size=0053
L2B02:     88 00 84                                              ;     room=88 scorePoints=00 bits=84 u....X..
L2B05:     03                                                    ;     03 DESCRIPTION
L2B06:       1C 5F BE 5B B1 4B 7B 4F 45 65 62 77                 ;       THERE IS A MESSAGE CARVED UNDER THE SLOT. 
L2B12:       47 D3 14 0F B4 17 58 3F 98 96 AF DB                 ;       .
L2B1E:       72 C9 B8 9B C1                                      ;       .
L2B23:     02                                                    ;     02 SHORT NAME
L2B24:       0A 14 53 66 CA 67 16 D3 B9 9B 6C                    ;       CARVED MESSAGE 
L2B2F:     07 24                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L2B31:       0D 22                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=34
L2B33:         0A 08                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=08 phrase="08: READ *      .....X..   *       "
L2B35:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2B36:           1E 5F BE 67 16 D3 B9 9B 6C 1B B7 33             ;           THE MESSAGE SAYS, "SAFE PASSAGE FOR A
L2B42:           BB 93 1D 5B 66 55 A4 09 B7 48 5E A3             ;           PRICE."
L2B4E:           A0 52 45 05 B2 DC 63                            ;           .
; Object_1B ClosedDoor
L2B55:   09 3B                                                   ;   Number=09 size=003B
L2B57:     90 00 80                                              ;     room=90 scorePoints=00 bits=80 u.......
L2B5A:     03                                                    ;     03 DESCRIPTION
L2B5B:       0D 5F BE 09 15 A3 A0 4B 7B C9 54 A6                 ;       THE DOOR IS CLOSED.
L2B67:       B7 2E                                               ;       .
L2B69:     02                                                    ;     02 SHORT NAME
L2B6A:       03 81 5B 52                                         ;       DOOR
L2B6E:     07 22                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L2B70:       0D 20                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=32
L2B72:         0A 11                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=11 phrase="11: OPEN *      u.......   *       "
L2B74:         17 1B 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=1B(ClosedDoor) location=00
L2B77:         17 1C 90                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=1C(OpenDoor) location=90
L2B7A:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2B7B:           16 7C B3 6F B3 27 60 2D 60 8B 18 5F             ;           RRRRREEEEEEK - THE DOOR IS OPEN. 
L2B87:           BE 09 15 A3 A0 4B 7B 5F A0 1B 9C                ;           .
; Object_1C OpenDoor
L2B92:   09 30                                                   ;   Number=09 size=0030
L2B94:     00 00 80                                              ;     room=00 scorePoints=00 bits=80 u.......
L2B97:     03                                                    ;     03 DESCRIPTION
L2B98:       12 5F BE 09 15 A3 A0 4B 7B FB B9 43                 ;       THE DOOR IS STANDING OPEN. 
L2BA4:       98 AB 98 5F A0 1B 9C                                ;       .
L2BAB:     02                                                    ;     02 SHORT NAME
L2BAC:       03 81 5B 52                                         ;       DOOR
L2BB0:     07 12                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L2BB2:       0D 10                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=16
L2BB4:         0A 11                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=11 phrase="11: OPEN *      u.......   *       "
L2BB6:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2BB7:           0C 8D 7B 8E 14 63 B1 FB 5C 5F A0 1B             ;           ITS ALREADY OPEN. 
L2BC3:           9C                                              ;           .
; Object_1D USER
L2BC4:   FF 80 87                                                ;   Number=FF size=0087
L2BC7:     96 00 80                                              ;     room=96 scorePoints=00 bits=80 u.......
L2BCA:     0A 76                                                 ;     0A UPON DEATH SCRIPT
L2BCC:       0E 74                                               ;       Command_0E_EXECUTE_LIST_WHILE_FAIL size=116
L2BCE:         0B 07                                             ;         Command_0B_SWITCH size=07
L2BD0:           20 1D                                           ;           Command_20_CHECK_ACTIVE_OBJECT object=1D(USER)
L2BD2:           01                                              ;           IF_NOT_JUMP address=2BD4
L2BD3:             81                                            ;             CommonCommand_81
L2BD4:           23                                              ;           Command_20_CHECK_ACTIVE_OBJECT object=23(Guards)
L2BD5:           01                                              ;           IF_NOT_JUMP address=2BD7
L2BD6:             81                                            ;             CommonCommand_81
L2BD7:         0D 69                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=105
L2BD9:           1F                                              ;           Command_1F_PRINT_MESSAGE
L2BDA:             66 C7 DE DB 16 CB B9 36 A1 59 F4 F0           ;             YOU PASS OUT. WHEN YOU AWAKEN, YOU FIND
L2BE6:             72 51 18 43 C2 0D D0 A6 61 51 18 48           ;             YOURSELF CHAINED TO A BLOOD STAINED ALTAR. A
L2BF2:             C2 8E 7A 51 18 3D C6 40 61 DA 14 D0           ;             PRIEST IS KNEELING OVER YOU WITH A KNIFE. IT
L2BFE:             47 F3 5F 6B BF 44 45 81 8D 15 58 4B           ;             LOOKS LIKE THIS IS IT. 
L2C0A:             BD 66 98 8E 14 54 BD 43 F4 EC 16 35           ;             .
L2C16:             79 0B BC CD B5 67 98 90 8C D1 6A 74           ;             .
L2C22:             CA 51 18 59 C2 82 7B 7B 14 13 87 7F           ;             .
L2C2E:             66 D6 15 49 16 A5 9F 43 16 9B 85 63           ;             .
L2C3A:             BE CB B5 CB B5 9B C1                          ;             .
L2C41:           81                                              ;           CommonCommand_81
L2C42:     08 06                                                 ;     08 TURN SCRIPT
L2C44:       0D 04                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=4
L2C46:         1C 1D                                             ;         Command_1C_SET_VAR_OBJECT object=1D (USER)
L2C48:         23 05                                             ;         Command_23_HEAL_VAR_OBJECT value=05
L2C4A:     09 02 46 46                                           ;     09 HIT POINTS maxHitPoints=46 currentHitPoints=46
; Object_1E LiveGargoyle
L2C4E:   0F 81 B4                                                ;   Number=0F size=01B4
L2C51:     00 00 90                                              ;     room=00 scorePoints=00 bits=90 u..P....
L2C54:     03                                                    ;     03 DESCRIPTION
L2C55:       25 5F BE 5B B1 4B 7B 4A 45 FF 78 35                 ;       THERE IS A HIDEOUS GARGOYLE BLOCKING THE
L2C61:       A1 73 15 C1 B1 3F DE B6 14 5D 9E 91                 ;       NORTH PASSAGE.
L2C6D:       7A 82 17 50 5E BE A0 12 71 65 49 77                 ;       .
L2C79:       47 2E                                               ;       .
L2C7B:     02                                                    ;     02 SHORT NAME
L2C7C:       06 14 6C 4B 6E DB 8B                                ;       GARGOYLE 
L2C83:     09 02 FF FF                                           ;     09 HIT POINTS maxHitPoints=FF currentHitPoints=FF
L2C87:     07 22                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L2C89:       0D 20                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=32
L2C8B:         0A 15                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=15 phrase="15: EAT *       u.......   *       "
L2C8D:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2C8E:           1C DD 72 F3 8C 96 5F 51 18 4E C2 11             ;           HE'LL EAT YOU LONG BEFORE YOU'LL EAT HIM! 
L2C9A:           A0 AF 14 04 68 5B 5E 1D A1 F3 8C 96             ;           .
L2CA6:           5F A3 15 EB 8F                                  ;           .
L2CAB:     08 81 29                                              ;     08 TURN SCRIPT
L2CAE:       0D 81 26                                            ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=294
L2CB1:         01 1D                                             ;         Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=1D(USER)
L2CB3:         1C 1D                                             ;         Command_1C_SET_VAR_OBJECT object=1D (USER)
L2CB5:         14                                                ;         Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L2CB6:           01 12                                           ;           Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=12(LitCandle)
L2CB8:         0B 81 1C                                          ;         Command_0B_SWITCH size=11C
L2CBB:           05 19                                           ;           Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=19
L2CBD:           2E                                              ;           IF_NOT_JUMP address=2CEC
L2CBE:             0D 2C                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=44
L2CC0:               1F                                          ;               Command_1F_PRINT_MESSAGE
L2CC1:                 28 5F BE 73 15 C1 B1 3F DE 81 15 75       ;                 THE GARGOYLE GORES YOU WITH HIS HORN AND
L2CCD:                 B1 51 18 59 C2 82 7B A3 15 CA B5 B8       ;                 RIPS YOUR GUTS OUT!
L2CD9:                 A0 90 14 14 58 ED 7A 51 18 23 C6 36       ;                 .
L2CE5:                 6F D1 B5 71 C6                            ;                 .
L2CEA:               1D FF                                       ;               Command_1D_ATTACK_OBJECT damage=FF
L2CEC:           3F                                              ;           Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=3F
L2CED:           21                                              ;           IF_NOT_JUMP address=2D0F
L2CEE:             0D 1F                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=31
L2CF0:               1F                                          ;               Command_1F_PRINT_MESSAGE
L2CF1:                 1B 5F BE 73 15 C1 B1 3F DE DE 14 05       ;                 THE GARGOYLE CLAWS YOU ACROSS THE CHEST!
L2CFD:                 4A 51 18 43 C2 B9 55 CB B9 5F BE DA       ;                 .
L2D09:                 14 66 62 21                               ;                 .
L2D0D:               1D 32                                       ;               Command_1D_ATTACK_OBJECT damage=32
L2D0F:           64                                              ;           Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=64
L2D10:           2E                                              ;           IF_NOT_JUMP address=2D3F
L2D11:             0D 2C                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=44
L2D13:               1F                                          ;               Command_1F_PRINT_MESSAGE
L2D14:                 28 C7 DE 4F 15 33 61 5F BE 80 15 5A       ;                 YOU FEEL THE GNASHING OF THE GARGOYLE'S
L2D20:                 49 91 7A B8 16 82 17 49 5E 31 49 CE       ;                 TEETH IN YOUR SIDE! 
L2D2C:                 A1 A5 5E 7F 17 82 62 D0 15 51 18 23       ;                 .
L2D38:                 C6 46 B8 EB 5D                            ;                 .
L2D3D:               1D 32                                       ;               Command_1D_ATTACK_OBJECT damage=32
L2D3F:           A3                                              ;           Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=A3
L2D40:           3C                                              ;           IF_NOT_JUMP address=2D7D
L2D41:             0D 3A                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=58
L2D43:               1F                                          ;               Command_1F_PRINT_MESSAGE
L2D44:                 36 5F BE DE 14 05 4A B8 16 82 17 49       ;                 THE CLAWS OF THE GARGOYLE RIP THROUGH YOUR
L2D50:                 5E 31 49 CE A1 54 5E D3 7A 6C BE 29       ;                 ARM IN AN ATTEMPT TO REACH YOUR BODY! 
L2D5C:                 A1 1B 71 34 A1 94 14 4B 90 83 96 83       ;                 .
L2D68:                 96 3F C0 EE 93 89 17 2F 17 DA 46 51       ;                 .
L2D74:                 18 23 C6 F6 4E EB DA                      ;                 .
L2D7B:               1D 19                                       ;               Command_1D_ATTACK_OBJECT damage=19
L2D7D:           E1                                              ;           Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=E1
L2D7E:           3E                                              ;           IF_NOT_JUMP address=2DBD
L2D7F:             0D 3C                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=60
L2D81:               1F                                          ;               Command_1F_PRINT_MESSAGE
L2D82:                 38 5F BE 73 15 C1 B1 3F DE 4F 16 B7       ;                 THE GARGOYLE LUNGES AT YOUR FACE BUT YOU
L2D8E:                 98 C3 B5 1B BC 34 A1 4B 15 9B 53 F6       ;                 PULL BACK.  HE BITES YOUR SHOULDER INSTEAD!
L2D9A:                 4F 51 18 52 C2 46 C5 AB 14 AF 54 4A       ;                 .
L2DA6:                 13 44 5E 7F 7B DB B5 34 A1 5A 17 2E       ;                 .
L2DB2:                 A1 F4 59 D0 15 FF B9 F1 46                ;                 .
L2DBB:               1D 19                                       ;               Command_1D_ATTACK_OBJECT damage=19
L2DBD:           FF                                              ;           Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=FF
L2DBE:           18                                              ;           IF_NOT_JUMP address=2DD7
L2DBF:             0D 16                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=22
L2DC1:               1F                                          ;               Command_1F_PRINT_MESSAGE
L2DC2:                 14 C7 DE 09 15 37 5A 82 17 49 5E 31       ;                 YOU DODGE THE GARGOYLE'S HORN.
L2DCE:                 49 CE A1 A5 5E A9 15 E7 B2                ;                 .
L2DD7:     0A 2C                                                 ;     0A UPON DEATH SCRIPT
L2DD9:       0D 2A                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=42
L2DDB:         1F                                                ;         Command_1F_PRINT_MESSAGE
L2DDC:           22 5F BE 73 15 C1 B1 3F DE 7B 17 B5             ;           THE GARGOYLE TAKES A FINAL BREATH AND THEN
L2DE8:           85 7B 14 10 67 33 48 6F 4F 82 49 90             ;           EXPIRES.
L2DF4:           14 16 58 F0 72 3A 15 94 A5 6F 62                ;           .
L2DFF:         17 1E 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=1E(LiveGargoyle) location=00
L2E02:         17 1F 8E                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=1F(DeadGargoyle) location=8E
; Object_1F DeadGargoyle
L2E05:   0F 53                                                   ;   Number=0F size=0053
L2E07:     00 00 80                                              ;     room=00 scorePoints=00 bits=80 u.......
L2E0A:     03                                                    ;     03 DESCRIPTION
L2E0B:       24 5F BE 5B B1 4B 7B 5F BE FF 14 F3                 ;       THERE IS THE DEAD CARCASS OF AN UGLY
L2E17:       46 14 53 15 53 D1 B5 83 64 97 96 D3                 ;       GARGOYLE NEARBY. 
L2E23:       6D 73 15 C1 B1 3F DE 8F 16 2C 49 DB                 ;       .
L2E2F:       E0                                                  ;       .
L2E30:     07 1D                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L2E32:       0D 1B                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=27
L2E34:         0A 15                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=15 phrase="15: EAT *       u.......   *       "
L2E36:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2E37:           17 7A C4 CB 06 82 17 95 7A BD 15 49             ;           UGH! I THINK I'M GOING TO BE SICK!
L2E43:           90 50 9F D6 6A C4 9C 55 5E DD 78 21             ;           .
L2E4F:     02                                                    ;     02 SHORT NAME
L2E50:       09 E3 59 09 58 31 49 CE A1 45                       ;       DEAD GARGOYLE
; Object_20 Wall
L2E5A:   25 32                                                   ;   Number=25 size=0032
L2E5C:     FF 00 80                                              ;     room=FF scorePoints=00 bits=80 u.......
L2E5F:     07 28                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L2E61:       0B 26                                               ;       Command_0B_SWITCH size=26
L2E63:         0A 17                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=17 phrase="17: CLIMB *     u.......   *       "
L2E65:         20                                                ;         IF_NOT_JUMP address=2E86
L2E66:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L2E67:             1E C7 DE D3 14 90 96 F3 A0 C3 54 A3           ;             YOU CAN NOT CLIMB THE WALL, IT IS TOO
L2E73:             91 5F BE F3 17 16 8D D6 15 D5 15 89           ;             SMOOTH.
L2E7F:             17 D5 9C C1 93 77 BE                          ;             .
L2E86:         34                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=34 phrase="34: JUMP OVER   *          u......."
L2E87:         01                                                ;         IF_NOT_JUMP address=2E89
L2E88:           89                                              ;           CommonCommand_89
L2E89:     02                                                    ;     02 SHORT NAME
L2E8A:       03 0E D0 4C                                         ;       WALL
; Object_21 Vines
L2E8E:   26 29                                                   ;   Number=26 size=0029
L2E90:     9D 00 80                                              ;     room=9D scorePoints=00 bits=80 u.......
L2E93:     03                                                    ;     03 DESCRIPTION
L2E94:       1E 4E 45 31 49 50 5E 91 62 B5 A0 B8                 ;       A LARGE NETWORK OF VINES CLINGS TO THE WALL.
L2EA0:       16 D3 17 75 98 DE 14 91 7A D6 B5 D6                 ;       
L2EAC:       9C DB 72 0E D0 9B 8F                                ;       .
L2EB3:     02                                                    ;     02 SHORT NAME
L2EB4:       04 10 CB 4B 62                                      ;       VINES 
; Object_22 GoldenChopstick
L2EB9:   1E 28                                                   ;   Number=1E size=0028
L2EBB:     8F 05 A0                                              ;     room=8F scorePoints=05 bits=A0 u.C.....
L2EBE:     03                                                    ;     03 DESCRIPTION
L2EBF:       16 5F BE 5B B1 4B 7B 49 45 BE 9F 83                 ;       THERE IS A GOLDEN CHOPSTICK HERE.
L2ECB:       61 29 54 26 A7 DD 78 9F 15 7F B1                    ;       .
L2ED6:     02                                                    ;     02 SHORT NAME
L2ED7:       0B 3E 6E F0 59 DA 14 6D A0 85 BE 4B                 ;       GOLDEN CHOPSTICK
; Object_23 Guards
L2EE3:   28 80 CA                                                ;   Number=28 size=00CA
L2EE6:     9C 00 90                                              ;     room=9C scorePoints=00 bits=90 u..P....
L2EE9:     03                                                    ;     03 DESCRIPTION
L2EEA:       27 B8 B7 2B 62 09 8A 94 C3 0B 5C 14                 ;       SEVERAL GUARDS CARRYING LETHAL CROSSBOWS
L2EF6:       53 8B B4 AB 98 F6 8B 4E 72 E4 14 E5                 ;       TURN TO FACE YOU.
L2F02:       A0 09 4F D6 B5 38 C6 89 17 4B 15 9B                 ;       .
L2F0E:       53 C7 DE 2E                                         ;       .
L2F12:     08 80 95                                              ;     08 TURN SCRIPT
L2F15:       0E 80 92                                            ;       Command_0E_EXECUTE_LIST_WHILE_FAIL size=146
L2F18:         0D 2F                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=47
L2F1A:           14                                              ;           Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L2F1B:             01 1D                                         ;             Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=1D(USER)
L2F1D:           0B 29                                           ;           Command_0B_SWITCH size=29
L2F1F:             03 9C 23                                      ;             Command_03_IS_OBJECT_AT_LOCATION object=23(Guards) location=9C
L2F22:             07                                            ;             IF_NOT_JUMP address=2F2A
L2F23:               0D 05                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=5
L2F25:                 00 9D                                     ;                 Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9D
L2F27:                 01 1D                                     ;                 Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=1D(USER)
L2F29:                 86                                        ;                 CommonCommand_86
L2F2A:             9F 23                                         ;             Command_03_IS_OBJECT_AT_LOCATION object=23(Guards) location=9F
L2F2C:             07                                            ;             IF_NOT_JUMP address=2F34
L2F2D:               0D 05                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=5
L2F2F:                 00 9C                                     ;                 Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9C
L2F31:                 01 1D                                     ;                 Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=1D(USER)
L2F33:                 86                                        ;                 CommonCommand_86
L2F34:             9E 23                                         ;             Command_03_IS_OBJECT_AT_LOCATION object=23(Guards) location=9E
L2F36:             07                                            ;             IF_NOT_JUMP address=2F3E
L2F37:               0D 05                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=5
L2F39:                 00 9F                                     ;                 Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9F
L2F3B:                 01 1D                                     ;                 Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=1D(USER)
L2F3D:                 86                                        ;                 CommonCommand_86
L2F3E:             9D 23                                         ;             Command_03_IS_OBJECT_AT_LOCATION object=23(Guards) location=9D
L2F40:             07                                            ;             IF_NOT_JUMP address=2F48
L2F41:               0D 05                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=5
L2F43:                 00 9E                                     ;                 Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9E
L2F45:                 01 1D                                     ;                 Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=1D(USER)
L2F47:                 86                                        ;                 CommonCommand_86
L2F48:           0C                                              ;           Command_0C_FAIL
L2F49:         0D 5F                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=95
L2F4B:           01 1D                                           ;           Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=1D(USER)
L2F4D:           1C 1D                                           ;           Command_1C_SET_VAR_OBJECT object=1D (USER)
L2F4F:           1F                                              ;           Command_1F_PRINT_MESSAGE
L2F50:             58 A6 1D 51 A0 D0 15 06 67 33 61 79           ;             "STOP! INFIDEL DOG!", THE GUARDS LEVEL THEIR
L2F5C:             5B 06 07 82 17 49 5E 94 C3 0B 5C F8           ;             CROSSBOWS AND LOOSE THEIR BOLTS! YOUR BODY
L2F68:             8B 33 61 5F BE 23 7B B9 55 D4 B9 85           ;             FALLS TO THE GROUND RIDDLED WITH THE SHAFTS!
L2F74:             A1 90 14 0E 58 45 A0 56 5E EB 72 84           ;             .
L2F80:             AF CE 9F 6B B5 C7 DE 84 AF 93 9E 4B           ;             .
L2F8C:             15 0D 8D 89 17 82 17 49 5E 07 B3 33           ;             .
L2F98:             98 06 B2 FF 5A 19 58 82 7B 82 17 55           ;             .
L2FA4:             5E 48 72 09 C0                                ;             .
L2FA9:           81                                              ;           CommonCommand_81
L2FAA:     02                                                    ;     02 SHORT NAME
L2FAB:       04 23 6F 4D B1                                      ;       GUARDS
; Object_24 Object24
L2FB0:   29 4C                                                   ;   Number=29 size=004C
L2FB2:     1D 00 00                                              ;     room=1D scorePoints=00 bits=00 *       
L2FB5:     08 47                                                 ;     08 TURN SCRIPT
L2FB7:       0B 45                                               ;       Command_0B_SWITCH size=45
L2FB9:         03 9C 23                                          ;         Command_03_IS_OBJECT_AT_LOCATION object=23(Guards) location=9C
L2FBC:         0E                                                ;         IF_NOT_JUMP address=2FCB
L2FBD:           0E 0C                                           ;           Command_0E_EXECUTE_LIST_WHILE_FAIL size=12
L2FBF:             0D 04                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=4
L2FC1:               03 9A 1D                                    ;               Command_03_IS_OBJECT_AT_LOCATION object=1D(USER) location=9A
L2FC4:               85                                          ;               CommonCommand_85
L2FC5:             0D 04                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=4
L2FC7:               03 99 1D                                    ;               Command_03_IS_OBJECT_AT_LOCATION object=1D(USER) location=99
L2FCA:               87                                          ;               CommonCommand_87
L2FCB:         9F 23                                             ;         Command_03_IS_OBJECT_AT_LOCATION object=23(Guards) location=9F
L2FCD:         0E                                                ;         IF_NOT_JUMP address=2FDC
L2FCE:           0E 0C                                           ;           Command_0E_EXECUTE_LIST_WHILE_FAIL size=12
L2FD0:             0D 04                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=4
L2FD2:               03 99 1D                                    ;               Command_03_IS_OBJECT_AT_LOCATION object=1D(USER) location=99
L2FD5:               85                                          ;               CommonCommand_85
L2FD6:             0D 04                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=4
L2FD8:               03 98 1D                                    ;               Command_03_IS_OBJECT_AT_LOCATION object=1D(USER) location=98
L2FDB:               87                                          ;               CommonCommand_87
L2FDC:         9E 23                                             ;         Command_03_IS_OBJECT_AT_LOCATION object=23(Guards) location=9E
L2FDE:         0E                                                ;         IF_NOT_JUMP address=2FED
L2FDF:           0E 0C                                           ;           Command_0E_EXECUTE_LIST_WHILE_FAIL size=12
L2FE1:             0D 04                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=4
L2FE3:               03 98 1D                                    ;               Command_03_IS_OBJECT_AT_LOCATION object=1D(USER) location=98
L2FE6:               85                                          ;               CommonCommand_85
L2FE7:             0D 04                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=4
L2FE9:               03 9B 1D                                    ;               Command_03_IS_OBJECT_AT_LOCATION object=1D(USER) location=9B
L2FEC:               87                                          ;               CommonCommand_87
L2FED:         9D 23                                             ;         Command_03_IS_OBJECT_AT_LOCATION object=23(Guards) location=9D
L2FEF:         0E                                                ;         IF_NOT_JUMP address=2FFE
L2FF0:           0E 0C                                           ;           Command_0E_EXECUTE_LIST_WHILE_FAIL size=12
L2FF2:             0D 04                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=4
L2FF4:               03 9B 1D                                    ;               Command_03_IS_OBJECT_AT_LOCATION object=1D(USER) location=9B
L2FF7:               85                                          ;               CommonCommand_85
L2FF8:             0D 04                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=4
L2FFA:               03 9A 1D                                    ;               Command_03_IS_OBJECT_AT_LOCATION object=1D(USER) location=9A
L2FFD:               87                                          ;               CommonCommand_87
; Object_25 GemA
L2FFE:   13 30                                                   ;   Number=13 size=0030
L3000:     9C 00 A0                                              ;     room=9C scorePoints=00 bits=A0 u.C.....
L3003:     02                                                    ;     02 SHORT NAME
L3004:       08 EF A6 51 54 4B C6 AF 6C                          ;       PRECIOUS GEM
L300D:     08 21                                                 ;     08 TURN SCRIPT
L300F:       0D 1F                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=31
L3011:         03 9C 25                                          ;         Command_03_IS_OBJECT_AT_LOCATION object=25(GemA) location=9C
L3014:         0B 1A                                             ;         Command_0B_SWITCH size=1A
L3016:           05 33                                           ;           Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=33
L3018:           03                                              ;           IF_NOT_JUMP address=301C
L3019:             17 25 89                                      ;             Command_17_MOVE_OBJECT_TO_LOCATION object=25(GemA) location=89
L301C:           66                                              ;           Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=66
L301D:           03                                              ;           IF_NOT_JUMP address=3021
L301E:             17 25 94                                      ;             Command_17_MOVE_OBJECT_TO_LOCATION object=25(GemA) location=94
L3021:           99                                              ;           Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=99
L3022:           03                                              ;           IF_NOT_JUMP address=3026
L3023:             17 25 86                                      ;             Command_17_MOVE_OBJECT_TO_LOCATION object=25(GemA) location=86
L3026:           CC                                              ;           Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=CC
L3027:           03                                              ;           IF_NOT_JUMP address=302B
L3028:             17 25 8E                                      ;             Command_17_MOVE_OBJECT_TO_LOCATION object=25(GemA) location=8E
L302B:           FF                                              ;           Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=FF
L302C:           03                                              ;           IF_NOT_JUMP address=3030
L302D:             17 25 83                                      ;             Command_17_MOVE_OBJECT_TO_LOCATION object=25(GemA) location=83
; Object_26 GemB
L3030:   13 23                                                   ;   Number=13 size=0023
L3032:     00 05 A0                                              ;     room=00 scorePoints=05 bits=A0 u.C.....
L3035:     02                                                    ;     02 SHORT NAME
L3036:       08 EF A6 51 54 4B C6 AF 6C                          ;       PRECIOUS GEM
L303F:     03                                                    ;     03 DESCRIPTION
L3040:       14 5F BE 5B B1 4B 7B 52 45 65 B1 C7                 ;       THERE IS A PRECIOUS GEM HERE. 
L304C:       7A C9 B5 5B 61 F4 72 DB 63                          ;       .
; Object_27 HiddenGem
L3055:   2A 32                                                   ;   Number=2A size=0032
L3057:     FF 00 00                                              ;     room=FF scorePoints=00 bits=00 *       
L305A:     02                                                    ;     02 SHORT NAME
L305B:       03 01 B3 4D                                         ;       ROOM
L305F:     07 28                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L3061:       0D 26                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=38
L3063:         0A 0B                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=0B phrase="0B: LOOK AT     *          u......."
L3065:         01 25                                             ;         Command_01_IS_OBJECT_IN_PACK_OR_ROOM object=25(GemA)
L3067:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3068:           20 C7 DE 03 15 61 B7 74 CA 7B 14 EF             ;           YOU DISCOVER A PRECIOUS GEM HIDDEN IN A
L3074:           A6 51 54 4B C6 AF 6C A3 15 BF 59 8B             ;           CREVICE.
L3080:           96 83 96 E4 14 D3 62 BF 53                      ;           .
; Object_28 UnlitLamp
L3089:   1B 62                                                   ;   Number=1B size=0062
L308B:     00 00 AC                                              ;     room=00 scorePoints=00 bits=AC u.C.AX..
L308E:     02                                                    ;     02 SHORT NAME
L308F:       03 4F 8B 50                                         ;       LAMP
L3093:     03                                                    ;     03 DESCRIPTION
L3094:       0E 5F BE 5B B1 4B 7B 4E 45 72 48 9F                 ;       THERE IS A LAMP HERE.
L30A0:       15 7F B1                                            ;       .
L30A3:     07 48                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L30A5:       0B 46                                               ;       Command_0B_SWITCH size=46
L30A7:         0A 14                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=14 phrase="14: LIGHT WITH  u...A...   u...A..."
L30A9:         1C                                                ;         IF_NOT_JUMP address=30C6
L30AA:           0E 1A                                           ;           Command_0E_EXECUTE_LIST_WHILE_FAIL size=26
L30AC:             0D 17                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=23
L30AE:               09 12                                       ;               Command_09_COMPARE_OBJECT_TO_SECOND_NOUN object=12(LitCandle
L30B0:               1E 28 14                                    ;               Command_1E_SWAP_OBJECTS objectA=28(UnlitLamp) objectB=14(LitLamp)
L30B3:               04                                          ;               Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L30B4:                 10 5F BE 3B 16 D3 93 4B 7B 09 9A BF       ;                 THE LAMP IS NOW BURNING.
L30C0:                 14 D3 B2 CF 98                            ;                 .
L30C5:             88                                            ;             CommonCommand_88
L30C6:         18                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=18 phrase="18: RUB *       u.......   *       "
L30C7:         19                                                ;         IF_NOT_JUMP address=30E1
L30C8:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L30C9:             17 29 D1 09 15 51 18 56 C2 90 73 DB           ;             WHO DO YOU THINK YOU ARE, ALADDIN?
L30D5:             83 1B A1 2F 49 03 EE 46 8B 90 5A 3F           ;             .
L30E1:         08                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=08 phrase="08: READ *      .....X..   *       "
L30E2:         0A                                                ;         IF_NOT_JUMP address=30ED
L30E3:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L30E4:             08 49 1B 99 16 14 BC A4 C3                    ;             "DO NOT RUB"
; Object_29 Floor
L30ED:   2B 09                                                   ;   Number=2B size=0009
L30EF:     00 00 80                                              ;     room=00 scorePoints=00 bits=80 u.......
L30F2:     02                                                    ;     02 SHORT NAME
L30F3:       04 89 67 A3 A0                                      ;       FLOOR 
; Object_2A Exit
L30F8:   2C 0B                                                   ;   Number=2C size=000B
L30FA:     00 00 80                                              ;     room=00 scorePoints=00 bits=80 u.......
L30FD:     07 01                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L30FF:       93                                                  ;       CommonCommand_93
L3100:     02                                                    ;     02 SHORT NAME
L3101:       03 23 63 54                                         ;       EXIT
; Object_2B Passage
L3105:   2D 0D                                                   ;   Number=2D size=000D
L3107:     00 00 80                                              ;     room=00 scorePoints=00 bits=80 u.......
L310A:     07 01                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L310C:       93                                                  ;       CommonCommand_93
L310D:     02                                                    ;     02 SHORT NAME
L310E:       05 55 A4 09 B7 45                                   ;       PASSAGE
; Object_2C Hole
L3114:   2E 0B                                                   ;   Number=2E size=000B
L3116:     00 00 80                                              ;     room=00 scorePoints=00 bits=80 u.......
L3119:     07 01                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L311B:       93                                                  ;       CommonCommand_93
L311C:     02                                                    ;     02 SHORT NAME
L311D:       03 7E 74 45                                         ;       HOLE
; Object_2D Corridor
L3121:   2F 0E                                                   ;   Number=2F size=000E
L3123:     00 00 80                                              ;     room=00 scorePoints=00 bits=80 u.......
L3126:     07 01                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L3128:       93                                                  ;       CommonCommand_93
L3129:     02                                                    ;     02 SHORT NAME
L312A:       06 44 55 06 B2 A3 A0                                ;       CORRIDOR 
; Object_2E Corner
L3131:   30 09                                                   ;   Number=30 size=0009
L3133:     00 00 80                                              ;     room=00 scorePoints=00 bits=80 u.......
L3136:     02                                                    ;     02 SHORT NAME
L3137:       04 44 55 74 98                                      ;       CORNER
; Object_2F Bow
L313C:   31 07                                                   ;   Number=31 size=0007
L313E:     88 00 80                                              ;     room=88 scorePoints=00 bits=80 u.......
L3141:     02                                                    ;     02 SHORT NAME
L3142:       02 09 4F                                            ;       BOW
; Object_30 Arrow
L3145:   32 09                                                   ;   Number=32 size=0009
L3147:     88 00 80                                              ;     room=88 scorePoints=00 bits=80 u.......
L314A:     02                                                    ;     02 SHORT NAME
L314B:       04 3C 49 6B A1                                      ;       ARROW 
; Object_31 Hallway
L3150:   33 0D                                                   ;   Number=33 size=000D
L3152:     00 00 80                                              ;     room=00 scorePoints=00 bits=80 u.......
L3155:     07 01                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L3157:       93                                                  ;       CommonCommand_93
L3158:     02                                                    ;     02 SHORT NAME
L3159:       05 4E 72 B3 8E 59                                   ;       HALLWAY
; Object_32 Chamber
L315F:   34 0A                                                   ;   Number=34 size=000A
L3161:     8D 00 80                                              ;     room=8D scorePoints=00 bits=80 u.......
L3164:     02                                                    ;     02 SHORT NAME
L3165:       05 1B 54 AF 91 52                                   ;       CHAMBER
; Object_33 Vault
L316B:   35 09                                                   ;   Number=35 size=0009
L316D:     91 00 80                                              ;     room=91 scorePoints=00 bits=80 u.......
L3170:     02                                                    ;     02 SHORT NAME
L3171:       04 D7 C9 33 8E                                      ;       VAULT 
; Object_34 Entrance
L3176:   36 0E                                                   ;   Number=36 size=000E
L3178:     00 00 80                                              ;     room=00 scorePoints=00 bits=80 u.......
L317B:     07 01                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L317D:       93                                                  ;       CommonCommand_93
L317E:     02                                                    ;     02 SHORT NAME
L317F:       06 9E 61 D0 B0 9B 53                                ;       ENTRANCE 
; Object_35 Tunnel
L3186:   37 0C                                                   ;   Number=37 size=000C
L3188:     00 00 80                                              ;     room=00 scorePoints=00 bits=80 u.......
L318B:     07 01                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L318D:       93                                                  ;       CommonCommand_93
L318E:     02                                                    ;     02 SHORT NAME
L318F:       04 70 C0 6E 98                                      ;       TUNNEL
; Object_36 Jungle
L3194:   38 0C                                                   ;   Number=38 size=000C
L3196:     FF 00 80                                              ;     room=FF scorePoints=00 bits=80 u.......
L3199:     07 01                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L319B:       93                                                  ;       CommonCommand_93
L319C:     02                                                    ;     02 SHORT NAME
L319D:       04 F0 81 BF 6D                                      ;       JUNGLE
; Object_37 Temple
L31A2:   39 0C                                                   ;   Number=39 size=000C
L31A4:     FF 00 80                                              ;     room=FF scorePoints=00 bits=80 u.......
L31A7:     07 01                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L31A9:       93                                                  ;       CommonCommand_93
L31AA:     02                                                    ;     02 SHORT NAME
L31AB:       04 EF BD FF A5                                      ;       TEMPLE
; Object_38 Serpents
L31B0:   24 0B                                                   ;   Number=24 size=000B
L31B2:     9C 00 80                                              ;     room=9C scorePoints=00 bits=80 u.......
L31B5:     02                                                    ;     02 SHORT NAME
L31B6:       06 B4 B7 F0 A4 0B C0                                ;       SERPENTS 
; Object_39 Pit
L31BD:   3A 31                                                   ;   Number=3A size=0031
L31BF:     82 00 80                                              ;     room=82 scorePoints=00 bits=80 u.......
L31C2:     07 28                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L31C4:       0B 26                                               ;       Command_0B_SWITCH size=26
L31C6:         0A 36                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=36 phrase="36: CLIMB IN    *          *       "
L31C8:         01                                                ;         IF_NOT_JUMP address=31CA
L31C9:           8A                                              ;           CommonCommand_8A
L31CA:         33                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=33 phrase="??"
L31CB:         01                                                ;         IF_NOT_JUMP address=31CD
L31CC:           8A                                              ;           CommonCommand_8A
L31CD:         34                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=34 phrase="34: JUMP OVER   *          u......."
L31CE:         01                                                ;         IF_NOT_JUMP address=31D0
L31CF:           8A                                              ;           CommonCommand_8A
L31D0:         26                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=26 phrase="26: GO AROUND   *          u......."
L31D1:         17                                                ;         IF_NOT_JUMP address=31E9
L31D2:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L31D3:             15 5F BE 5B B1 4B 7B EB 99 1B D0 94           ;             THERE IS NO WAY AROUND THE PIT.
L31DF:             14 30 A1 16 58 DB 72 96 A5 2E                 ;             .
L31E9:         17                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=17 phrase="17: CLIMB *     u.......   *       "
L31EA:         01                                                ;         IF_NOT_JUMP address=31EC
L31EB:           8A                                              ;           CommonCommand_8A
L31EC:     02                                                    ;     02 SHORT NAME
L31ED:       02 96 A5                                            ;       PIT
; Object_3A Ceiling
L31F0:   3B 0A                                                   ;   Number=3B size=000A
L31F2:     00 00 80                                              ;     room=00 scorePoints=00 bits=80 u.......
L31F5:     02                                                    ;     02 SHORT NAME
L31F6:       05 AB 53 90 8C 47                                   ;       CEILING
; Object_3B AlterB
L31FC:   22 39                                                   ;   Number=22 size=0039
L31FE:     A5 00 80                                              ;     room=A5 scorePoints=00 bits=80 u.......
L3201:     02                                                    ;     02 SHORT NAME
L3202:       04 4E 48 23 62                                      ;       ALTER 
L3207:     07 2E                                                 ;     07 COMMAND HANDLING IF FIRST NOUN
L3209:       0D 2C                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=44
L320B:         0A 12                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=12 phrase="12: PULL *      u.......   *       "
L320D:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L320E:           28 C7 DE D3 14 90 96 F3 A0 C8 93 56             ;           YOU CAN NOT MOVE THE ALTER FROM BENEATH IT,
L321A:           5E DB 72 4E 48 23 62 79 68 44 90 8F             ;           IT IS TOO HEAVY.
L3226:           61 82 49 D6 15 0B EE 0B BC D6 B5 2B             ;           .
L3232:           A0 E3 72 9F CD                                  ;           .
; Object_3C Object3C
L3237:   3C 03                                                   ;   Number=3C size=0003
L3239:     1D 00 80                                              ;     room=1D scorePoints=00 bits=80 u.......
; ENDOF 20FF


;##GeneralCommands
L323C:   00 85 BB 0E 85 B8                                       ;   Command_0E_EXECUTE_LIST_WHILE_FAIL size=1464
L3242:     0D 2C                                                 ;     Command_0D_EXECUTE_LIST_WHILE_PASS size=44
L3244:       0E 08                                               ;       Command_0E_EXECUTE_LIST_WHILE_FAIL size=8
L3246:         0A 01                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=01 phrase="01: NORTH *     *          *       "
L3248:         0A 02                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=02 phrase="02: SOUTH *     *          *       "
L324A:         0A 03                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=03 phrase="03: EAST *      *          *       "
L324C:         0A 04                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=04 phrase="04: WEST *      *          *       "
L324E:       0E 20                                               ;       Command_0E_EXECUTE_LIST_WHILE_FAIL size=32
L3250:         13                                                ;         Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L3251:         0D 1D                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=29
L3253:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3254:             19 5F BE 5B B1 4B 7B EB 99 1B D0 89           ;             THERE IS NO WAY TO GO THAT DIRECTION.
L3260:             17 81 15 82 17 73 49 94 5A E6 5F C0           ;             .
L326C:             7A 2E                                         ;             .
L326E:           20 1D                                           ;           Command_20_CHECK_ACTIVE_OBJECT object=1D(USER)
L3270:     0B 85 83                                              ;     Command_0B_SWITCH size=583
L3273:       0A 05                                               ;       Command_0A_COMPARE_TO_PHRASE_FORM val=05 phrase="05: GET *       ..C.....   *       "
L3275:       21                                                  ;       IF_NOT_JUMP address=3297
L3276:         0E 1F                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=31
L3278:           0D 19                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=25
L327A:             1A                                            ;             Command_1A_SET_VAR_OBJECT_TO_FIRST_NOUN
L327B:             18                                            ;             Command_18_CHECK_VAR_OBJECT_OWNED_BY_ACTIVE_OBJECT
L327C:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L327D:               13 C7 DE 94 14 43 5E EF 8D 13 47 D3         ;               YOU ARE ALREADY CARRYING THE
L3289:               14 83 B3 91 7A 82 17 45                     ;               .
L3291:             16                                            ;             Command_16_PRINT_VAR_NOUN_SHORT_NAME
L3292:             84                                            ;             CommonCommand_84
L3293:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L3294:           83                                              ;           CommonCommand_83
L3295:           14                                              ;           Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L3296:             0C                                            ;             Command_0C_FAIL
L3297:       06                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=06 phrase="06: DROP *      ..C.....   *       "
L3298:       0C                                                  ;       IF_NOT_JUMP address=32A5
L3299:         0D 0A                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=10
L329B:           1A                                              ;           Command_1A_SET_VAR_OBJECT_TO_FIRST_NOUN
L329C:           10                                              ;           Command_10_DROP_OBJECT
L329D:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L329E:             06 F9 5B 9F A6 9B 5D                          ;             DROPPED. 
L32A5:       08                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=08 phrase="08: READ *      .....X..   *       "
L32A6:       17                                                  ;       IF_NOT_JUMP address=32BE
L32A7:         0E 15                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=21
L32A9:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L32AA:           0D 12                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=18
L32AC:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L32AD:               0E 89 74 D3 14 9B 96 1B A1 63 B1 16         ;               HOW CAN YOU READ THE 
L32B9:               58 DB 72                                    ;               .
L32BC:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L32BD:             84                                            ;             CommonCommand_84
L32BE:       11                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=11 phrase="11: OPEN *      u.......   *       "
L32BF:       16                                                  ;       IF_NOT_JUMP address=32D6
L32C0:         0E 14                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=20
L32C2:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L32C3:           0D 11                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=17
L32C5:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L32C6:               0D EB 99 0F A0 D3 14 91 96 F0 A4 82         ;               NO ONE CAN OPEN THE
L32D2:               17 45                                       ;               .
L32D4:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L32D5:             84                                            ;             CommonCommand_84
L32D6:       12                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=12 phrase="12: PULL *      u.......   *       "
L32D7:       21                                                  ;       IF_NOT_JUMP address=32F9
L32D8:         0E 1F                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=31
L32DA:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L32DB:           0D 1C                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=28
L32DD:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L32DE:               13 33 D1 09 15 E6 96 51 18 4E C2 98         ;               WHY DON'T YOU LEAVE THE POOR
L32EA:               5F 56 5E DB 72 81 A6 52                     ;               .
L32F2:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L32F3:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L32F4:               04 49 48 7F 98                              ;               ALONE.
L32F9:       09                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=09 phrase="09: ATTACK WITH ...P....   .v......"
L32FA:       81 37                                               ;       IF_NOT_JUMP address=3433
L32FC:         0E 81 34                                          ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=308
L32FF:           14                                              ;           Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L3300:             1B                                            ;             Command_1B_SET_VAR_OBJECT_TO_SECOND_NOUN
L3301:           14                                              ;           Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L3302:             0E 03                                         ;             Command_0E_EXECUTE_LIST_WHILE_FAIL size=3
L3304:               09 17                                       ;               Command_09_COMPARE_OBJECT_TO_SECOND_NOUN object=17(Hands
L3306:               83                                          ;               CommonCommand_83
L3307:           0E 81 29                                        ;           Command_0E_EXECUTE_LIST_WHILE_FAIL size=297
L330A:             0D 1F                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=31
L330C:               14                                          ;               Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L330D:                 15 40                                     ;                 Command_15_CHECK_OBJECT_BITS bits=40 .v......
L330F:               14                                          ;               Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L3310:                 09 17                                     ;                 Command_09_COMPARE_OBJECT_TO_SECOND_NOUN object=17(Hands
L3312:               04                                          ;               Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3313:                 0C C7 DE D3 14 E6 96 AF 15 B3 B3 5F       ;                 YOU CAN'T HURT THE
L331F:                 BE                                        ;                 .
L3320:               11                                          ;               Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L3321:               04                                          ;               Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3322:                 06 56 D1 16 71 DB 72                      ;                 WITH THE 
L3329:               12                                          ;               Command_12_PRINT_SECOND_NOUN_SHORT_NAME
L332A:               84                                          ;               CommonCommand_84
L332B:             13                                            ;             Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L332C:             0D 1A                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=26
L332E:               1A                                          ;               Command_1A_SET_VAR_OBJECT_TO_FIRST_NOUN
L332F:               14                                          ;               Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L3330:                 15 10                                     ;                 Command_15_CHECK_OBJECT_BITS bits=10 ...P....
L3332:               04                                          ;               Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3333:                 12 73 7B 77 5B D0 B5 C9 9C 36 A0 89       ;                 IT DOES NO GOOD TO ATTACK A
L333F:                 17 96 14 45 BD C3 83                      ;                 .
L3346:               11                                          ;               Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L3347:               84                                          ;               CommonCommand_84
L3348:             0D 80 D7                                      ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=215
L334B:               1A                                          ;               Command_1A_SET_VAR_OBJECT_TO_FIRST_NOUN
L334C:               0B 80 D3                                    ;               Command_0B_SWITCH size=D3
L334F:                 09 09                                     ;                 Command_09_COMPARE_OBJECT_TO_SECOND_NOUN object=09(Sword
L3351:                 80 99                                     ;                 IF_NOT_JUMP address=33EC
L3353:                   0B 80 96                                ;                   Command_0B_SWITCH size=96
L3356:                     05 52                                 ;                     Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=52
L3358:                     28                                    ;                     IF_NOT_JUMP address=3381
L3359:                       0D 26                               ;                       Command_0D_EXECUTE_LIST_WHILE_PASS size=38
L335B:                         04                                ;                         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L335C:                           17 4F 45 7A 79 FB C0 6C BE 66 C6 04;                           A MIGHTY THRUST, BUT IT MISSES THE
L3368:                           EE 73 C6 73 7B D5 92 B5 B7 82 17 45;                           .
L3374:                         16                                ;                         Command_16_PRINT_VAR_NOUN_SHORT_NAME
L3375:                         04                                ;                         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3376:                           0A 7B 50 4D 45 49 7A 36 92 21 62;                           BY A KILOMETER!
L3381:                     A4                                    ;                     Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=A4
L3382:                     2D                                    ;                     IF_NOT_JUMP address=33B0
L3383:                       0D 2B                               ;                       Command_0D_EXECUTE_LIST_WHILE_PASS size=43
L3385:                         04                                ;                         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3386:                           1C 89 4E 73 9E F5 B3 F5 72 59 15 C2;                           BLOOD RUSHES FORTH AS YOU HAVE SLASHED THE
L3392:                           B3 95 14 51 18 4A C2 CF 49 5E 17 5A;                           .
L339E:                           49 F3 5F 5F BE                  ;                           .
L33A3:                         16                                ;                         Command_16_PRINT_VAR_NOUN_SHORT_NAME
L33A4:                         04                                ;                         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L33A5:                           08 83 7A 5F BE 94 14 EB 8F      ;                           IN THE ARM! 
L33AE:                         1D 0A                             ;                         Command_1D_ATTACK_OBJECT damage=0A
L33B0:                     FD                                    ;                     Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=FD
L33B1:                     20                                    ;                     IF_NOT_JUMP address=33D2
L33B2:                       0D 1E                               ;                       Command_0D_EXECUTE_LIST_WHILE_PASS size=30
L33B4:                         04                                ;                         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L33B5:                           1A C7 DE 63 16 C9 97 43 5E 84 15 73;                           YOU MANAGE A GRAZING BLOW TO THE CHEST!
L33C1:                           4A AB 98 89 4E D6 CE D6 9C DB 72 1F;                           .
L33CD:                           54 F1 B9                        ;                           .
L33D0:                         1D 14                             ;                         Command_1D_ATTACK_OBJECT damage=14
L33D2:                     FF                                    ;                     Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=FF
L33D3:                     18                                    ;                     IF_NOT_JUMP address=33EC
L33D4:                       0D 16                               ;                       Command_0D_EXECUTE_LIST_WHILE_PASS size=22
L33D6:                         04                                ;                         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L33D7:                           12 4E 45 DD C3 44 DB 89 8D 89 17 82;                           A LUCKY BLOW TO THE HEART! 
L33E3:                           17 4A 5E 94 5F AB BB            ;                           .
L33EA:                         1D FF                             ;                         Command_1D_ATTACK_OBJECT damage=FF
L33EC:                 17                                        ;                 Command_09_COMPARE_OBJECT_TO_SECOND_NOUN object=17(Hands
L33ED:                 34                                        ;                 IF_NOT_JUMP address=3422
L33EE:                   0B 32                                   ;                   Command_0B_SWITCH size=32
L33F0:                     05 AF                                 ;                     Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=AF
L33F2:                     14                                    ;                     IF_NOT_JUMP address=3407
L33F3:                       04                                  ;                       Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L33F4:                         12 59 45 3E 7A EF 16 1A 98 90 14 1B;                         A WILD PUNCH AND YOU MISS. 
L3400:                         58 1B A1 D5 92 5B BB              ;                         .
L3407:                     FF                                    ;                     Command_05_IS_LAST_RANDOM_LESS_THAN_OR_EQUAL value=FF
L3408:                     19                                    ;                     IF_NOT_JUMP address=3422
L3409:                       0D 17                               ;                       Command_0D_EXECUTE_LIST_WHILE_PASS size=23
L340B:                         04                                ;                         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L340C:                           13 C7 DE EF 16 1A 98 F3 5F 8F 73 D0;                           YOU PUNCHED HIM IN THE HEAD!
L3418:                           15 82 17 4A 5E 86 5F 21         ;                           .
L3420:                         1D 03                             ;                         Command_1D_ATTACK_OBJECT damage=03
L3422:             0D 0F                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=15
L3424:               04                                          ;               Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3425:                 02 5F BE                                  ;                 THE
L3428:               11                                          ;               Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L3429:               04                                          ;               Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L342A:                 08 4B 7B 92 C5 37 49 17 60                ;                 IS UNHARMED.
L3433:       0A                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=0A phrase="0A: LOOK *      *          *       "
L3434:       01                                                  ;       IF_NOT_JUMP address=3436
L3435:         07                                                ;         Command_07_PRINT_ROOM_DESCRIPTION
L3436:       15                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=15 phrase="15: EAT *       u.......   *       "
L3437:       29                                                  ;       IF_NOT_JUMP address=3461
L3438:         0E 27                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=39
L343A:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L343B:           0D 24                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=36
L343D:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L343E:               0D 80 5B F3 23 5B 4D 4E B8 F9 8E 82         ;               DON'T BE SILLY! THE
L344A:               17 45                                       ;               .
L344C:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L344D:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L344E:               12 47 D2 C8 8B F3 23 55 BD DB BD 41         ;               WOULDN'T TASTE GOOD ANYWAY.
L345A:               6E 03 58 99 9B 5F 4A                        ;               .
L3461:       17                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=17 phrase="17: CLIMB *     u.......   *       "
L3462:       51                                                  ;       IF_NOT_JUMP address=34B4
L3463:         0E 4F                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=79
L3465:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L3466:           0D 25                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=37
L3468:             1A                                            ;             Command_1A_SET_VAR_OBJECT_TO_FIRST_NOUN
L3469:             15 10                                         ;             Command_15_CHECK_OBJECT_BITS bits=10 ...P....
L346B:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L346C:               0C 46 77 05 A0 16 BC 90 73 D6 83 DB         ;               I DON'T THINK THE 
L3478:               72                                          ;               .
L3479:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L347A:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L347B:               11 4E D1 15 8A 50 BD 15 58 8E BE 08         ;               WILL STAND STILL FORTHAT.
L3487:               8A BE A0 56 72 2E                           ;               .
L348D:           0D 25                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=37
L348F:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3490:               12 CF 62 8B 96 9B 64 1B A1 47 55 B3         ;               EVEN IF YOU COULD CLIMB THE
L349C:               8B C3 54 A3 91 5F BE                        ;               .
L34A3:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L34A4:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L34A5:               0E 73 7B 47 D2 C8 8B F3 23 EE 72 1B         ;               IT WOULDN'T HELP YOU.
L34B1:               A3 3F A1                                    ;               .
L34B4:       16                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=16 phrase="16: DROP OUT    *          u...A..."
L34B5:       16                                                  ;       IF_NOT_JUMP address=34CC
L34B6:         0E 14                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=20
L34B8:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L34B9:           0D 11                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=17
L34BB:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L34BC:               02 5F BE                                    ;               THE
L34BF:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L34C0:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L34C1:               0A 4B 7B 06 9A BF 14 D3 B2 CF 98            ;               IS NOT BURNING.
L34CC:       18                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=18 phrase="18: RUB *       u.......   *       "
L34CD:       35                                                  ;       IF_NOT_JUMP address=3503
L34CE:         0E 33                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=51
L34D0:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L34D1:           0D 18                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=24
L34D3:             1A                                            ;             Command_1A_SET_VAR_OBJECT_TO_FIRST_NOUN
L34D4:             15 10                                         ;             Command_15_CHECK_OBJECT_BITS bits=10 ...P....
L34D6:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L34D7:               11 5B BE 65 BC 99 16 F3 17 56 DB CA         ;               THAT'S NO WAY TO HURT THE
L34E3:               9C 3E C6 82 17 45                           ;               .
L34E9:             16                                            ;             Command_16_PRINT_VAR_NOUN_SHORT_NAME
L34EA:             84                                            ;             CommonCommand_84
L34EB:           0D 16                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=22
L34ED:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L34EE:               02 5F BE                                    ;               THE
L34F1:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L34F2:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L34F3:               0F 81 8D CB 87 A5 94 04 71 8E 62 23         ;               LOOKS MUCH BETTER NOW.
L34FF:               62 09 9A 2E                                 ;               .
L3503:       0B                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=0B phrase="0B: LOOK AT     *          u......."
L3504:       3A                                                  ;       IF_NOT_JUMP address=353F
L3505:         0E 38                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=56
L3507:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L3508:           0D 19                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=25
L350A:             1A                                            ;             Command_1A_SET_VAR_OBJECT_TO_FIRST_NOUN
L350B:             15 04                                         ;             Command_15_CHECK_OBJECT_BITS bits=04 .....X..
L350D:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L350E:               12 3F B9 82 62 91 7A D5 15 04 18 8E         ;               SOMETHING IS WRITTEN ON THE
L351A:               7B 83 61 03 A0 5F BE                        ;               .
L3521:             16                                            ;             Command_16_PRINT_VAR_NOUN_SHORT_NAME
L3522:             84                                            ;             CommonCommand_84
L3523:           0D 1A                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=26
L3525:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3526:               16 5F BE 5D B1 D0 B5 02 A1 91 7A 62         ;               THERE'S NOTHING SPECIAL ABOUT THE
L3532:               17 DB 5F 33 48 B9 46 73 C6 5F BE            ;               .
L353D:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L353E:             84                                            ;             CommonCommand_84
L353F:       0C                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=0C phrase="0C: LOOK UNDER  *          u......."
L3540:       1A                                                  ;       IF_NOT_JUMP address=355B
L3541:         0E 18                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=24
L3543:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L3544:           0D 15                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=21
L3546:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3547:               11 5F BE 5D B1 D0 B5 02 A1 91 7A B0         ;               THERE'S NOTHING UNDER THE
L3553:               17 F4 59 82 17 45                           ;               .
L3559:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L355A:             84                                            ;             CommonCommand_84
L355B:       10                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=10 phrase="10: LOOK IN     *          u......."
L355C:       18                                                  ;       IF_NOT_JUMP address=3575
L355D:         0E 16                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=22
L355F:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L3560:           0D 13                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=19
L3562:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3563:               0F 5F BE 5D B1 D0 B5 02 A1 91 7A D0         ;               THERE'S NOTHING IN THE
L356F:               15 82 17 45                                 ;               .
L3573:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L3574:             84                                            ;             CommonCommand_84
L3575:       1B                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=1B phrase="1B: LOOK AROUND *          u......."
L3576:       20                                                  ;       IF_NOT_JUMP address=3597
L3577:         0E 1E                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=30
L3579:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L357A:           0D 03                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=3
L357C:             08 00                                         ;             Command_08_COMPARE_OBJECT_TO_FIRST_NOUN object=00(NONE
L357E:             07                                            ;             Command_07_PRINT_ROOM_DESCRIPTION
L357F:           0D 16                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=22
L3581:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3582:               12 5F BE 5B B1 4B 7B 06 9A 90 73 C3         ;               THERE IS NOTHING AROUND THE
L358E:               6A 07 B3 33 98 5F BE                        ;               .
L3595:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L3596:             84                                            ;             CommonCommand_84
L3597:       1C                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=1C phrase="1C: LOOK BEHIND *          u......."
L3598:       34                                                  ;       IF_NOT_JUMP address=35CD
L3599:         0E 32                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=50
L359B:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L359C:           0D 17                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=23
L359E:             08 00                                         ;             Command_08_COMPARE_OBJECT_TO_FIRST_NOUN object=00(NONE
L35A0:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L35A1:               13 5F BE 5B B1 4B 7B 06 9A 90 73 C4         ;               THERE IS NOTHING BEHIND YOU.
L35AD:               6A A3 60 33 98 C7 DE 2E                     ;               .
L35B5:           0D 16                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=22
L35B7:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L35B8:               12 5F BE 5B B1 4B 7B 06 9A 90 73 C4         ;               THERE IS NOTHING BEHIND THE
L35C4:               6A A3 60 33 98 5F BE                        ;               .
L35CB:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L35CC:             84                                            ;             CommonCommand_84
L35CD:       21                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=21 phrase="21: PLUGH *     *          *       "
L35CE:       0A                                                  ;       IF_NOT_JUMP address=35D9
L35CF:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L35D0:           08 B5 6C 8E C5 EB 72 AB BB                      ;           GESUNDHEIT! 
L35D9:       22                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=22 phrase="22: SCREAM *    *          *       "
L35DA:       12                                                  ;       IF_NOT_JUMP address=35ED
L35DB:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L35DC:           10 5B E0 27 60 31 60 41 A0 49 A0 89             ;           YYYEEEEEOOOOOOWWWWWWWW!!
L35E8:           D3 89 D3 69 CE                                  ;           .
L35ED:       23                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=23 phrase="23: QUIT *      *          *       "
L35EE:       05                                                  ;       IF_NOT_JUMP address=35F4
L35EF:         0D 03                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=3
L35F1:           92                                              ;           CommonCommand_92
L35F2:           26                                              ;           Command_26_PRINT_SCORE
L35F3:           24                                              ;           Command_24_ENDLESS_LOOP
L35F4:       2C                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=2C phrase="2C: SCORE *     *          *       "
L35F5:       04                                                  ;       IF_NOT_JUMP address=35FA
L35F6:         0D 02                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=2
L35F8:           92                                              ;           CommonCommand_92
L35F9:           26                                              ;           Command_26_PRINT_SCORE
L35FA:       3E                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=3E phrase="??"
L35FB:       01                                                  ;       IF_NOT_JUMP address=35FD
L35FC:         27                                                ;         Command_27_??_UNKNOWN_COMMAND_??
L35FD:       3F                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=3F phrase="??"
L35FE:       01                                                  ;       IF_NOT_JUMP address=3600
L35FF:         28                                                ;         Command_28_??_UNKNOWN_COMMAND_??
L3600:       25                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=25 phrase="25: LEAVE *     *          *       "
L3601:       0D                                                  ;       IF_NOT_JUMP address=360F
L3602:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3603:           0B 03 C0 7B 14 94 5A E6 5F C0 7A 2E             ;           TRY A DIRECTION.
L360F:       26                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=26 phrase="26: GO AROUND   *          u......."
L3610:       24                                                  ;       IF_NOT_JUMP address=3635
L3611:         0E 22                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=34
L3613:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L3614:           0D 17                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=23
L3616:             1A                                            ;             Command_1A_SET_VAR_OBJECT_TO_FIRST_NOUN
L3617:             15 10                                         ;             Command_15_CHECK_OBJECT_BITS bits=10 ...P....
L3619:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L361A:               02 5F BE                                    ;               THE
L361D:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L361E:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L361F:               0D 40 D2 F3 23 F6 8B 51 18 52 C2 65         ;               WON'T LET YOU PASS!
L362B:               49 21                                       ;               .
L362D:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L362E:             06 09 9A FA 17 70 49                          ;             NOW WHAT?
L3635:       3D                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=3D phrase="3D: GO TO       *          u......."
L3636:       01                                                  ;       IF_NOT_JUMP address=3638
L3637:         94                                                ;         CommonCommand_94
L3638:       27                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=27 phrase="27: KICK *      u.......   *       "
L3639:       0E                                                  ;       IF_NOT_JUMP address=3648
L363A:         0E 0C                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=12
L363C:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L363D:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L363E:             09 25 A1 AB 70 3B 95 77 BF 21                 ;             OUCH! MY TOE!
L3648:       28                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=28 phrase="28: FEED WITH   ...P....   u......."
L3649:       0A                                                  ;       IF_NOT_JUMP address=3654
L364A:         0E 08                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=8
L364C:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L364D:           0D 04                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=4
L364F:             1A                                            ;             Command_1A_SET_VAR_OBJECT_TO_FIRST_NOUN
L3650:             15 10                                         ;             Command_15_CHECK_OBJECT_BITS bits=10 ...P....
L3652:             96                                            ;             CommonCommand_96
L3653:           97                                              ;           CommonCommand_97
L3654:       29                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=29 phrase="29: FEED TO     u.......   ...P...."
L3655:       0A                                                  ;       IF_NOT_JUMP address=3660
L3656:         0E 08                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=8
L3658:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L3659:           0D 04                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=4
L365B:             1B                                            ;             Command_1B_SET_VAR_OBJECT_TO_SECOND_NOUN
L365C:             15 10                                         ;             Command_15_CHECK_OBJECT_BITS bits=10 ...P....
L365E:             96                                            ;             CommonCommand_96
L365F:           97                                              ;           CommonCommand_97
L3660:       2F                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=2F phrase="2F: WAIT *      *          *       "
L3661:       07                                                  ;       IF_NOT_JUMP address=3669
L3662:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3663:           05 9B 29 57 C6 3E                               ;           <PAUSE>
L3669:       2D                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=2D phrase="2D: PULL UP     *          u......."
L366A:       09                                                  ;       IF_NOT_JUMP address=3674
L366B:         0E 07                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=7
L366D:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L366E:           0D 02                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=2
L3670:             1A                                            ;             Command_1A_SET_VAR_OBJECT_TO_FIRST_NOUN
L3671:             83                                            ;             CommonCommand_83
L3672:           14                                              ;           Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L3673:             0C                                            ;             Command_0C_FAIL
L3674:       33                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=33 phrase="??"
L3675:       04                                                  ;       IF_NOT_JUMP address=367A
L3676:         0E 02                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=2
L3678:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L3679:           98                                              ;           CommonCommand_98
L367A:       34                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=34 phrase="34: JUMP OVER   *          u......."
L367B:       04                                                  ;       IF_NOT_JUMP address=3680
L367C:         0E 02                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=2
L367E:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L367F:           98                                              ;           CommonCommand_98
L3680:       36                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=36 phrase="36: CLIMB IN    *          *       "
L3681:       17                                                  ;       IF_NOT_JUMP address=3699
L3682:         0E 15                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=21
L3684:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L3685:           0D 12                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=18
L3687:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3688:               0E C7 DE D3 14 E6 96 77 15 0B BC 96         ;               YOU CAN'T GET IN THE 
L3694:               96 DB 72                                    ;               .
L3697:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L3698:             84                                            ;             CommonCommand_84
L3699:       37                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=37 phrase="37: CLIMB OUT   *          *       "
L369A:       15                                                  ;       IF_NOT_JUMP address=36B0
L369B:         0E 13                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=19
L369D:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L369E:           0D 10                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=16
L36A0:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L36A1:               0C C7 DE 94 14 85 61 0B BC 96 96 DB         ;               YOU AREN'T IN THE 
L36AD:               72                                          ;               .
L36AE:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L36AF:             84                                            ;             CommonCommand_84
L36B0:       38                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=38 phrase="38: CLIMB UNDER *          u......."
L36B1:       20                                                  ;       IF_NOT_JUMP address=36D2
L36B2:         0E 1E                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=30
L36B4:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L36B5:           0D 1B                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=27
L36B7:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L36B8:               17 5F BE 5B B1 4B 7B 06 9A 30 15 29         ;               THERE IS NOT ENOUGH ROOM UNDER THE
L36C4:               A1 14 71 3F A0 B0 17 F4 59 82 17 45         ;               .
L36D0:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L36D1:             84                                            ;             CommonCommand_84
L36D2:       39                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=39 phrase="39: THROW IN    u.......   u......."
L36D3:       1D                                                  ;       IF_NOT_JUMP address=36F1
L36D4:         0E 1B                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=27
L36D6:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L36D7:           0D 18                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=24
L36D9:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L36DA:               16 C7 DE FB 17 F3 8C 58 72 56 5E D2         ;               YOU WILL HAVE TO PUT IT IN THERE.
L36E6:               9C 73 C6 73 7B 83 7A 5F BE 7F B1            ;               .
L36F1:       3A                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=3A phrase="3A: OPEN WITH   u.......   u......."
L36F2:       1E                                                  ;       IF_NOT_JUMP address=3711
L36F3:         0E 1C                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=28
L36F5:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L36F6:           0D 19                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=25
L36F8:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L36F9:               0C C7 DE D3 14 E6 96 C2 16 83 61 5F         ;               YOU CAN'T OPEN THE
L3705:               BE                                          ;               .
L3706:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L3707:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3708:               06 56 D1 16 71 DB 72                        ;               WITH THE 
L370F:             12                                            ;             Command_12_PRINT_SECOND_NOUN_SHORT_NAME
L3710:             84                                            ;             CommonCommand_84
L3711:       0D                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=0D phrase="0D: THROW AT    .v......   ...P...."
L3712:       34                                                  ;       IF_NOT_JUMP address=3747
L3713:         0E 32                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=50
L3715:           0D 2E                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=46
L3717:             1A                                            ;             Command_1A_SET_VAR_OBJECT_TO_FIRST_NOUN
L3718:             83                                            ;             CommonCommand_83
L3719:             0E 2A                                         ;             Command_0E_EXECUTE_LIST_WHILE_FAIL size=42
L371B:               0D 27                                       ;               Command_0D_EXECUTE_LIST_WHILE_PASS size=39
L371D:                 0E 07                                     ;                 Command_0E_EXECUTE_LIST_WHILE_FAIL size=7
L371F:                   14                                      ;                   Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L3720:                     15 10                                 ;                     Command_15_CHECK_OBJECT_BITS bits=10 ...P....
L3722:                   1B                                      ;                   Command_1B_SET_VAR_OBJECT_TO_SECOND_NOUN
L3723:                   14                                      ;                   Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L3724:                     15 40                                 ;                     Command_15_CHECK_OBJECT_BITS bits=40 .v......
L3726:                 04                                        ;                 Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3727:                   02 5F BE                                ;                   THE
L372A:                 11                                        ;                 Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L372B:                 04                                        ;                 Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L372C:                   14 07 4F 17 98 CA B5 37 49 F5 8B D3     ;                   BOUNCES HARMLESSLY OFF OF THE 
L3738:                   B8 B8 16 91 64 96 64 DB 72              ;                   .
L3741:                 12                                        ;                 Command_12_PRINT_SECOND_NOUN_SHORT_NAME
L3742:                 84                                        ;                 CommonCommand_84
L3743:                 10                                        ;                 Command_10_DROP_OBJECT
L3744:               13                                          ;               Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L3745:           14                                              ;           Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L3746:             0C                                            ;             Command_0C_FAIL
L3747:       0E                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=0E phrase="0E: THROW TO    u.......   ...P...."
L3748:       39                                                  ;       IF_NOT_JUMP address=3782
L3749:         0E 37                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=55
L374B:           0D 1B                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=27
L374D:             1B                                            ;             Command_1B_SET_VAR_OBJECT_TO_SECOND_NOUN
L374E:             14                                            ;             Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L374F:               15 10                                       ;               Command_15_CHECK_OBJECT_BITS bits=10 ...P....
L3751:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3752:               02 5F BE                                    ;               THE
L3755:             12                                            ;             Command_12_PRINT_SECOND_NOUN_SHORT_NAME
L3756:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3757:               10 4B 7B 06 9A 85 14 B2 53 90 BE C9         ;               IS NOT ACCEPTING GIFTS. 
L3763:               6A 5E 79 5B BB                              ;               .
L3768:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L3769:           0D 17                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=23
L376B:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L376C:               02 5F BE                                    ;               THE
L376F:             12                                            ;             Command_12_PRINT_SECOND_NOUN_SHORT_NAME
L3770:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3771:               10 60 7B F3 23 D5 46 EE 61 91 7A BC         ;               ISN'T ACCEPTING BRIBES. 
L377D:               14 AF 78 5B BB                              ;               .
L3782:       0F                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=0F phrase="0F: DROP IN     u.......   u......."
L3783:       19                                                  ;       IF_NOT_JUMP address=379D
L3784:         0E 17                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=23
L3786:           13                                              ;           Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L3787:           0D 14                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=20
L3789:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L378A:               02 5F BE                                    ;               THE
L378D:             11                                            ;             Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L378E:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L378F:               0B 40 D2 F3 23 16 67 D0 15 82 17 45         ;               WON'T FIT IN THE
L379B:             12                                            ;             Command_12_PRINT_SECOND_NOUN_SHORT_NAME
L379C:             84                                            ;             CommonCommand_84
L379D:       14                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=14 phrase="14: LIGHT WITH  u...A...   u...A..."
L379E:       3B                                                  ;       IF_NOT_JUMP address=37DA
L379F:         0D 39                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=57
L37A1:           1B                                              ;           Command_1B_SET_VAR_OBJECT_TO_SECOND_NOUN
L37A2:           83                                              ;           CommonCommand_83
L37A3:           0E 35                                           ;           Command_0E_EXECUTE_LIST_WHILE_FAIL size=53
L37A5:             0D 18                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=24
L37A7:               1A                                          ;               Command_1A_SET_VAR_OBJECT_TO_FIRST_NOUN
L37A8:               15 08                                       ;               Command_15_CHECK_OBJECT_BITS bits=08 ....A...
L37AA:               0E 04                                       ;               Command_0E_EXECUTE_LIST_WHILE_FAIL size=4
L37AC:                 09 12                                     ;                 Command_09_COMPARE_OBJECT_TO_SECOND_NOUN object=12(LitCandle
L37AE:                 09 14                                     ;                 Command_09_COMPARE_OBJECT_TO_SECOND_NOUN object=14(LitLamp
L37B0:               0E 0D                                       ;               Command_0E_EXECUTE_LIST_WHILE_FAIL size=13
L37B2:                 13                                        ;                 Command_13_PROCESS_PHRASE_BY_ROOM_OR_FIRST_OR_SECOND
L37B3:                 04                                        ;                 Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L37B4:                   0A 73 7B 40 D2 F3 23 F4 4F 1B 9C        ;                   IT WON'T BURN. 
L37BF:             0D 19                                         ;             Command_0D_EXECUTE_LIST_WHILE_PASS size=25
L37C1:               04                                          ;               Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L37C2:                 0C C7 DE D3 14 E6 96 BF 14 C3 B2 5F       ;                 YOU CAN'T BURN THE
L37CE:                 BE                                        ;                 .
L37CF:               11                                          ;               Command_11_PRINT_FIRST_NOUN_SHORT_NAME
L37D0:               04                                          ;               Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L37D1:                 06 56 D1 16 71 DB 72                      ;                 WITH THE 
L37D8:               12                                          ;               Command_12_PRINT_SECOND_NOUN_SHORT_NAME
L37D9:               84                                          ;               CommonCommand_84
L37DA:       07                                                  ;       Command_0A_COMPARE_TO_PHRASE_FORM val=07 phrase="07: INVENT *    *          *       "
L37DB:       1A                                                  ;       IF_NOT_JUMP address=37F6
L37DC:         0D 18                                             ;         Command_0D_EXECUTE_LIST_WHILE_PASS size=24
L37DE:           04                                              ;           Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L37DF:             15 C7 DE 94 14 45 5E 3C 49 D0 DD D6           ;             YOU ARE CARRYING THE FOLLOWING:
L37EB:             6A DB 72 FE 67 89 8D 91 7A 3A                 ;             .
L37F5:           06                                              ;           Command_06_PRINT_INVENTORY
L37F6:     04                                                    ;     Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L37F7:       02 00 00                                            ;       ???
; ENDOF 323C

;##HelperCommands
L37FA: 00 84 2C                                                  ; Script list size=042C
L37FD:   81 63                                                   ;   Script number=81 size=042C
L37FF:       0D 61                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=97
L3801:         1F                                                ;         Command_1F_PRINT_MESSAGE
L3802:           10 C7 DE AF 23 FF 14 17 47 8C 17 43             ;           YOU'RE DEAD. TRY AGAIN. 
L380E:           DB 0B 6C 1B 9C                                  ;           .
L3813:         95                                                ;         CommonCommand_95
L3814:         17 01 81                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=01(Object1) location=81
L3817:         17 05 84                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=05(Food) location=84
L381A:         17 06 88                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=06(StatueEast) location=88
L381D:         17 07 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=07(StatueWest) location=00
L3820:         17 08 8C                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=08(GoldRing) location=8C
L3823:         17 09 A1                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=09(Sword) location=A1
L3826:         17 0A 8E                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=0A(StoneGargoyle) location=8E
L3829:         17 0C 95                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=0C(Idol) location=95
L382C:         17 0E 91                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=0E(UnpulledLever) location=91
L382F:         17 0F 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=0F(PulledLever) location=00
L3832:         17 11 92                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=11(UnlitCandle) location=92
L3835:         17 12 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=12(LitCandle) location=00
L3838:         17 14 A0                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=14(LitLamp) location=A0
L383B:         17 15 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=15(LiveSerpent) location=00
L383E:         17 16 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=16(DeadSerpent) location=00
L3841:         17 18 9C                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=18(Coin) location=9C
L3844:         17 1E 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=1E(LiveGargoyle) location=00
L3847:         17 1F 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=1F(DeadGargoyle) location=00
L384A:         17 22 8F                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=22(GoldenChopstick) location=8F
L384D:         17 25 9C                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=25(GemA) location=9C
L3850:         17 26 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=26(GemB) location=00
L3853:         17 28 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=28(UnlitLamp) location=00
L3856:         1C 15                                             ;         Command_1C_SET_VAR_OBJECT object=15 (LiveSerpent)
L3858:         23 3C                                             ;         Command_23_HEAL_VAR_OBJECT value=3C
L385A:         1C 1D                                             ;         Command_1C_SET_VAR_OBJECT object=1D (USER)
L385C:         23 46                                             ;         Command_23_HEAL_VAR_OBJECT value=46
L385E:         17 1D 96                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=1D(USER) location=96
L3861:         25                                                ;         Command_25_RESTART_GAME
L3862:   82 2C                                                   ;   Script number=82 size=042C
L3864:       0D 2A                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=42
L3866:         1F                                                ;         Command_1F_PRINT_MESSAGE
L3867:           27 5F BE 66 17 8F 49 54 5E 3F 61 57             ;           THE STATUE RELEASES THE ARROW WHICH
L3873:           49 D6 B5 DB 72 3C 49 6B A1 23 D1 13             ;           PENETRATES YOUR HEART.
L387F:           54 F0 A4 8C 62 7F 49 DB B5 34 A1 9F             ;           .
L388B:           15 3E 49 2E                                     ;           .
L388F:         81                                                ;         CommonCommand_81
L3890:   83 66                                                   ;   Script number=83 size=042C
L3892:       0D 64                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=100
L3894:         0E 61                                             ;         Command_0E_EXECUTE_LIST_WHILE_FAIL size=97
L3896:           0D 08                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=8
L3898:             08 0E                                         ;             Command_08_COMPARE_OBJECT_TO_FIRST_NOUN object=0E(UnpulledLever
L389A:             17 0E 00                                      ;             Command_17_MOVE_OBJECT_TO_LOCATION object=0E(UnpulledLever) location=00
L389D:             1C 0F                                         ;             Command_1C_SET_VAR_OBJECT object=0F (PulledLever)
L389F:             0C                                            ;             Command_0C_FAIL
L38A0:           0D 08                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=8
L38A2:             08 25                                         ;             Command_08_COMPARE_OBJECT_TO_FIRST_NOUN object=25(GemA
L38A4:             17 25 00                                      ;             Command_17_MOVE_OBJECT_TO_LOCATION object=25(GemA) location=00
L38A7:             1C 26                                         ;             Command_1C_SET_VAR_OBJECT object=26 (GemB)
L38A9:             0C                                            ;             Command_0C_FAIL
L38AA:           0D 1D                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=29
L38AC:             15 10                                         ;             Command_15_CHECK_OBJECT_BITS bits=10 ...P....
L38AE:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L38AF:               0C 46 77 05 A0 16 BC 90 73 D6 83 DB         ;               I DON'T THINK THE 
L38BB:               72                                          ;               .
L38BC:             16                                            ;             Command_16_PRINT_VAR_NOUN_SHORT_NAME
L38BD:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L38BE:               0A 4E D1 05 8A 42 A0 2B 62 FF BD            ;               WILL COOPERATE.
L38C9:           0D 21                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=33
L38CB:             14                                            ;             Command_14_EXECUTE_COMMAND_REVERSE_STATUS
L38CC:               15 20                                       ;               Command_15_CHECK_OBJECT_BITS bits=20 ..C.....
L38CE:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L38CF:               1A C7 DE 94 14 53 5E D6 C4 4B 5E 13         ;               YOU ARE QUITE INCAPABLE OF REMOVING THE
L38DB:               98 44 A4 DB 8B C3 9E 6F B1 53 A1 AB         ;               .
L38E7:               98 5F BE                                    ;               .
L38EA:             16                                            ;             Command_16_PRINT_VAR_NOUN_SHORT_NAME
L38EB:             84                                            ;             CommonCommand_84
L38EC:           18                                              ;           Command_18_CHECK_VAR_OBJECT_OWNED_BY_ACTIVE_OBJECT
L38ED:           0D 08                                           ;           Command_0D_EXECUTE_LIST_WHILE_PASS size=8
L38EF:             0F                                            ;             Command_0F_PICK_UP_OBJECT
L38F0:             16                                            ;             Command_16_PRINT_VAR_NOUN_SHORT_NAME
L38F1:             04                                            ;             Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L38F2:               04 4D BD A7 61                              ;               TAKEN.
L38F7:         18                                                ;         Command_18_CHECK_VAR_OBJECT_OWNED_BY_ACTIVE_OBJECT
L38F8:   84 04                                                   ;   Script number=84 size=042C
L38FA:       04                                                  ;       Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L38FB:         02 3B F4                                          ;         .  
L38FE:   85 29                                                   ;   Script number=85 size=042C
L3900:       1F                                                  ;       Command_1F_PRINT_MESSAGE
L3901:         27 49 45 07 B3 11 A3 89 64 94 C3 0B               ;         A GROUP OF GUARDS MARCHES AROUND THE CORNER
L390D:         5C 94 91 1F 54 C3 B5 07 B3 33 98 5F               ;         TO YOUR RIGHT.
L3919:         BE E1 14 CF B2 96 AF DB 9C 34 A1 33               ;         .
L3925:         17 2E 6D 2E                                       ;         .
L3929:   87 2A                                                   ;   Script number=87 size=042C
L392B:       1F                                                  ;       Command_1F_PRINT_MESSAGE
L392C:         28 49 45 07 B3 11 A3 89 64 94 C3 0B               ;         A GROUP OF GUARDS DISAPPEARS AROUND THE
L3938:         5C 95 5A EA 48 94 5F C3 B5 07 B3 33               ;         CORNER TO YOUR LEFT.
L3944:         98 5F BE E1 14 CF B2 96 AF DB 9C 34               ;         .
L3950:         A1 3F 16 D7 68                                    ;         .
L3955:   86 1E                                                   ;   Script number=86 size=042C
L3957:       1F                                                  ;       Command_1F_PRINT_MESSAGE
L3958:         1C 49 45 07 B3 11 A3 89 64 94 C3 0B               ;         A GROUP OF GUARDS COMES AROUND THE CORNER.
L3964:         5C 3F 55 4B 62 39 49 8E C5 82 17 45               ;         .
L3970:         5E B8 A0 47 62                                    ;         .
L3975:   88 13                                                   ;   Script number=88 size=042C
L3977:       0D 11                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=17
L3979:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L397A:           02 5F BE                                        ;           THE
L397D:         12                                                ;         Command_12_PRINT_SECOND_NOUN_SHORT_NAME
L397E:         04                                                ;         Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L397F:           0A 4B 7B 06 9A BF 14 10 B2 5B 70                ;           IS NOT BURING. 
L398A:   92 1C                                                   ;   Script number=92 size=042C
L398C:       1F                                                  ;       Command_1F_PRINT_MESSAGE
L398D:         1A 36 A1 B8 16 7B 14 85 A6 44 B8 DB               ;         OUT OF A POSSIBLE FIFTY, YOUR SCORE IS 
L3999:         8B 08 67 1E C1 51 18 23 C6 61 B7 5B               ;         .
L39A5:         B1 4B 7B                                          ;         .
L39A8:   89 12                                                   ;   Script number=89 size=042C
L39AA:       1F                                                  ;       Command_1F_PRINT_MESSAGE
L39AB:         10 C7 DE D3 14 E6 96 FF 15 D3 93 5B               ;         YOU CAN'T JUMP THAT FAR!
L39B7:         BE 08 BC 21 49                                    ;         .
L39BC:   8A 32                                                   ;   Script number=8A size=042C
L39BE:       0D 30                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=48
L39C0:         1F                                                ;         Command_1F_PRINT_MESSAGE
L39C1:           2D C7 DE 3B 16 33 98 03 A0 55 45 8D             ;           YOU LAND ON A SPIKE AT THE BOTTOM OF THE PIT
L39CD:           A5 43 5E 16 BC DB 72 06 4F 7F BF B8             ;           WHICH THE RUG COVERED.
L39D9:           16 82 17 52 5E 73 7B 23 D1 13 54 5F             ;           .
L39E5:           BE 3F 17 C5 6A 4F A1 66 B1 2E                   ;           .
L39EF:         81                                                ;         CommonCommand_81
L39F0:   8B 79                                                   ;   Script number=8B size=042C
L39F2:       0D 77                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=119
L39F4:         1F                                                ;         Command_1F_PRINT_MESSAGE
L39F5:           74 C7 DE 2F 17 43 48 5B E3 23 D1 DB             ;           YOU REALIZE WHILE YOU'RE FALLING THAT THE
L3A01:           8B C7 DE AF 23 4B 15 03 8D AB 98 5B             ;           RUG COVERED A PIT. THE BOTTOM OF THE PIT IS
L3A0D:           BE 16 BC DB 72 E9 B3 E1 14 74 CA F3             ;           COVERED WITH SPIKES ABOUT FOUR FEET TALL -
L3A19:           5F 52 45 97 7B 82 17 44 5E 0E A1 DB             ;           YOU DON'T HAVE TIME TO MEASURE THEM EXACTLY.
L3A25:           9F C3 9E 5F BE E3 16 0B BC C5 B5 4F             ;           
L3A31:           A1 66 B1 FB 17 53 BE 63 B9 B5 85 84             ;           .
L3A3D:           14 36 A1 59 15 23 C6 67 66 16 BC 46             ;           .
L3A49:           48 8B 18 C7 DE 09 15 E6 96 9B 15 5B             ;           .
L3A55:           CA 8F BE 56 5E CF 9C 95 5F 2F C6 82             ;           .
L3A61:           17 5B 61 1B 63 06 56 DB E0                      ;           .
L3A6A:         81                                                ;         CommonCommand_81
L3A6B:   8C 49                                                   ;   Script number=8C size=042C
L3A6D:       1F                                                  ;       Command_1F_PRINT_MESSAGE
L3A6E:         47 C7 DE 03 15 61 B7 74 CA 7B 14 E7               ;         YOU DISCOVER A DEEP DARK PIT WHICH EXTENDS
L3A7A:         59 06 A3 35 49 E3 16 19 BC 85 73 07               ;         FROM THE NORTH TO THE SOUTH WALL. THE PIT IS
L3A86:         71 3F D9 4D 98 5C 15 DB 9F 5F BE 99               ;         TOO BROAD TO JUMP.
L3A92:         16 C2 B3 89 17 82 17 55 5E 36 A1 19               ;         .
L3A9E:         71 46 48 56 F4 DB 72 96 A5 D5 15 89               ;         .
L3AAA:         17 C4 9C F3 B2 16 58 CC 9C 72 C5 2E               ;         .
L3AB6:   8D 20                                                   ;   Script number=8D size=042C
L3AB8:       04                                                  ;       Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3AB9:         1E 5F BE 66 17 8F 49 4B 5E CF B5 DA               ;         THE STATUE IS MUCH TOO HEAVY FOR YOU TO
L3AC5:         C3 89 17 CA 9C 98 5F 48 DB A3 A0 C7               ;         MOVE.
L3AD1:         DE 89 17 71 16 7F CA                              ;         .
L3AD8:   8E 3E                                                   ;   Script number=8E size=042C
L3ADA:       04                                                  ;       Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3ADB:         3C 7A C4 D9 06 82 7B 84 15 96 5F 03               ;         UGH! WITH GREAT DIFFICULTY YOU MANAGE TO
L3AE7:         15 93 66 2E 56 FB C0 C7 DE 63 16 C9               ;         MOVE THE ALTAR AND YOU DISCOVER A SECRET
L3AF3:         97 56 5E CF 9C 4F A1 82 17 43 5E 3B               ;         PASSAGE.
L3AFF:         8E 83 AF 33 98 C7 DE 03 15 61 B7 74               ;         .
L3B0B:         CA 7B 14 A5 B7 76 B1 DB 16 D3 B9 BF               ;         .
L3B17:         6C                                                ;         .
L3B18:   8F 07                                                   ;   Script number=8F size=042C
L3B1A:       0D 05                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=5
L3B1C:         08 2B                                             ;         Command_08_COMPARE_OBJECT_TO_FIRST_NOUN object=2B(Passage
L3B1E:         00 A5                                             ;         Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=A5
L3B20:         90                                                ;         CommonCommand_90
L3B21:   90 22                                                   ;   Script number=90 size=042C
L3B23:       1F                                                  ;       Command_1F_PRINT_MESSAGE
L3B24:         20 5F BE 8E 14 54 BD 71 16 75 CA AB               ;         THE ALTAR MOVES BACK TO SEAL THE HOLE ABOVE
L3B30:         14 8B 54 6B BF A3 B7 16 8A DB 72 7E               ;         YOU.
L3B3C:         74 43 5E 08 4F 5B 5E 3F A1                        ;         .
L3B45:   91 37                                                   ;   Script number=91 size=042C
L3B47:       0D 35                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=53
L3B49:         1F                                                ;         Command_1F_PRINT_MESSAGE
L3B4A:           30 4B 49 C7 DE DE 14 64 7A C7 16 11             ;           AS YOU CLIMB OUT OF THE HOLE, IT SEEMS TO
L3B56:           BC 96 64 DB 72 7E 74 B3 63 73 7B A7             ;           MAGICALLY SEAL UP BEHIND YOU. 
L3B62:           B7 4B 94 6B BF 89 91 D3 78 13 8D 57             ;           .
L3B6E:           17 33 48 D3 C5 6A 4D 8E 7A 51 18 DB             ;           .
L3B7A:           C7                                              ;           .
L3B7B:         00 9F                                             ;         Command_00_MOVE_ACTIVE_OBJECT_TO_ROOM_AND_LOOK room=9F
L3B7D:         95                                                ;         CommonCommand_95
L3B7E:   93 09                                                   ;   Script number=93 size=042C
L3B80:       0B 07                                               ;       Command_0B_SWITCH size=07
L3B82:         0A 36                                             ;         Command_0A_COMPARE_TO_PHRASE_FORM val=36 phrase="36: CLIMB IN    *          *       "
L3B84:         01                                                ;         IF_NOT_JUMP address=3B86
L3B85:           94                                              ;           CommonCommand_94
L3B86:         37                                                ;         Command_0A_COMPARE_TO_PHRASE_FORM val=37 phrase="37: CLIMB OUT   *          *       "
L3B87:         01                                                ;         IF_NOT_JUMP address=3B89
L3B88:           94                                              ;           CommonCommand_94
L3B89:   94 19                                                   ;   Script number=94 size=042C
L3B8B:       1F                                                  ;       Command_1F_PRINT_MESSAGE
L3B8C:         17 FF A5 57 49 B5 17 46 5E 2F 7B 03               ;         PLEASE USE DIRECTIONS N,S,E, OR W.
L3B98:         56 1D A0 A6 16 3F BB 11 EE 99 AF 2E               ;         .
L3BA4:   95 26                                                   ;   Script number=95 size=042C
L3BA6:       0D 24                                               ;       Command_0D_EXECUTE_LIST_WHILE_PASS size=36
L3BA8:         17 36 FF                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=36(Jungle) location=FF
L3BAB:         17 29 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=29(Floor) location=00
L3BAE:         17 2A 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=2A(Exit) location=00
L3BB1:         17 2B 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=2B(Passage) location=00
L3BB4:         17 2C 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=2C(Hole) location=00
L3BB7:         17 2D 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=2D(Corridor) location=00
L3BBA:         17 2E 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=2E(Corner) location=00
L3BBD:         17 31 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=31(Hallway) location=00
L3BC0:         17 34 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=34(Entrance) location=00
L3BC3:         17 35 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=35(Tunnel) location=00
L3BC6:         17 3A 00                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=3A(Ceiling) location=00
L3BC9:         17 3C 1D                                          ;         Command_17_MOVE_OBJECT_TO_LOCATION object=3C(Object3C) location=1D
L3BCC:   96 1A                                                   ;   Script number=96 size=042C
L3BCE:       04                                                  ;       Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3BCF:         18 5B BE 65 BC 7B 14 41 6E 19 58 3B               ;         THAT'S A GOOD WAY TO LOSE YOUR HAND!
L3BDB:         4A 6B BF 85 8D 5B 5E 34 A1 9B 15 31               ;         .
L3BE7:         98                                                ;         .
L3BE8:   97 19                                                   ;   Script number=97 size=042C
L3BEA:       04                                                  ;       Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3BEB:         17 43 79 C7 DE D3 14 88 96 8E 7A 7B               ;         IF YOU CAN FIND A MOUTH, I'M GAME!
L3BF7:         14 C7 93 76 BE BD 15 49 90 67 48 21               ;         .
L3C03:   98 24                                                   ;   Script number=98 size=042C
L3C05:       04                                                  ;       Command_04_PRINT_SYSTEM_OR_PLAYER_MESSAGE
L3C06:         22 0F A0 5F 17 46 48 66 17 D3 61 04               ;         ONE SMALL STEP FOR MANKIND, ONE GIANT LEAP
L3C12:         68 63 16 5B 99 56 98 C0 16 49 5E 90               ;         FOR YOU!
L3C1E:         78 0E BC 92 5F 59 15 9B AF 19 A1                  ;         .
; ENDOF 37FA

;##InputWordTables

; --- IGNORES --- Maybe for curse words. No words in this list and thus never used.
L3C29: 00                
;  
; --- VERBS ---   
L3C2A: 04 52 45 41 44 01         ; READ     1
L3C30: 03 47 45 54 09            ; GET      9
L3C35: 05 54 48 52 4F 57 03      ; THROW    3
L3C3C: 06 41 54 54 41 43 4B 04   ; ATTACK   4
L3C44: 04 4B 49 4C 4C 04         ; KILL     4
L3C4A: 03 48 49 54 04            ; HIT      4
L3C4F: 05 4E 4F 52 54 48 05      ; NORTH    5
L3C56: 01 4E 05                  ; N        5
L3C59: 05 53 4F 55 54 48 06      ; SOUTH    6
L3C60: 01 53 06                  ; S        6
L3C63: 04 45 41 53 54 07         ; EAST     7
L3C69: 01 45 07                  ; E        7
L3C6C: 04 57 45 53 54 08         ; WEST     8
L3C72: 01 57 08                  ; W        8
L3C75: 04 54 41 4B 45 09         ; TAKE     9
L3C7B: 04 44 52 4F 50 0A         ; DROP     10
L3C81: 03 50 55 54 0A            ; PUT      10
L3C86: 06 49 4E 56 45 4E 54 0B   ; INVENT   11
L3C8E: 04 4C 4F 4F 4B 0C         ; LOOK     12
L3C94: 04 47 49 56 45 0D         ; GIVE     13
L3C9A: 05 4F 46 46 45 52 0D      ; OFFER    13
L3CA1: 06 45 58 41 4D 49 4E 0E   ; EXAMIN   14
L3CA9: 06 53 45 41 52 43 48 0E   ; SEARCH   14
L3CB1: 04 4F 50 45 4E 0F         ; OPEN     15
L3CB7: 04 50 55 4C 4C 10         ; PULL     16
L3CBD: 05 4C 49 47 48 54 11      ; LIGHT    17
L3CC4: 04 42 55 52 4E 11         ; BURN     17
L3CCA: 03 45 41 54 12            ; EAT      18
L3CCF: 05 54 41 53 54 45 12      ; TASTE    18
L3CD6: 04 42 4C 4F 57 13         ; BLOW     19
L3CDC: 06 45 58 54 49 4E 47 14   ; EXTING   20
L3CE4: 05 43 4C 49 4D 42 15      ; CLIMB    21
L3CEB: 03 52 55 42 16            ; RUB      22
L3CF0: 04 57 49 50 45 16         ; WIPE     22
L3CF6: 06 50 4F 4C 49 53 48 16   ; POLISH   22
L3CFE: 04 4C 49 46 54 1C         ; LIFT     28
L3D04: 04 57 41 49 54 1F         ; WAIT     31
L3D0A: 04 53 54 41 59 1F         ; STAY     31
L3D10: 04 4A 55 4D 50 20         ; JUMP     32
L3D16: 02 47 4F 21               ; GO       33
L3D1A: 03 52 55 4E 21            ; RUN      33
L3D1F: 05 45 4E 54 45 52 21      ; ENTER    33
L3D26: 04 50 55 53 48 10         ; PUSH     16
L3D2C: 04 4D 4F 56 45 10         ; MOVE     16
L3D32: 04 4B 49 43 4B 23         ; KICK     35
L3D38: 04 46 45 45 44 24         ; FEED     36
L3D3E: 05 53 43 4F 52 45 28      ; SCORE    40
L3D45: 06 53 43 52 45 41 4D 2B   ; SCREAM   43
L3D4D: 04 59 45 4C 4C 2B         ; YELL     43
L3D53: 04 51 55 49 54 2D         ; QUIT     45
L3D59: 04 53 54 4F 50 2D         ; STOP     45
L3D5F: 05 50 4C 55 47 48 32      ; PLUGH    50
L3D66: 05 4C 45 41 56 45 2C      ; LEAVE    44
L3D6D: 04 50 49 43 4B 34         ; PICK     52
L3D73: 00
;
; --- NOUNS ---
L3D74: 06 50 4F 54 49 4F 4E 03   ; POTION   3
L3D7C: 03 52 55 47 06            ; RUG      6
L3D81: 04 44 4F 4F 52 09         ; DOOR     9
L3D87: 04 46 4F 4F 44 0C         ; FOOD     12
L3D8D: 06 53 54 41 54 55 45 0D   ; STATUE   13
L3D95: 05 53 57 4F 52 44 0E      ; SWORD    14
L3D9C: 06 47 41 52 47 4F 59 0F   ; GARGOY   15
L3DA4: 04 52 49 4E 47 12         ; RING     18
L3DAA: 03 47 45 4D 13            ; GEM      19
L3DAF: 05 4C 45 56 45 52 16      ; LEVER    22
L3DB6: 06 50 4C 41 51 55 45 18   ; PLAQUE   24
L3DBE: 05 52 55 4E 45 53 18      ; RUNES    24
L3DC5: 04 53 49 47 4E 18         ; SIGN     24
L3DCB: 06 4D 45 53 53 41 47 18   ; MESSAG   24
L3DD3: 06 43 41 4E 44 4C 45 19   ; CANDLE   25
L3DDB: 04 4C 41 4D 50 1B         ; LAMP     27
L3DE1: 06 43 48 4F 50 53 54 1E   ; CHOPST   30
L3DE9: 04 48 41 4E 44 1F         ; HAND     31
L3DEF: 05 48 41 4E 44 53 1F      ; HANDS    31
L3DF6: 04 43 4F 49 4E 20         ; COIN     32
L3DFC: 04 53 4C 4F 54 21         ; SLOT     33
L3E02: 05 41 4C 54 41 52 22      ; ALTAR    34
L3E09: 04 49 44 4F 4C 23         ; IDOL     35
L3E0F: 06 53 45 52 50 45 4E 24   ; SERPEN   36
L3E17: 05 53 4E 41 4B 45 24      ; SNAKE    36
L3E1E: 04 57 41 4C 4C 25         ; WALL     37
L3E24: 05 57 41 4C 4C 53 25      ; WALLS    37
L3E2B: 04 56 49 4E 45 26         ; VINE     38
L3E31: 05 56 49 4E 45 53 26      ; VINES    38
L3E38: 04 47 41 54 45 27         ; GATE     39
L3E3E: 05 47 41 54 45 53 27      ; GATES    39
L3E45: 05 47 55 41 52 44 28      ; GUARD    40
L3E4C: 06 47 55 41 52 44 53 28   ; GUARDS   40
L3E54: 04 52 4F 4F 4D 2A         ; ROOM     42
L3E5A: 05 46 4C 4F 4F 52 2B      ; FLOOR    43
L3E61: 04 45 58 49 54 2C         ; EXIT     44
L3E67: 06 50 41 53 53 41 47 2D   ; PASSAG   45
L3E6F: 04 48 4F 4C 45 2E         ; HOLE     46
L3E75: 06 43 4F 52 52 49 44 2F   ; CORRID   47
L3E7D: 03 42 4F 57 31            ; BOW      49
L3E82: 05 41 52 52 4F 57 32      ; ARROW    50
L3E89: 06 48 41 4C 4C 57 41 33   ; HALLWA   51
L3E91: 06 43 48 41 4D 42 45 34   ; CHAMBE   52
L3E99: 05 56 41 55 4C 54 35      ; VAULT    53
L3EA0: 06 45 4E 54 52 41 4E 36   ; ENTRAN   54
L3EA8: 06 54 55 4E 4E 45 4C 37   ; TUNNEL   55
L3EB0: 06 4A 55 4E 47 4C 45 38   ; JUNGLE   56
L3EB8: 06 54 45 4D 50 4C 45 39   ; TEMPLE   57
L3EC0: 03 50 49 54 3A            ; PIT      58
L3EC5: 06 43 45 49 4C 49 4E 3B   ; CEILIN   59
L3ECD: 00
;
; --- ADJECTIVES ---
L3ECE: 00
;
; --- PREPOSITIONS ---
L3ECF: 02 54 4F 01               ; TO       1
L3ED3: 04 57 49 54 48 02         ; WITH     2
L3ED9: 02 41 54 03               ; AT       3
L3EDD: 05 55 4E 44 45 52 04      ; UNDER    4
L3EE4: 02 49 4E 05               ; IN       5
L3EE8: 04 49 4E 54 4F 05         ; INTO     5
L3EEE: 03 4F 55 54 06            ; OUT      6
L3EF3: 02 55 50 07               ; UP       7
L3EF7: 04 44 4F 57 4E 08         ; DOWN     8
L3EFD: 04 4F 56 45 52 09         ; OVER     9
L3F03: 06 42 45 48 49 4E 44 0A   ; BEHIND   10
L3F0B: 06 41 52 4F 55 4E 44 0B   ; AROUND   11
L3F13: 02 4F 4E 0C               ; ON       12
L3F17: 00
