codeunit 50054 DimensionManagement2
{
    Permissions = TableData 80 = imd,
                  TableData 232 = imd,
                  TableData 355 = imd;

    trigger OnRun()
    begin
    end;

    var
        Text000: Label 'Dimensions %1 and %2 can''t be used concurrently.';
        Text001: Label 'Dimension combinations %1 - %2 and %3 - %4 can''t be used concurrently.';
        Text002: Label 'This Shortcut Dimension is not defined in the %1.';
        Text003: Label '%1 is not an available %2 for that dimension.';
        Text004: Label 'Select a %1 for the %2 %3.';
        Text005: Label 'Select a %1 for the %2 %3 for %4 %5.';
        Text006: Label 'Select %1 %2 for the %3 %4.';
        Text007: Label 'Select %1 %2 for the %3 %4 for %5 %6.';
        Text008: Label '%1 %2 must be blank.';
        Text009: Label '%1 %2 must be blank for %3 %4.';
        Text010: Label '%1 %2 must not be mentioned.';
        Text011: Label '%1 %2 must not be mentioned for %3 %4.';
        Text012: Label 'A %1 used in %2 has not been used in %3.';
        Text013: Label '%1 for %2 %3 is not the same in %4 and %5.';
        Text014: Label '%1 %2 is blocked.';
        Text015: Label '%1 %2 can''t be found.';
        Text016: Label '%1 %2 - %3 is blocked.';
        Text017: Label '%1 for %2 %3 - %4 must not be %5.';
        Text018: Label '%1 for %2 is missing.';
        Text019: Label 'You have changed a dimension.\\Do you want to update the lines?';
        TempDimBuf1: Record 360 temporary;
        TempDimBuf2: Record 360 temporary;
        ObjTransl: Record 377;
        DimValComb: Record 351;
        JobTaskDimTemp: Record 1002 temporary;
        DefaultDim: Record 352;
        DimSetEntry: Record 480;
        TempDimSetEntry2: Record 480 temporary;
        TempDimCombInitialized: Boolean;
        TempDimCombEmpty: Boolean;
        DimCombErr: Text[250];
        DimValuePostingErr: Text[250];
        DimErr: Text[250];
        DocDimConsistencyErr: Text[250];
        HasGotGLSetup: Boolean;
        GLSetupShortcutDimCode: array[8] of Code[20];
        DimSetFilterCtr: Integer;
        LastDimSetIDInFilter: Integer;

    procedure GetDimensionSetID(var DimSetEntry2: Record 480): Integer
    begin
        EXIT(DimSetEntry.GetDimensionSetID(DimSetEntry2));
    end;

    procedure GetDimensionSet(var TempDimSetEntry: Record 480 temporary; DimSetID: Integer)
    var
        DimSetEntry2: Record 480;
    begin
        TempDimSetEntry.DELETEALL;
        DimSetEntry2.SETRANGE("Dimension Set ID", DimSetID);
        IF DimSetEntry2.FINDSET THEN
            REPEAT
                TempDimSetEntry := DimSetEntry2;
                TempDimSetEntry.INSERT;
            UNTIL DimSetEntry2.NEXT = 0;
    end;

    procedure ShowDimensionSet(DimSetID: Integer; NewCaption: Text[250])
    var
        DimSetEntries: Page 479;
    begin
        DimSetEntry.RESET;
        DimSetEntry.FILTERGROUP(2);
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        DimSetEntry.FILTERGROUP(0);
        DimSetEntries.SETTABLEVIEW(DimSetEntry);
        DimSetEntries.SetFormCaption(NewCaption);
        DimSetEntry.RESET;
        DimSetEntries.RUNMODAL;
    end;

    procedure EditDimensionSet(DimSetID: Integer; NewCaption: Text[250]): Integer
    var
        EditDimSetEntries: Page 480;
        NewDimSetID: Integer;
    begin
        NewDimSetID := DimSetID;
        DimSetEntry.RESET;
        DimSetEntry.FILTERGROUP(2);
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        DimSetEntry.FILTERGROUP(0);
        EditDimSetEntries.SETTABLEVIEW(DimSetEntry);
        EditDimSetEntries.SetFormCaption(NewCaption);
        EditDimSetEntries.RUNMODAL;
        NewDimSetID := EditDimSetEntries.GetDimensionID;
        DimSetEntry.RESET;
        EXIT(NewDimSetID);
    end;

    procedure EditDimensionSet2(DimSetID: Integer; NewCaption: Text[250]; var GlobalDimVal1: Code[20]; var GlobalDimVal2: Code[20]): Integer
    var
        EditDimSetEntries: Page 480;
        NewDimSetID: Integer;
    begin
        NewDimSetID := DimSetID;
        DimSetEntry.RESET;
        DimSetEntry.FILTERGROUP(2);
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        DimSetEntry.FILTERGROUP(0);
        EditDimSetEntries.SETTABLEVIEW(DimSetEntry);
        EditDimSetEntries.SetFormCaption(NewCaption);
        EditDimSetEntries.RUNMODAL;
        NewDimSetID := EditDimSetEntries.GetDimensionID;
        UpdateGlobalDimFromDimSetID(NewDimSetID, GlobalDimVal1, GlobalDimVal2);
        DimSetEntry.RESET;
        EXIT(NewDimSetID);
    end;

    procedure EditReclasDimensionSet2(var DimSetID: Integer; var NewDimSetID: Integer; NewCaption: Text[250]; var GlobalDimVal1: Code[20]; var GlobalDimVal2: Code[20]; var NewGlobalDimVal1: Code[20]; var NewGlobalDimVal2: Code[20])
    var
        EditReclasDimensions: Page 484;
    begin
        EditReclasDimensions.SetDimensionIDs(DimSetID, NewDimSetID);
        EditReclasDimensions.SetFormCaption(NewCaption);
        EditReclasDimensions.RUNMODAL;
        EditReclasDimensions.GetDimensionIDs(DimSetID, NewDimSetID);
        UpdateGlobalDimFromDimSetID(DimSetID, GlobalDimVal1, GlobalDimVal2);
        UpdateGlobalDimFromDimSetID(NewDimSetID, NewGlobalDimVal1, NewGlobalDimVal2);
    end;

    procedure UpdateGlobalDimFromDimSetID(DimSetID: Integer; var GlobalDimVal1: Code[20]; var GlobalDimVal2: Code[20])
    begin
        GetGLSetup;
        GlobalDimVal1 := '';
        GlobalDimVal2 := '';
        IF GLSetupShortcutDimCode[1] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[1]) THEN
                GlobalDimVal1 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[2] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[2]) THEN
                GlobalDimVal2 := DimSetEntry."Dimension Value Code";
    end;

    procedure GetCombinedDimensionSetID(DimensionSetIDArr: array[10] of Integer; var GlobalDimVal1: Code[20]; var GlobalDimVal2: Code[20]): Integer
    var
        TempDimSetEntry: Record 480 temporary;
        i: Integer;
    begin
        GetGLSetup;
        GlobalDimVal1 := '';
        GlobalDimVal2 := '';
        DimSetEntry.RESET;
        FOR i := 1 TO 10 DO
            IF DimensionSetIDArr[i] <> 0 THEN BEGIN
                DimSetEntry.SETRANGE("Dimension Set ID", DimensionSetIDArr[i]);
                IF DimSetEntry.FINDSET THEN
                    REPEAT
                        IF TempDimSetEntry.GET(0, DimSetEntry."Dimension Code") THEN
                            TempDimSetEntry.DELETE;
                        TempDimSetEntry := DimSetEntry;
                        TempDimSetEntry."Dimension Set ID" := 0;
                        TempDimSetEntry.INSERT;
                        IF GLSetupShortcutDimCode[1] = TempDimSetEntry."Dimension Code" THEN
                            GlobalDimVal1 := TempDimSetEntry."Dimension Value Code";
                        IF GLSetupShortcutDimCode[2] = TempDimSetEntry."Dimension Code" THEN
                            GlobalDimVal2 := TempDimSetEntry."Dimension Value Code";
                    UNTIL DimSetEntry.NEXT = 0;
            END;
        EXIT(GetDimensionSetID(TempDimSetEntry));
    end;

    procedure GetDeltaDimSetID(DimSetID: Integer; NewParentDimSetID: Integer; OldParentDimSetID: Integer): Integer
    var
        TempDimSetEntry: Record 480 temporary;
        TempDimSetEntryNew: Record 480 temporary;
        TempDimSetEntryDeleted: Record 480 temporary;
    begin
        // Returns an updated DimSetID based on parent's old and new DimSetID
        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT(DimSetID);
        GetDimensionSet(TempDimSetEntry, DimSetID);
        GetDimensionSet(TempDimSetEntryNew, NewParentDimSetID);
        GetDimensionSet(TempDimSetEntryDeleted, OldParentDimSetID);
        IF TempDimSetEntryDeleted.FINDSET THEN
            REPEAT
                IF TempDimSetEntryNew.GET(NewParentDimSetID, TempDimSetEntryDeleted."Dimension Code") THEN BEGIN
                    IF TempDimSetEntryNew."Dimension Value Code" = TempDimSetEntryDeleted."Dimension Value Code" THEN
                        TempDimSetEntryNew.DELETE;
                    TempDimSetEntryDeleted.DELETE;
                END;
            UNTIL TempDimSetEntryDeleted.NEXT = 0;

        IF TempDimSetEntryDeleted.FINDSET THEN
            REPEAT
                IF TempDimSetEntry.GET(DimSetID, TempDimSetEntryDeleted."Dimension Code") THEN
                    TempDimSetEntry.DELETE;
            UNTIL TempDimSetEntryDeleted.NEXT = 0;

        IF TempDimSetEntryNew.FINDSET THEN
            REPEAT
                IF TempDimSetEntry.GET(DimSetID, TempDimSetEntryNew."Dimension Code") THEN BEGIN
                    IF TempDimSetEntry."Dimension Value Code" <> TempDimSetEntryNew."Dimension Value Code" THEN BEGIN
                        TempDimSetEntry."Dimension Value Code" := TempDimSetEntryNew."Dimension Value Code";
                        TempDimSetEntry."Dimension Value ID" := TempDimSetEntryNew."Dimension Value ID";
                        TempDimSetEntry.MODIFY;
                    END;
                END ELSE BEGIN
                    TempDimSetEntry := TempDimSetEntryNew;
                    TempDimSetEntry."Dimension Set ID" := DimSetID;
                    TempDimSetEntry.INSERT;
                END;
            UNTIL TempDimSetEntryNew.NEXT = 0;

        EXIT(GetDimensionSetID(TempDimSetEntry));
    end;

    local procedure GetGLSetup()
    var
        GLSetup: Record 98;
    begin
        IF NOT HasGotGLSetup THEN BEGIN
            GLSetup.GET;
            GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
            GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
            GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
            GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
            GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
            GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
            GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
            HasGotGLSetup := TRUE;
        END;
    end;

    procedure CheckDimIDComb(DimSetID: Integer): Boolean
    begin
        TempDimBuf1.RESET;
        TempDimBuf1.DELETEALL;
        DimSetEntry.RESET;
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        IF DimSetEntry.FINDSET THEN
            REPEAT
                TempDimBuf1.INIT;
                TempDimBuf1."Table ID" := DATABASE::"Dimension Buffer";
                TempDimBuf1."Entry No." := 0;
                TempDimBuf1."Dimension Code" := DimSetEntry."Dimension Code";
                TempDimBuf1."Dimension Value Code" := DimSetEntry."Dimension Value Code";
                TempDimBuf1.INSERT;
            UNTIL DimSetEntry.NEXT = 0;

        DimSetEntry.RESET;
        EXIT(CheckDimComb);
    end;

    procedure CheckDimValuePosting(TableID: array[10] of Integer; No: array[10] of Code[20]; DimSetID: Integer): Boolean
    var
        i: Integer;
        j: Integer;
        NoFilter: array[2] of Text[250];
    begin
        IF NOT CheckBlockedDimAndValues(DimSetID) THEN
            EXIT(FALSE);
        DefaultDim.SETFILTER("Value Posting", '<>%1', DefaultDim."Value Posting"::" ");
        DimSetEntry.RESET;
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        NoFilter[2] := '';
        FOR i := 1 TO ARRAYLEN(TableID) DO BEGIN
            IF (TableID[i] <> 0) AND (No[i] <> '') THEN BEGIN
                DefaultDim.SETRANGE("Table ID", TableID[i]);
                NoFilter[1] := No[i];
                FOR j := 1 TO 2 DO BEGIN
                    DefaultDim.SETRANGE("No.", NoFilter[j]);
                    IF DefaultDim.FINDSET THEN
                        REPEAT
                            DimSetEntry.SETRANGE("Dimension Code", DefaultDim."Dimension Code");
                            CASE DefaultDim."Value Posting" OF
                                DefaultDim."Value Posting"::"Code Mandatory":
                                    BEGIN
                                        IF NOT DimSetEntry.FINDFIRST OR (DimSetEntry."Dimension Value Code" = '') THEN BEGIN
                                            IF DefaultDim."No." = '' THEN
                                                DimValuePostingErr :=
                                                  STRSUBSTNO(
                                                    Text004,
                                                    DefaultDim.FIELDCAPTION("Dimension Value Code"),
                                                    DefaultDim.FIELDCAPTION("Dimension Code"), DefaultDim."Dimension Code")
                                            ELSE
                                                DimValuePostingErr :=
                                                  STRSUBSTNO(
                                                    Text005,
                                                    DefaultDim.FIELDCAPTION("Dimension Value Code"),
                                                    DefaultDim.FIELDCAPTION("Dimension Code"),
                                                    DefaultDim."Dimension Code",
                                                    ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, DefaultDim."Table ID"),
                                                    DefaultDim."No.");
                                            EXIT(FALSE);
                                        END;
                                    END;
                                DefaultDim."Value Posting"::"Same Code":
                                    BEGIN
                                        IF DefaultDim."Dimension Value Code" <> '' THEN BEGIN
                                            IF NOT DimSetEntry.FINDFIRST OR
                                               (DefaultDim."Dimension Value Code" <> DimSetEntry."Dimension Value Code")
                                            THEN BEGIN
                                                IF DefaultDim."No." = '' THEN
                                                    DimValuePostingErr :=
                                                      STRSUBSTNO(
                                                        Text006,
                                                        DefaultDim.FIELDCAPTION("Dimension Value Code"), DefaultDim."Dimension Value Code",
                                                        DefaultDim.FIELDCAPTION("Dimension Code"), DefaultDim."Dimension Code")
                                                ELSE
                                                    DimValuePostingErr :=
                                                      STRSUBSTNO(
                                                        Text007,
                                                        DefaultDim.FIELDCAPTION("Dimension Value Code"),
                                                        DefaultDim."Dimension Value Code",
                                                        DefaultDim.FIELDCAPTION("Dimension Code"),
                                                        DefaultDim."Dimension Code",
                                                        ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, DefaultDim."Table ID"),
                                                        DefaultDim."No.");
                                                EXIT(FALSE);
                                            END;
                                        END ELSE BEGIN
                                            IF DimSetEntry.FINDFIRST THEN BEGIN
                                                IF DefaultDim."No." = '' THEN
                                                    DimValuePostingErr :=
                                                      STRSUBSTNO(
                                                        Text008,
                                                        DimSetEntry.FIELDCAPTION("Dimension Code"), DimSetEntry."Dimension Code")
                                                ELSE
                                                    DimValuePostingErr :=
                                                      STRSUBSTNO(
                                                        Text009,
                                                        DimSetEntry.FIELDCAPTION("Dimension Code"),
                                                        DimSetEntry."Dimension Code",
                                                        ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, DefaultDim."Table ID"),
                                                        DefaultDim."No.");
                                                EXIT(FALSE);
                                            END;
                                        END;
                                    END;
                                DefaultDim."Value Posting"::"No Code":
                                    BEGIN
                                        IF DimSetEntry.FINDFIRST THEN BEGIN
                                            IF DefaultDim."No." = '' THEN
                                                DimValuePostingErr :=
                                                  STRSUBSTNO(
                                                    Text010,
                                                    DimSetEntry.FIELDCAPTION("Dimension Code"), DimSetEntry."Dimension Code")
                                            ELSE
                                                DimValuePostingErr :=
                                                  STRSUBSTNO(
                                                    Text011,
                                                    DimSetEntry.FIELDCAPTION("Dimension Code"),
                                                    DimSetEntry."Dimension Code",
                                                    ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, DefaultDim."Table ID"),
                                                    DefaultDim."No.");
                                            EXIT(FALSE);
                                        END;
                                    END;
                            END;
                        UNTIL DefaultDim.NEXT = 0;
                END;
            END;
        END;
        DimSetEntry.RESET;
        EXIT(TRUE);
    end;

    procedure CheckDimBuffer(var DimBuffer: Record 360): Boolean
    var
        i: Integer;
    begin
        TempDimBuf1.RESET;
        TempDimBuf1.DELETEALL;
        IF DimBuffer.FINDSET THEN BEGIN
            i := 1;
            REPEAT
                TempDimBuf1.INIT;
                TempDimBuf1."Table ID" := DATABASE::"Dimension Buffer";
                TempDimBuf1."Entry No." := i;
                TempDimBuf1."Dimension Code" := DimBuffer."Dimension Code";
                TempDimBuf1."Dimension Value Code" := DimBuffer."Dimension Value Code";
                TempDimBuf1.INSERT;
                i := i + 1;
            UNTIL DimBuffer.NEXT = 0;
        END;
        EXIT(CheckDimComb);
    end;

    local procedure CheckDimComb(): Boolean
    var
        DimComb: Record 350;
        CurrentDimCode: Code[20];
        CurrentDimValCode: Code[20];
        DimFilter: Text[1024];
        FilterTooLong: Boolean;
    begin
        IF NOT TempDimCombInitialized THEN BEGIN
            TempDimCombInitialized := TRUE;
            IF DimComb.ISEMPTY THEN
                TempDimCombEmpty := TRUE;
        END;

        IF TempDimCombEmpty THEN
            EXIT(TRUE);

        IF NOT TempDimBuf1.FINDSET THEN
            EXIT(TRUE);

        REPEAT
            IF STRLEN(DimFilter) + 1 + STRLEN(TempDimBuf1."Dimension Code") > MAXSTRLEN(DimFilter) THEN
                FilterTooLong := TRUE
            ELSE
                IF DimFilter = '' THEN
                    DimFilter := TempDimBuf1."Dimension Code"
                ELSE
                    DimFilter := DimFilter + '|' + TempDimBuf1."Dimension Code";
        UNTIL FilterTooLong OR (TempDimBuf1.NEXT = 0);

        IF NOT FilterTooLong THEN BEGIN
            DimComb.SETFILTER("Dimension 1 Code", DimFilter);
            DimComb.SETFILTER("Dimension 2 Code", DimFilter);
            IF DimComb.FINDSET THEN
                REPEAT
                    IF DimComb."Combination Restriction" = DimComb."Combination Restriction"::Blocked THEN BEGIN
                        DimCombErr := STRSUBSTNO(Text000, DimComb."Dimension 1 Code", DimComb."Dimension 2 Code");
                        EXIT(FALSE);
                    END ELSE BEGIN
                        TempDimBuf1.SETRANGE("Dimension Code", DimComb."Dimension 1 Code");
                        TempDimBuf1.FINDFIRST;
                        CurrentDimCode := TempDimBuf1."Dimension Code";
                        CurrentDimValCode := TempDimBuf1."Dimension Value Code";
                        TempDimBuf1.SETRANGE("Dimension Code", DimComb."Dimension 2 Code");
                        TempDimBuf1.FINDFIRST;
                        IF NOT
                           CheckDimValueComb(
                             TempDimBuf1."Dimension Code", TempDimBuf1."Dimension Value Code",
                             CurrentDimCode, CurrentDimValCode)
                        THEN
                            EXIT(FALSE);
                        IF NOT
                           CheckDimValueComb(
                             CurrentDimCode, CurrentDimValCode,
                             TempDimBuf1."Dimension Code", TempDimBuf1."Dimension Value Code")
                        THEN
                            EXIT(FALSE);
                    END;
                UNTIL DimComb.NEXT = 0;
            EXIT(TRUE);
        END;

        WHILE TempDimBuf1.FINDFIRST DO BEGIN
            CurrentDimCode := TempDimBuf1."Dimension Code";
            CurrentDimValCode := TempDimBuf1."Dimension Value Code";
            TempDimBuf1.DELETE;
            IF TempDimBuf1.FINDSET THEN
                REPEAT
                    IF CurrentDimCode > TempDimBuf1."Dimension Code" THEN BEGIN
                        IF DimComb.GET(TempDimBuf1."Dimension Code", CurrentDimCode) THEN BEGIN
                            IF DimComb."Combination Restriction" = DimComb."Combination Restriction"::Blocked THEN BEGIN
                                DimCombErr :=
                                  STRSUBSTNO(
                                    Text000,
                                    TempDimBuf1."Dimension Code", CurrentDimCode);
                                EXIT(FALSE);
                            END;
                            IF NOT
                               CheckDimValueComb(
                                 TempDimBuf1."Dimension Code", TempDimBuf1."Dimension Value Code",
                                 CurrentDimCode, CurrentDimValCode)
                            THEN
                                EXIT(FALSE);
                        END;
                    END ELSE BEGIN
                        IF DimComb.GET(CurrentDimCode, TempDimBuf1."Dimension Code") THEN BEGIN
                            IF DimComb."Combination Restriction" = DimComb."Combination Restriction"::Blocked THEN BEGIN
                                DimCombErr :=
                                  STRSUBSTNO(
                                    Text000,
                                    CurrentDimCode, TempDimBuf1."Dimension Code");
                                EXIT(FALSE);
                            END;
                            IF NOT
                               CheckDimValueComb(
                                 CurrentDimCode, CurrentDimValCode, TempDimBuf1."Dimension Code",
                                 TempDimBuf1."Dimension Value Code")
                            THEN
                                EXIT(FALSE);
                        END;
                    END;
                UNTIL TempDimBuf1.NEXT = 0;
        END;
        EXIT(TRUE);
    end;

    local procedure CheckDimValueComb(Dim1: Code[20]; Dim1Value: Code[20]; Dim2: Code[20]; Dim2Value: Code[20]): Boolean
    begin
        IF DimValComb.GET(Dim1, Dim1Value, Dim2, Dim2Value) THEN BEGIN
            DimCombErr :=
              STRSUBSTNO(Text001,
                Dim1, Dim1Value, Dim2, Dim2Value);
            EXIT(FALSE);
        END;
        EXIT(TRUE);
    end;

    procedure GetDimCombErr(): Text[250]
    begin
        EXIT(DimCombErr);
    end;

    procedure UpdateDefaultDim(TableID: Integer; No: Code[20]; var GlobalDim1Code: Code[20]; var GlobalDim2Code: Code[20])
    var
        DefaultDim: Record 352;
    begin
        GetGLSetup;
        IF DefaultDim.GET(TableID, No, GLSetupShortcutDimCode[1]) THEN
            GlobalDim1Code := DefaultDim."Dimension Value Code"
        ELSE
            GlobalDim1Code := '';
        IF DefaultDim.GET(TableID, No, GLSetupShortcutDimCode[2]) THEN
            GlobalDim2Code := DefaultDim."Dimension Value Code"
        ELSE
            GlobalDim2Code := '';
    end;

    procedure GetDefaultDimID(TableID: array[10] of Integer; No: array[10] of Code[20]; SourceCode: Code[20]; var GlobalDim1Code: Code[20]; var GlobalDim2Code: Code[20]; InheritFromDimSetID: Integer; InheritFromTableNo: Integer): Integer
    var
        DimVal: Record 349;
        DefaultDimPriority1: Record 354;
        DefaultDimPriority2: Record 354;
        DefaultDim: Record 352;
        TempDimSetEntry: Record 480 temporary;
        TempDimSetEntry0: Record 480 temporary;
        i: Integer;
        j: Integer;
        NoFilter: array[2] of Code[20];
        NewDimSetID: Integer;
    begin
        GetGLSetup;
        IF InheritFromDimSetID > 0 THEN
            GetDimensionSet(TempDimSetEntry0, InheritFromDimSetID);
        TempDimBuf2.RESET;
        TempDimBuf2.DELETEALL;
        IF TempDimSetEntry0.FINDSET THEN
            REPEAT
                TempDimBuf2.INIT;
                TempDimBuf2."Table ID" := InheritFromTableNo;
                TempDimBuf2."Entry No." := 0;
                TempDimBuf2."Dimension Code" := TempDimSetEntry0."Dimension Code";
                TempDimBuf2."Dimension Value Code" := TempDimSetEntry0."Dimension Value Code";
                TempDimBuf2.INSERT;
            UNTIL TempDimSetEntry0.NEXT = 0;

        NoFilter[2] := '';
        FOR i := 1 TO ARRAYLEN(TableID) DO BEGIN
            IF (TableID[i] <> 0) AND (No[i] <> '') THEN BEGIN
                DefaultDim.SETRANGE("Table ID", TableID[i]);
                NoFilter[1] := No[i];
                FOR j := 1 TO 2 DO BEGIN
                    DefaultDim.SETRANGE("No.", NoFilter[j]);
                    IF DefaultDim.FINDSET THEN
                        REPEAT
                            IF DefaultDim."Dimension Value Code" <> '' THEN BEGIN
                                TempDimBuf2.SETRANGE("Dimension Code", DefaultDim."Dimension Code");
                                IF NOT TempDimBuf2.FINDFIRST THEN BEGIN
                                    TempDimBuf2.INIT;
                                    TempDimBuf2."Table ID" := DefaultDim."Table ID";
                                    TempDimBuf2."Entry No." := 0;
                                    TempDimBuf2."Dimension Code" := DefaultDim."Dimension Code";
                                    TempDimBuf2."Dimension Value Code" := DefaultDim."Dimension Value Code";
                                    TempDimBuf2.INSERT;
                                END ELSE BEGIN
                                    IF DefaultDimPriority1.GET(SourceCode, DefaultDim."Table ID") THEN BEGIN
                                        IF DefaultDimPriority2.GET(SourceCode, TempDimBuf2."Table ID") THEN BEGIN
                                            IF DefaultDimPriority1.Priority < DefaultDimPriority2.Priority THEN BEGIN
                                                TempDimBuf2.DELETE;
                                                TempDimBuf2."Table ID" := DefaultDim."Table ID";
                                                TempDimBuf2."Entry No." := 0;
                                                TempDimBuf2."Dimension Value Code" := DefaultDim."Dimension Value Code";
                                                TempDimBuf2.INSERT;
                                            END;
                                        END ELSE BEGIN
                                            TempDimBuf2.DELETE;
                                            TempDimBuf2."Table ID" := DefaultDim."Table ID";
                                            TempDimBuf2."Entry No." := 0;
                                            TempDimBuf2."Dimension Value Code" := DefaultDim."Dimension Value Code";
                                            TempDimBuf2.INSERT;
                                        END;
                                    END;
                                END;
                                IF GLSetupShortcutDimCode[1] = TempDimBuf2."Dimension Code" THEN
                                    GlobalDim1Code := TempDimBuf2."Dimension Value Code";
                                IF GLSetupShortcutDimCode[2] = TempDimBuf2."Dimension Code" THEN
                                    GlobalDim2Code := TempDimBuf2."Dimension Value Code";
                            END;
                        UNTIL DefaultDim.NEXT = 0;
                END;
            END;
        END;
        TempDimBuf2.RESET;
        IF TempDimBuf2.FINDSET THEN BEGIN
            REPEAT
                DimVal.GET(TempDimBuf2."Dimension Code", TempDimBuf2."Dimension Value Code");
                TempDimSetEntry."Dimension Code" := TempDimBuf2."Dimension Code";
                TempDimSetEntry."Dimension Value Code" := TempDimBuf2."Dimension Value Code";
                TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                TempDimSetEntry.INSERT;
            UNTIL TempDimBuf2.NEXT = 0;
            NewDimSetID := GetDimensionSetID(TempDimSetEntry);
        END;
        EXIT(NewDimSetID);
    end;

    procedure TypeToTableID1(Type: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"): Integer
    begin
        CASE Type OF
            Type::"G/L Account":
                EXIT(DATABASE::"G/L Account");
            Type::Customer:
                EXIT(DATABASE::Customer);
            Type::Vendor:
                EXIT(DATABASE::Vendor);
            Type::"Bank Account":
                EXIT(DATABASE::"Bank Account");
            Type::"Fixed Asset":
                EXIT(DATABASE::"Fixed Asset");
            Type::"IC Partner":
                EXIT(DATABASE::"IC Partner");
        END;
    end;

    procedure TypeToTableID2(Type: Option Resource,Item,"G/L Account"): Integer
    begin
        CASE Type OF
            Type::Resource:
                EXIT(DATABASE::Resource);
            Type::Item:
                EXIT(DATABASE::Item);
            Type::"G/L Account":
                EXIT(DATABASE::"G/L Account");
        END;
    end;

    procedure TypeToTableID3(Type: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)"): Integer
    begin
        CASE Type OF
            Type::" ":
                EXIT(0);
            Type::"G/L Account":
                EXIT(DATABASE::"G/L Account");
            Type::Item:
                EXIT(DATABASE::Item);
            Type::Resource:
                EXIT(DATABASE::Resource);
            Type::"Fixed Asset":
                EXIT(DATABASE::"Fixed Asset");
            Type::"Charge (Item)":
                EXIT(DATABASE::"Item Charge");
        END;
    end;

    procedure TypeToTableID4(Type: Option " ",Item,Resource): Integer
    begin
        CASE Type OF
            Type::" ":
                EXIT(0);
            Type::Item:
                EXIT(DATABASE::Item);
            Type::Resource:
                EXIT(DATABASE::Resource);
        END;
    end;

    procedure TypeToTableID5(Type: Option " ",Item,Resource,Cost,"G/L Account"): Integer
    begin
        CASE Type OF
            Type::" ":
                EXIT(0);
            Type::Item:
                EXIT(DATABASE::Item);
            Type::Resource:
                EXIT(DATABASE::Resource);
            Type::Cost:
                EXIT(DATABASE::"Service Cost");
            Type::"G/L Account":
                EXIT(DATABASE::"G/L Account");
        END;
    end;

    procedure DeleteDefaultDim(TableID: Integer; No: Code[20])
    var
        DefaultDim: Record 352;
    begin
        DefaultDim.SETRANGE("Table ID", TableID);
        DefaultDim.SETRANGE("No.", No);
        IF NOT DefaultDim.ISEMPTY THEN
            DefaultDim.DELETEALL;
    end;

    procedure LookupDimValueCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimVal: Record 349;
        GLSetup: Record 98;
    begin
        GetGLSetup;
        IF GLSetupShortcutDimCode[FieldNumber] = '' THEN
            ERROR(Text002, GLSetup.TABLECAPTION);
        DimVal.SETRANGE("Dimension Code", GLSetupShortcutDimCode[FieldNumber]);
        DimVal."Dimension Code" := GLSetupShortcutDimCode[FieldNumber];
        DimVal.Code := ShortcutDimCode;
        IF PAGE.RUNMODAL(0, DimVal) = ACTION::LookupOK THEN BEGIN
            CheckDim(DimVal."Dimension Code");
            CheckDimValue(DimVal."Dimension Code", DimVal.Code);
            ShortcutDimCode := DimVal.Code;
        END;
    end;

    procedure ValidateDimValueCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimVal: Record 349;
        GLSetup: Record 98;
    begin
        GetGLSetup;
        IF (GLSetupShortcutDimCode[FieldNumber] = '') AND (ShortcutDimCode <> '') THEN
            ERROR(Text002, GLSetup.TABLECAPTION);
        DimVal.SETRANGE("Dimension Code", GLSetupShortcutDimCode[FieldNumber]);
        IF ShortcutDimCode <> '' THEN BEGIN
            DimVal.SETRANGE(Code, ShortcutDimCode);
            IF NOT DimVal.FINDFIRST THEN BEGIN
                DimVal.SETFILTER(Code, STRSUBSTNO('%1*', ShortcutDimCode));
                IF DimVal.FINDFIRST THEN
                    ShortcutDimCode := DimVal.Code
                ELSE
                    ERROR(
                      STRSUBSTNO(Text003,
                        ShortcutDimCode, DimVal.FIELDCAPTION(Code)));
            END;
        END;
    end;

    procedure ValidateShortcutDimValues(FieldNumber: Integer; var ShortcutDimCode: Code[20]; var DimSetID: Integer)
    var
        DimVal: Record 349;
        TempDimSetEntry: Record 480 temporary;
    begin
        ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimVal."Dimension Code" := GLSetupShortcutDimCode[FieldNumber];
        IF ShortcutDimCode <> '' THEN BEGIN
            DimVal.GET(DimVal."Dimension Code", ShortcutDimCode);
            IF NOT CheckDim(DimVal."Dimension Code") THEN
                ERROR(GetDimErr);
            IF NOT CheckDimValue(DimVal."Dimension Code", ShortcutDimCode) THEN
                ERROR(GetDimErr);
        END;
        GetDimensionSet(TempDimSetEntry, DimSetID);
        IF TempDimSetEntry.GET(TempDimSetEntry."Dimension Set ID", DimVal."Dimension Code") THEN
            IF TempDimSetEntry."Dimension Value Code" <> ShortcutDimCode THEN
                TempDimSetEntry.DELETE;
        IF ShortcutDimCode <> '' THEN BEGIN
            TempDimSetEntry."Dimension Code" := DimVal."Dimension Code";
            TempDimSetEntry."Dimension Value Code" := DimVal.Code;
            TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            IF TempDimSetEntry.INSERT THEN;
        END;
        DimSetID := GetDimensionSetID(TempDimSetEntry);
    end;

    procedure SaveDefaultDim(TableID: Integer; No: Code[20]; FieldNumber: Integer; ShortcutDimCode: Code[20])
    var
        DefaultDim: Record 352;
    begin
        GetGLSetup;
        IF ShortcutDimCode <> '' THEN BEGIN
            IF DefaultDim.GET(TableID, No, GLSetupShortcutDimCode[FieldNumber])
            THEN BEGIN
                DefaultDim.VALIDATE("Dimension Value Code", ShortcutDimCode);
                DefaultDim.MODIFY;
            END ELSE BEGIN
                DefaultDim.INIT;
                DefaultDim.VALIDATE("Table ID", TableID);
                DefaultDim.VALIDATE("No.", No);
                DefaultDim.VALIDATE("Dimension Code", GLSetupShortcutDimCode[FieldNumber]);
                DefaultDim.VALIDATE("Dimension Value Code", ShortcutDimCode);
                DefaultDim.INSERT;
            END;
        END ELSE
            IF DefaultDim.GET(TableID, No, GLSetupShortcutDimCode[FieldNumber]) THEN
                DefaultDim.DELETE;
    end;

    procedure GetShortcutDimensions(DimSetID: Integer; var ShortcutDimCode: array[8] of Code[20])
    var
        i: Integer;
    begin
        GetGLSetup;
        FOR i := 3 TO 8 DO BEGIN
            ShortcutDimCode[i] := '';
            IF GLSetupShortcutDimCode[i] <> '' THEN
                IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[i]) THEN
                    ShortcutDimCode[i] := DimSetEntry."Dimension Value Code";
        END;
    end;

    procedure CheckDimBufferValuePosting(var DimBuffer: Record 360; TableID: array[10] of Integer; No: array[10] of Code[20]): Boolean
    var
        i: Integer;
    begin
        TempDimBuf2.RESET;
        TempDimBuf2.DELETEALL;
        IF DimBuffer.FINDSET THEN BEGIN
            i := 1;
            REPEAT
                IF (NOT CheckDimValue(
                      DimBuffer."Dimension Code", DimBuffer."Dimension Value Code")) OR
                   (NOT CheckDim(DimBuffer."Dimension Code"))
                THEN BEGIN
                    DimValuePostingErr := DimErr;
                    EXIT(FALSE);
                END;
                TempDimBuf2.INIT;
                TempDimBuf2."Entry No." := i;
                TempDimBuf2."Dimension Code" := DimBuffer."Dimension Code";
                TempDimBuf2."Dimension Value Code" := DimBuffer."Dimension Value Code";
                TempDimBuf2.INSERT;
                i := i + 1;
            UNTIL DimBuffer.NEXT = 0;
        END;
        EXIT(CheckValuePosting(TableID, No));
    end;

    local procedure CheckValuePosting(TableID: array[10] of Integer; No: array[10] of Code[20]): Boolean
    var
        DefaultDim: Record 352;
        i: Integer;
        j: Integer;
        NoFilter: array[2] of Text[250];
    begin
        DefaultDim.SETFILTER("Value Posting", '<>%1', DefaultDim."Value Posting"::" ");
        NoFilter[2] := '';
        FOR i := 1 TO ARRAYLEN(TableID) DO BEGIN
            IF (TableID[i] <> 0) AND (No[i] <> '') THEN BEGIN
                DefaultDim.SETRANGE("Table ID", TableID[i]);
                NoFilter[1] := No[i];
                FOR j := 1 TO 2 DO BEGIN
                    DefaultDim.SETRANGE("No.", NoFilter[j]);
                    IF DefaultDim.FINDSET THEN BEGIN
                        REPEAT
                            TempDimBuf2.SETRANGE("Dimension Code", DefaultDim."Dimension Code");
                            CASE DefaultDim."Value Posting" OF
                                DefaultDim."Value Posting"::"Code Mandatory":
                                    BEGIN
                                        IF (NOT TempDimBuf2.FINDFIRST) OR
                                           (TempDimBuf2."Dimension Value Code" = '')
                                        THEN BEGIN
                                            IF DefaultDim."No." = '' THEN
                                                DimValuePostingErr :=
                                                  STRSUBSTNO(
                                                    Text004,
                                                    DefaultDim.FIELDCAPTION("Dimension Value Code"),
                                                    DefaultDim.FIELDCAPTION("Dimension Code"), DefaultDim."Dimension Code")
                                            ELSE
                                                DimValuePostingErr :=
                                                  STRSUBSTNO(
                                                    Text005,
                                                    DefaultDim.FIELDCAPTION("Dimension Value Code"),
                                                    DefaultDim.FIELDCAPTION("Dimension Code"),
                                                    DefaultDim."Dimension Code",
                                                    ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, DefaultDim."Table ID"),
                                                    DefaultDim."No.");
                                            EXIT(FALSE);
                                        END;
                                    END;
                                DefaultDim."Value Posting"::"Same Code":
                                    BEGIN
                                        IF DefaultDim."Dimension Value Code" <> '' THEN BEGIN
                                            IF (NOT TempDimBuf2.FINDFIRST) OR
                                               (DefaultDim."Dimension Value Code" <> TempDimBuf2."Dimension Value Code")
                                            THEN BEGIN
                                                IF DefaultDim."No." = '' THEN
                                                    DimValuePostingErr :=
                                                      STRSUBSTNO(
                                                        Text006,
                                                        DefaultDim.FIELDCAPTION("Dimension Value Code"), DefaultDim."Dimension Value Code",
                                                        DefaultDim.FIELDCAPTION("Dimension Code"), DefaultDim."Dimension Code")
                                                ELSE
                                                    DimValuePostingErr :=
                                                      STRSUBSTNO(
                                                        Text007,
                                                        DefaultDim.FIELDCAPTION("Dimension Value Code"),
                                                        DefaultDim."Dimension Value Code",
                                                        DefaultDim.FIELDCAPTION("Dimension Code"),
                                                        DefaultDim."Dimension Code",
                                                        ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, DefaultDim."Table ID"),
                                                        DefaultDim."No.");
                                                EXIT(FALSE);
                                            END;
                                        END ELSE BEGIN
                                            IF TempDimBuf2.FINDFIRST THEN BEGIN
                                                IF DefaultDim."No." = '' THEN
                                                    DimValuePostingErr :=
                                                      STRSUBSTNO(
                                                        Text008,
                                                        TempDimBuf2.FIELDCAPTION("Dimension Code"), TempDimBuf2."Dimension Code")
                                                ELSE
                                                    DimValuePostingErr :=
                                                      STRSUBSTNO(
                                                        Text009,
                                                        TempDimBuf2.FIELDCAPTION("Dimension Code"),
                                                        TempDimBuf2."Dimension Code",
                                                        ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, DefaultDim."Table ID"),
                                                        DefaultDim."No.");
                                                EXIT(FALSE);
                                            END;
                                        END;
                                    END;
                                DefaultDim."Value Posting"::"No Code":
                                    BEGIN
                                        IF TempDimBuf2.FINDFIRST THEN BEGIN
                                            IF DefaultDim."No." = '' THEN
                                                DimValuePostingErr :=
                                                  STRSUBSTNO(
                                                    Text010,
                                                    TempDimBuf2.FIELDCAPTION("Dimension Code"), TempDimBuf2."Dimension Code")
                                            ELSE
                                                DimValuePostingErr :=
                                                  STRSUBSTNO(
                                                    Text011,
                                                    TempDimBuf2.FIELDCAPTION("Dimension Code"),
                                                    TempDimBuf2."Dimension Code",
                                                    ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, DefaultDim."Table ID"),
                                                    DefaultDim."No.");
                                            EXIT(FALSE);
                                        END;
                                    END;
                            END;
                        UNTIL DefaultDim.NEXT = 0;
                        TempDimBuf2.RESET;
                    END;
                END;
            END;
        END;
        EXIT(TRUE);
    end;

    procedure GetDimValuePostingErr(): Text[250]
    begin
        EXIT(DimValuePostingErr);
    end;

    procedure SetupObjectNoList(var TempAllObjWithCaption: Record 2000000058 temporary)
    begin
        InsertObject(TempAllObjWithCaption, DATABASE::"Salesperson/Purchaser");
        InsertObject(TempAllObjWithCaption, DATABASE::"G/L Account");
        InsertObject(TempAllObjWithCaption, DATABASE::Customer);
        InsertObject(TempAllObjWithCaption, DATABASE::Vendor);
        InsertObject(TempAllObjWithCaption, DATABASE::Item);
        InsertObject(TempAllObjWithCaption, DATABASE::"Resource Group");
        InsertObject(TempAllObjWithCaption, DATABASE::Resource);
        InsertObject(TempAllObjWithCaption, DATABASE::Job);
        InsertObject(TempAllObjWithCaption, DATABASE::"Bank Account");
        InsertObject(TempAllObjWithCaption, DATABASE::Campaign);
        InsertObject(TempAllObjWithCaption, DATABASE::Employee);
        InsertObject(TempAllObjWithCaption, DATABASE::"Fixed Asset");
        InsertObject(TempAllObjWithCaption, DATABASE::Insurance);
        InsertObject(TempAllObjWithCaption, DATABASE::"Responsibility Center");
        InsertObject(TempAllObjWithCaption, DATABASE::"Item Charge");
        InsertObject(TempAllObjWithCaption, DATABASE::"Work Center");
        InsertObject(TempAllObjWithCaption, DATABASE::"Service Contract Header");
        InsertObject(TempAllObjWithCaption, DATABASE::"Customer Templ.");
        InsertObject(TempAllObjWithCaption, DATABASE::"Service Contract Template");
        InsertObject(TempAllObjWithCaption, DATABASE::"IC Partner");
        InsertObject(TempAllObjWithCaption, DATABASE::"Service Order Type");
        InsertObject(TempAllObjWithCaption, DATABASE::"Service Item Group");
        InsertObject(TempAllObjWithCaption, DATABASE::"Service Item");
        InsertObject(TempAllObjWithCaption, DATABASE::"Cash Flow Manual Expense");
        InsertObject(TempAllObjWithCaption, DATABASE::"Cash Flow Manual Revenue");
        OnAfterSetupObjectNoList(TempAllObjWithCaption);
    end;

    procedure GetDocDimConsistencyErr(): Text[250]
    begin
        EXIT(DocDimConsistencyErr);
    end;

    procedure CheckDim(DimCode: Code[20]): Boolean
    var
        Dim: Record 348;
    begin
        IF Dim.GET(DimCode) THEN BEGIN
            IF Dim.Blocked THEN BEGIN
                DimErr :=
                  STRSUBSTNO(Text014, Dim.TABLECAPTION, DimCode);
                EXIT(FALSE);
            END;
        END ELSE BEGIN
            DimErr :=
              STRSUBSTNO(Text015, Dim.TABLECAPTION, DimCode);
            EXIT(FALSE);
        END;
        EXIT(TRUE);
    end;

    procedure CheckDimValue(DimCode: Code[20]; DimValCode: Code[20]): Boolean
    var
        DimVal: Record 349;
    begin
        IF (DimCode <> '') AND (DimValCode <> '') THEN BEGIN
            IF DimVal.GET(DimCode, DimValCode) THEN BEGIN
                IF DimVal.Blocked THEN BEGIN
                    DimErr :=
                      STRSUBSTNO(
                        Text016, DimVal.TABLECAPTION, DimCode, DimValCode);
                    EXIT(FALSE);
                END;
                IF NOT (DimVal."Dimension Value Type" IN
                        [DimVal."Dimension Value Type"::Standard,
                         DimVal."Dimension Value Type"::"Begin-Total"])
                THEN BEGIN
                    DimErr :=
                      STRSUBSTNO(Text017, DimVal.FIELDCAPTION("Dimension Value Type"),
                        DimVal.TABLECAPTION, DimCode, DimValCode, FORMAT(DimVal."Dimension Value Type"));
                    EXIT(FALSE);
                END;
            END ELSE BEGIN
                DimErr :=
                  STRSUBSTNO(
                    Text018, DimVal.TABLECAPTION, DimCode);
                EXIT(FALSE);
            END;
        END;
        EXIT(TRUE);
    end;

    local procedure CheckBlockedDimAndValues(DimSetID: Integer): Boolean
    var
        DimSetEntry: Record 480;
    begin
        IF DimSetID = 0 THEN
            EXIT(TRUE);
        DimSetEntry.RESET;
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        IF DimSetEntry.FINDSET THEN
            REPEAT
                IF NOT CheckDim(DimSetEntry."Dimension Code") OR
                   NOT CheckDimValue(DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code")
                THEN BEGIN
                    DimValuePostingErr := DimErr;
                    EXIT(FALSE);
                END;
            UNTIL DimSetEntry.NEXT = 0;
        EXIT(TRUE);
    end;

    procedure GetDimErr(): Text[250]
    begin
        EXIT(DimErr);
    end;

    procedure LookupDimValueCodeNoUpdate(FieldNumber: Integer)
    var
        DimVal: Record 349;
        GLSetup: Record 98;
    begin
        GetGLSetup;
        IF GLSetupShortcutDimCode[FieldNumber] = '' THEN
            ERROR(Text002, GLSetup.TABLECAPTION);
        DimVal.SETRANGE("Dimension Code", GLSetupShortcutDimCode[FieldNumber]);
        IF PAGE.RUNMODAL(0, DimVal) = ACTION::LookupOK THEN;
    end;

    procedure CopyJnlLineDimToICJnlDim(TableID: Integer; TransactionNo: Integer; PartnerCode: Code[20]; TransactionSource: Option; LineNo: Integer; DimSetID: Integer)
    var
        InOutBoxJnlLineDim: Record 423;

        DimSetEntry: Record 480;
        ICDim: Code[20];
        ICDimValue: Code[20];
    begin
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        IF DimSetEntry.FINDSET THEN
            REPEAT
                ICDim := ConvertDimtoICDim(DimSetEntry."Dimension Code");
                ICDimValue := ConvertDimValuetoICDimVal(DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
                IF (ICDim <> '') AND (ICDimValue <> '') THEN BEGIN
                    InOutBoxJnlLineDim.INIT;
                    InOutBoxJnlLineDim."Table ID" := TableID;
                    InOutBoxJnlLineDim."IC Partner Code" := PartnerCode;
                    InOutBoxJnlLineDim."Transaction No." := TransactionNo;
                    InOutBoxJnlLineDim."Transaction Source" := TransactionSource;
                    InOutBoxJnlLineDim."Line No." := LineNo;
                    InOutBoxJnlLineDim."Dimension Code" := ICDim;
                    InOutBoxJnlLineDim."Dimension Value Code" := ICDimValue;
                    InOutBoxJnlLineDim.INSERT;
                END;
            UNTIL DimSetEntry.NEXT = 0;
    end;

    procedure DefaultDimOnInsert(DefaultDimension: Record 352)
    var
        CallingTrigger: Option OnInsert,OnModify,OnDelete;
    begin
        IF DefaultDimension."Table ID" = DATABASE::Job THEN
            UpdateJobTaskDim(DefaultDimension, FALSE);

        UpdateCostType(DefaultDimension, CallingTrigger::OnInsert);
    end;

    procedure DefaultDimOnModify(DefaultDimension: Record 352)
    var
        CallingTrigger: Option OnInsert,OnModify,OnDelete;
    begin
        IF DefaultDimension."Table ID" = DATABASE::Job THEN
            UpdateJobTaskDim(DefaultDimension, FALSE);

        UpdateCostType(DefaultDimension, CallingTrigger::OnModify);
    end;

    procedure DefaultDimOnDelete(DefaultDimension: Record 352)
    var
        CallingTrigger: Option OnInsert,OnModify,OnDelete;
    begin
        IF DefaultDimension."Table ID" = DATABASE::Job THEN
            UpdateJobTaskDim(DefaultDimension, TRUE);

        UpdateCostType(DefaultDimension, CallingTrigger::OnDelete);
    end;

    procedure CopyICJnlDimToICJnlDim(var FromInOutBoxLineDim: Record 423
    ; var ToInOutBoxlineDim: Record 423
    )
    begin
        IF FromInOutBoxLineDim.FINDSET THEN
            REPEAT
                ToInOutBoxlineDim := FromInOutBoxLineDim;
                ToInOutBoxlineDim.INSERT;
            UNTIL FromInOutBoxLineDim.NEXT = 0;
    end;

    procedure CopyDocDimtoICDocDim(TableID: Integer; TransactionNo: Integer; PartnerCode: Code[20]; TransactionSource: Option; LineNo: Integer; DimSetEntryID: Integer)
    var
        InOutBoxDocDim: Record 442;
        DimSetEntry: Record 480;
        ICDim: Code[20];
        ICDimValue: Code[20];
    begin
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetEntryID);
        IF DimSetEntry.FINDSET THEN
            REPEAT
                ICDim := ConvertDimtoICDim(DimSetEntry."Dimension Code");
                ICDimValue := ConvertDimValuetoICDimVal(DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
                IF (ICDim <> '') AND (ICDimValue <> '') THEN BEGIN
                    InOutBoxDocDim.INIT;
                    InOutBoxDocDim."Table ID" := TableID;
                    InOutBoxDocDim."IC Partner Code" := PartnerCode;
                    InOutBoxDocDim."Transaction No." := TransactionNo;
                    InOutBoxDocDim."Transaction Source" := TransactionSource;
                    InOutBoxDocDim."Line No." := LineNo;
                    InOutBoxDocDim."Dimension Code" := ICDim;
                    InOutBoxDocDim."Dimension Value Code" := ICDimValue;
                    InOutBoxDocDim.INSERT;
                END;
            UNTIL DimSetEntry.NEXT = 0;
    end;

    procedure CopyICDocDimtoICDocDim(FromSourceICDocDim: Record 442; var ToSourceICDocDim: Record 442; ToTableID: Integer; ToTransactionSource: Integer)
    begin
        SetICDocDimFilters(FromSourceICDocDim, FromSourceICDocDim."Table ID", FromSourceICDocDim."Transaction No.", FromSourceICDocDim."IC Partner Code", FromSourceICDocDim."Transaction Source", FromSourceICDocDim."Line No.");
        IF FromSourceICDocDim.FINDSET THEN
            REPEAT
                ToSourceICDocDim := FromSourceICDocDim;
                ToSourceICDocDim."Table ID" := ToTableID;
                ToSourceICDocDim."Transaction Source" := ToTransactionSource;
                ToSourceICDocDim.INSERT;
            UNTIL FromSourceICDocDim.NEXT = 0;
    end;

    procedure MoveICDocDimtoICDocDim(FromSourceICDocDim: Record 442; var ToSourceICDocDim: Record 442; ToTableID: Integer; ToTransactionSource: Integer)
    begin
        SetICDocDimFilters(FromSourceICDocDim, FromSourceICDocDim."Table ID", FromSourceICDocDim."Transaction No.", FromSourceICDocDim."IC Partner Code", FromSourceICDocDim."Transaction Source", FromSourceICDocDim."Line No.");
        IF FromSourceICDocDim.FINDSET THEN
            REPEAT
                ToSourceICDocDim := FromSourceICDocDim;
                ToSourceICDocDim."Table ID" := ToTableID;
                ToSourceICDocDim."Transaction Source" := ToTransactionSource;
                ToSourceICDocDim.INSERT;
                FromSourceICDocDim.DELETE;
            UNTIL FromSourceICDocDim.NEXT = 0;
    end;

    procedure SetICDocDimFilters(var ICDocDim: Record 442; TableID: Integer; TransactionNo: Integer; PartnerCode: Code[20]; TransactionSource: Integer; LineNo: Integer)
    begin
        ICDocDim.RESET;
        ICDocDim.SETRANGE("Table ID", TableID);
        ICDocDim.SETRANGE("Transaction No.", TransactionNo);
        ICDocDim.SETRANGE("IC Partner Code", PartnerCode);
        ICDocDim.SETRANGE("Transaction Source", TransactionSource);
        ICDocDim.SETRANGE("Line No.", LineNo);
    end;

    procedure DeleteICDocDim(TableID: Integer; ICTransactionNo: Integer; ICPartnerCode: Code[20]; TransactionSource: Option; LineNo: Integer)
    var
        ICDocDim: Record 442;
    begin
        SetICDocDimFilters(ICDocDim, TableID, ICTransactionNo, ICPartnerCode, TransactionSource, LineNo);
        IF NOT ICDocDim.ISEMPTY THEN
            ICDocDim.DELETEALL;
    end;

    procedure DeleteICJnlDim(TableID: Integer; ICTransactionNo: Integer; ICPartnerCode: Code[20]; TransactionSource: Option; LineNo: Integer)
    var
        ICJnlDim: Record 423
        ;
    begin
        ICJnlDim.SETRANGE("Table ID", TableID);
        ICJnlDim.SETRANGE("Transaction No.", ICTransactionNo);
        ICJnlDim.SETRANGE("IC Partner Code", ICPartnerCode);
        ICJnlDim.SETRANGE("Transaction Source", TransactionSource);
        ICJnlDim.SETRANGE("Line No.", LineNo);
        IF NOT ICJnlDim.ISEMPTY THEN
            ICJnlDim.DELETEALL;
    end;

    local procedure ConvertICDimtoDim(FromICDim: Code[20]) DimCode: Code[20]
    var
        ICDim: Record 411;
    begin
        IF ICDim.GET(FromICDim) THEN
            DimCode := ICDim."Map-to Dimension Code";
    end;

    local procedure ConvertICDimValuetoDimValue(FromICDim: Code[20]; FromICDimValue: Code[20]) DimValueCode: Code[20]
    var
        ICDimValue: Record 412;
    begin
        IF ICDimValue.GET(FromICDim, FromICDimValue) THEN
            DimValueCode := ICDimValue."Map-to Dimension Value Code";
    end;

    procedure ConvertDimtoICDim(FromDim: Code[20]) ICDimCode: Code[20]
    var
        Dim: Record 348;
    begin
        IF Dim.GET(FromDim) THEN
            ICDimCode := Dim."Map-to IC Dimension Code";
    end;

    procedure ConvertDimValuetoICDimVal(FromDim: Code[20]; FromDimValue: Code[20]) ICDimValueCode: Code[20]
    var
        DimValue: Record 349;
    begin
        IF DimValue.GET(FromDim, FromDimValue) THEN
            ICDimValueCode := DimValue."Map-to IC Dimension Value Code";
    end;

    procedure CheckICDimValue(ICDimCode: Code[20]; ICDimValCode: Code[20]): Boolean
    var
        ICDimVal: Record 412;
    begin
        IF (ICDimCode <> '') AND (ICDimValCode <> '') THEN BEGIN
            IF ICDimVal.GET(ICDimCode, ICDimValCode) THEN BEGIN
                IF ICDimVal.Blocked THEN BEGIN
                    DimErr :=
                      STRSUBSTNO(
                        Text016, ICDimVal.TABLECAPTION, ICDimCode, ICDimValCode);
                    EXIT(FALSE);
                END;
                IF NOT (ICDimVal."Dimension Value Type" IN
                        [ICDimVal."Dimension Value Type"::Standard,
                         ICDimVal."Dimension Value Type"::"Begin-Total"])
                THEN BEGIN
                    DimErr :=
                      STRSUBSTNO(Text017, ICDimVal.FIELDCAPTION("Dimension Value Type"),
                        ICDimVal.TABLECAPTION, ICDimCode, ICDimValCode, FORMAT(ICDimVal."Dimension Value Type"));
                    EXIT(FALSE);
                END;
            END ELSE BEGIN
                DimErr :=
                  STRSUBSTNO(
                    Text018, ICDimVal.TABLECAPTION, ICDimCode);
                EXIT(FALSE);
            END;
        END;
        EXIT(TRUE);
    end;

    procedure CheckICDim(ICDimCode: Code[20]): Boolean
    var
        ICDim: Record 411;
    begin
        IF ICDim.GET(ICDimCode) THEN BEGIN
            IF ICDim.Blocked THEN BEGIN
                DimErr :=
                  STRSUBSTNO(Text014, ICDim.TABLECAPTION, ICDimCode);
                EXIT(FALSE);
            END;
        END ELSE BEGIN
            DimErr :=
              STRSUBSTNO(Text015, ICDim.TABLECAPTION, ICDimCode);
            EXIT(FALSE);
        END;
        EXIT(TRUE);
    end;

    procedure SaveJobTaskDim(JobNo: Code[20]; JobTaskNo: Code[20]; FieldNumber: Integer; ShortcutDimCode: Code[20])
    var
        JobTaskDim: Record 1002;
    begin
        GetGLSetup;
        IF ShortcutDimCode <> '' THEN BEGIN
            IF JobTaskDim.GET(JobNo, JobTaskNo, GLSetupShortcutDimCode[FieldNumber])
            THEN BEGIN
                JobTaskDim.VALIDATE("Dimension Value Code", ShortcutDimCode);
                JobTaskDim.MODIFY;
            END ELSE BEGIN
                JobTaskDim.INIT;
                JobTaskDim.VALIDATE("Job No.", JobNo);
                JobTaskDim.VALIDATE("Job Task No.", JobTaskNo);
                JobTaskDim.VALIDATE("Dimension Code", GLSetupShortcutDimCode[FieldNumber]);
                JobTaskDim.VALIDATE("Dimension Value Code", ShortcutDimCode);
                JobTaskDim.INSERT;
            END;
        END ELSE
            IF JobTaskDim.GET(JobNo, JobTaskNo, GLSetupShortcutDimCode[FieldNumber]) THEN
                JobTaskDim.DELETE;
    end;

    procedure SaveJobTaskTempDim(FieldNumber: Integer; ShortcutDimCode: Code[20])
    begin
        GetGLSetup;
        IF ShortcutDimCode <> '' THEN BEGIN
            IF JobTaskDimTemp.GET('', '', GLSetupShortcutDimCode[FieldNumber])
            THEN BEGIN
                JobTaskDimTemp."Dimension Value Code" := ShortcutDimCode;
                JobTaskDimTemp.MODIFY;
            END ELSE BEGIN
                JobTaskDimTemp.INIT;
                JobTaskDimTemp."Dimension Code" := GLSetupShortcutDimCode[FieldNumber];
                JobTaskDimTemp."Dimension Value Code" := ShortcutDimCode;
                JobTaskDimTemp.INSERT;
            END;
        END ELSE
            IF JobTaskDimTemp.GET('', '', GLSetupShortcutDimCode[FieldNumber]) THEN
                JobTaskDimTemp.DELETE;
    end;

    procedure InsertJobTaskDim(JobNo: Code[20]; JobTaskNo: Code[20]; var GlobalDim1Code: Code[20]; var GlobalDim2Code: Code[20])
    var
        DefaultDim: Record 352;
        JobTaskDim: Record 1002;
    begin
        GetGLSetup;
        DefaultDim.SETRANGE("Table ID", DATABASE::Job);
        DefaultDim.SETRANGE("No.", JobNo);
        IF DefaultDim.FINDSET(FALSE, FALSE) THEN
            REPEAT
                IF DefaultDim."Dimension Value Code" <> '' THEN BEGIN
                    JobTaskDim.INIT;
                    JobTaskDim."Job No." := JobNo;
                    JobTaskDim."Job Task No." := JobTaskNo;
                    JobTaskDim."Dimension Code" := DefaultDim."Dimension Code";
                    JobTaskDim."Dimension Value Code" := DefaultDim."Dimension Value Code";
                    JobTaskDim.INSERT;
                    IF JobTaskDim."Dimension Code" = GLSetupShortcutDimCode[1] THEN
                        GlobalDim1Code := JobTaskDim."Dimension Value Code";
                    IF JobTaskDim."Dimension Code" = GLSetupShortcutDimCode[2] THEN
                        GlobalDim2Code := JobTaskDim."Dimension Value Code";
                END;
            UNTIL DefaultDim.NEXT = 0;

        JobTaskDimTemp.RESET;
        IF JobTaskDimTemp.FINDSET THEN
            REPEAT
                IF NOT JobTaskDim.GET(JobNo, JobTaskNo, JobTaskDimTemp."Dimension Code") THEN BEGIN
                    JobTaskDim.INIT;
                    JobTaskDim."Job No." := JobNo;
                    JobTaskDim."Job Task No." := JobTaskNo;
                    JobTaskDim."Dimension Code" := JobTaskDimTemp."Dimension Code";
                    JobTaskDim."Dimension Value Code" := JobTaskDimTemp."Dimension Value Code";
                    JobTaskDim.INSERT;
                    IF JobTaskDim."Dimension Code" = GLSetupShortcutDimCode[1] THEN
                        GlobalDim1Code := JobTaskDim."Dimension Value Code";
                    IF JobTaskDim."Dimension Code" = GLSetupShortcutDimCode[2] THEN
                        GlobalDim2Code := JobTaskDim."Dimension Value Code";
                END;
            UNTIL JobTaskDimTemp.NEXT = 0;
        JobTaskDimTemp.DELETEALL;
    end;

    local procedure UpdateJobTaskDim(DefaultDimension: Record 352; FromOnDelete: Boolean)
    var
        JobTaskDimension: Record 1002;
        JobTask: Record 1001;
    begin
        IF DefaultDimension."Table ID" <> DATABASE::Job THEN
            EXIT;

        JobTask.SETRANGE("Job No.", DefaultDimension."No.");
        IF JobTask.ISEMPTY THEN
            EXIT;

        IF NOT CONFIRM(Text019, TRUE) THEN
            EXIT;

        JobTaskDimension.SETRANGE("Job No.", DefaultDimension."No.");
        JobTaskDimension.SETRANGE("Dimension Code", DefaultDimension."Dimension Code");
        JobTaskDimension.DELETEALL(TRUE);

        IF FromOnDelete OR
           (DefaultDimension."Value Posting" = DefaultDimension."Value Posting"::"No Code") OR
           (DefaultDimension."Dimension Value Code" = '')
        THEN
            EXIT;

        IF JobTask.FINDSET THEN
            REPEAT
                CLEAR(JobTaskDimension);
                JobTaskDimension."Job No." := JobTask."Job No.";
                JobTaskDimension."Job Task No." := JobTask."Job Task No.";
                JobTaskDimension."Dimension Code" := DefaultDimension."Dimension Code";
                JobTaskDimension."Dimension Value Code" := DefaultDimension."Dimension Value Code";
                JobTaskDimension.INSERT(TRUE);
            UNTIL JobTask.NEXT = 0;
    end;

    procedure DeleteJobTaskTempDim()
    begin
        JobTaskDimTemp.RESET;
        JobTaskDimTemp.DELETEALL;
    end;

    procedure CopyJobTaskDimToJobTaskDim(JobNo: Code[20]; JobTaskNo: Code[20]; NewJobNo: Code[20]; NewJobTaskNo: Code[20])
    var
        JobTaskDimension: Record 1002;
        JobTaskDimension2: Record 1002;
    begin
        JobTaskDimension.RESET;
        JobTaskDimension.SETRANGE("Job No.", JobNo);
        JobTaskDimension.SETRANGE("Job Task No.", JobTaskNo);
        IF JobTaskDimension.FINDSET THEN
            REPEAT
                IF NOT JobTaskDimension2.GET(NewJobNo, NewJobTaskNo, JobTaskDimension."Dimension Code") THEN BEGIN
                    JobTaskDimension2.INIT;
                    JobTaskDimension2."Job No." := NewJobNo;
                    JobTaskDimension2."Job Task No." := NewJobTaskNo;
                    JobTaskDimension2."Dimension Code" := JobTaskDimension."Dimension Code";
                    JobTaskDimension2."Dimension Value Code" := JobTaskDimension."Dimension Value Code";
                    JobTaskDimension2.INSERT(TRUE);
                END;
            UNTIL JobTaskDimension.NEXT = 0;
    end;

    procedure CheckDimIDConsistency(var DimSetEntry: Record 480; var PostedDimSetEntry: Record 480; DocTableID: Integer; PostedDocTableID: Integer): Boolean
    begin
        IF DimSetEntry.FINDSET THEN;
        IF PostedDimSetEntry.FINDSET THEN;
        REPEAT
            CASE TRUE OF
                DimSetEntry."Dimension Code" > PostedDimSetEntry."Dimension Code":
                    BEGIN
                        DocDimConsistencyErr :=
                          STRSUBSTNO(
                            Text012,
                            DimSetEntry.FIELDCAPTION("Dimension Code"),
                            ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, DocTableID),
                            ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, PostedDocTableID));
                        EXIT(FALSE);
                    END;
                DimSetEntry."Dimension Code" < PostedDimSetEntry."Dimension Code":
                    BEGIN
                        DocDimConsistencyErr :=
                          STRSUBSTNO(
                            Text012,
                            PostedDimSetEntry.FIELDCAPTION("Dimension Code"),
                            ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, PostedDocTableID),
                            ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, DocTableID));
                        EXIT(FALSE);
                    END;
                DimSetEntry."Dimension Code" = PostedDimSetEntry."Dimension Code":
                    BEGIN
                        IF DimSetEntry."Dimension Value Code" <> PostedDimSetEntry."Dimension Value Code" THEN BEGIN
                            DocDimConsistencyErr :=
                              STRSUBSTNO(
                                Text013,
                                DimSetEntry.FIELDCAPTION("Dimension Value Code"),
                                DimSetEntry.FIELDCAPTION("Dimension Code"),
                                DimSetEntry."Dimension Code",
                                ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, DocTableID),
                                ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, PostedDocTableID));
                            EXIT(FALSE);
                        END;
                    END;
            END;
        UNTIL (DimSetEntry.NEXT = 0) AND (PostedDimSetEntry.NEXT = 0);
        EXIT(TRUE);
    end;

    local procedure CreateDimSetEntryFromDimValue(DimValue: Record 349; var TempDimSetEntry: Record 480 temporary)
    begin
        TempDimSetEntry."Dimension Code" := DimValue."Dimension Code";
        TempDimSetEntry."Dimension Value Code" := DimValue.Code;
        TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
        TempDimSetEntry.INSERT;
    end;

    procedure CreateDimSetIDFromICDocDim(var ICDocDim: Record 442): Integer
    var
        DimValue: Record 349;
        TempDimSetEntry: Record 480 temporary;
    begin
        IF ICDocDim.FIND('-') THEN
            REPEAT
                DimValue.GET(
                  ConvertICDimtoDim(ICDocDim."Dimension Code"),
                  ConvertICDimValuetoDimValue(ICDocDim."Dimension Code", ICDocDim."Dimension Value Code"));
                CreateDimSetEntryFromDimValue(DimValue, TempDimSetEntry);
            UNTIL ICDocDim.NEXT = 0;
        EXIT(GetDimensionSetID(TempDimSetEntry));
    end;

    procedure CreateDimSetIDFromICJnlLineDim(var ICInboxOutboxJnlLineDim: Record 423
    ): Integer
    var
        DimValue: Record 349;
        TempDimSetEntry: Record 480 temporary;
    begin
        IF ICInboxOutboxJnlLineDim.FIND('-') THEN
            REPEAT
                DimValue.GET(
                  ConvertICDimtoDim(ICInboxOutboxJnlLineDim."Dimension Code"),
                  ConvertICDimValuetoDimValue(
                    ICInboxOutboxJnlLineDim."Dimension Code", ICInboxOutboxJnlLineDim."Dimension Value Code"));
                CreateDimSetEntryFromDimValue(DimValue, TempDimSetEntry);
            UNTIL ICInboxOutboxJnlLineDim.NEXT = 0;
        EXIT(GetDimensionSetID(TempDimSetEntry));
    end;

    procedure CopyDimBufToDimSetEntry(var FromDimBuf: Record 360; var DimSetEntry: Record 480)
    var
        DimValue: Record 349;
    begin
        IF FromDimBuf.FINDSET THEN
            REPEAT
                DimValue.GET(FromDimBuf."Dimension Code", FromDimBuf."Dimension Value Code");
                DimSetEntry."Dimension Code" := FromDimBuf."Dimension Code";
                DimSetEntry."Dimension Value Code" := FromDimBuf."Dimension Value Code";
                DimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                DimSetEntry.INSERT;
            UNTIL FromDimBuf.NEXT = 0;
    end;

    procedure CreateDimSetIDFromDimBuf(var DimBuf: Record 360): Integer
    var
        DimValue: Record 349;
        TempDimSetEntry: Record 480 temporary;
    begin
        IF DimBuf.FINDSET THEN
            REPEAT
                DimValue.GET(DimBuf."Dimension Code", DimBuf."Dimension Value Code");
                CreateDimSetEntryFromDimValue(DimValue, TempDimSetEntry);
            UNTIL DimBuf.NEXT = 0;
        EXIT(GetDimensionSetID(TempDimSetEntry));
    end;

    procedure GetDimSetIDsForFilter(DimCode: Code[20]; DimValueFilter: Text[250])
    var
        DimSetEntry2: Record 480;
    begin
        DimSetEntry2.SETFILTER("Dimension Code", '%1', DimCode);
        DimSetEntry2.SETFILTER("Dimension Value Code", DimValueFilter);
        IF DimSetEntry2.FINDSET THEN
            REPEAT
                AddDimSetIDtoTempEntry(TempDimSetEntry2, DimSetEntry2."Dimension Set ID");
            UNTIL DimSetEntry2.NEXT = 0;
        IF FilterIncludesBlank(DimCode, DimValueFilter) THEN
            GetDimSetIDsForBlank(DimCode);
        DimSetFilterCtr += 1;
    end;

    local procedure GetDimSetIDsForBlank(DimCode: Code[20])
    var
        TempDimSetEntry: Record 480 temporary;
        DimSetEntry2: Record 480;
        PrevDimSetID: Integer;
        i: Integer;
    begin
        AddDimSetIDtoTempEntry(TempDimSetEntry, 0);
        FOR i := 1 TO 2 DO BEGIN
            IF i = 2 THEN
                DimSetEntry2.SETFILTER("Dimension Code", '%1', DimCode);
            IF DimSetEntry2.FINDSET THEN BEGIN
                PrevDimSetID := 0;
                REPEAT
                    IF DimSetEntry2."Dimension Set ID" <> PrevDimSetID THEN BEGIN
                        AddDimSetIDtoTempEntry(TempDimSetEntry, DimSetEntry2."Dimension Set ID");
                        PrevDimSetID := DimSetEntry2."Dimension Set ID";
                    END;
                UNTIL DimSetEntry2.NEXT = 0;
            END;
        END;
        TempDimSetEntry.SETFILTER("Dimension Value ID", '%1', 1);
        IF TempDimSetEntry.FINDSET THEN
            REPEAT
                AddDimSetIDtoTempEntry(TempDimSetEntry2, TempDimSetEntry."Dimension Set ID");
            UNTIL TempDimSetEntry.NEXT = 0;
    end;

    procedure GetNextDimSetFilterChunk(Length: Integer) DimSetFilterChunk: Text[1024]
    var
        EndLoop: Boolean;
    begin
        IF Length > MAXSTRLEN(DimSetFilterChunk) THEN
            Length := MAXSTRLEN(DimSetFilterChunk);
        TempDimSetEntry2.SETFILTER("Dimension Value ID", '%1', DimSetFilterCtr);
        TempDimSetEntry2.SETFILTER("Dimension Set ID", '>%1', LastDimSetIDInFilter);
        IF TempDimSetEntry2.FINDSET THEN BEGIN
            DimSetFilterChunk := FORMAT(TempDimSetEntry2."Dimension Set ID");
            LastDimSetIDInFilter := TempDimSetEntry2."Dimension Set ID";
            WHILE (STRLEN(DimSetFilterChunk) < Length) AND (NOT EndLoop) DO BEGIN
                IF TempDimSetEntry2.NEXT <> 0 THEN BEGIN
                    IF STRLEN(DimSetFilterChunk + '|' + FORMAT(TempDimSetEntry2."Dimension Set ID")) <= Length THEN BEGIN
                        DimSetFilterChunk += '|' + FORMAT(TempDimSetEntry2."Dimension Set ID");
                        LastDimSetIDInFilter := TempDimSetEntry2."Dimension Set ID";
                    END ELSE
                        EndLoop := TRUE;
                END ELSE
                    EndLoop := TRUE;
            END;
        END;
    end;

    local procedure FilterIncludesBlank(DimCode: Code[20]; DimValueFilter: Text[250]): Boolean
    var
        TempDimSetEntry: Record 480 temporary;
    begin
        TempDimSetEntry."Dimension Code" := DimCode;
        TempDimSetEntry.INSERT;
        TempDimSetEntry.SETFILTER("Dimension Value Code", DimValueFilter);
        EXIT(NOT TempDimSetEntry.ISEMPTY);
    end;

    local procedure AddDimSetIDtoTempEntry(var TempDimSetEntry: Record 480 temporary; DimSetID: Integer)
    begin
        IF TempDimSetEntry.GET(DimSetID, '') THEN BEGIN
            TempDimSetEntry."Dimension Value ID" += 1;
            TempDimSetEntry.MODIFY;
        END ELSE BEGIN
            TempDimSetEntry."Dimension Set ID" := DimSetID;
            TempDimSetEntry."Dimension Value ID" := 1;
            TempDimSetEntry.INSERT
        END;
    end;

    procedure ClearDimSetFilter()
    begin
        TempDimSetEntry2.RESET;
        TempDimSetEntry2.DELETEALL;
        DimSetFilterCtr := 0;
        LastDimSetIDInFilter := 0;
    end;

    procedure GetTempDimSetEntry(var TempDimSetEntry: Record 480 temporary)
    begin
        TempDimSetEntry.COPY(TempDimSetEntry2, TRUE);
    end;

    local procedure UpdateCostType(DefaultDimension: Record 352; CallingTrigger: Option OnInsert,OnModify,OnDelete)
    var
        GLAcc: Record 15;
        CostAccSetup: Record 1108;
        CostAccMgt: Codeunit 1100;
    begin
        IF CostAccSetup.GET AND (DefaultDimension."Table ID" = DATABASE::"G/L Account") THEN
            IF GLAcc.GET(DefaultDimension."No.") THEN
                CostAccMgt.UpdateCostTypeFromDefaultDimension(DefaultDimension, GLAcc, CallingTrigger);
    end;

    procedure CreateDimSetFromJobTaskDim(JobNo: Code[20]; JobTaskNo: Code[20]; var GlobalDimVal1: Code[20]; var GlobalDimVal2: Code[20]) NewDimSetID: Integer
    var
        JobTaskDimension: Record 1002;
        DimValue: Record 349;
        TempDimSetEntry: Record 480 temporary;
    begin
        JobTaskDimension.SETRANGE("Job No.", JobNo);
        JobTaskDimension.SETRANGE("Job Task No.", JobTaskNo);
        IF JobTaskDimension.FINDSET THEN BEGIN
            REPEAT
                DimValue.GET(JobTaskDimension."Dimension Code", JobTaskDimension."Dimension Value Code");
                TempDimSetEntry."Dimension Code" := JobTaskDimension."Dimension Code";
                TempDimSetEntry."Dimension Value Code" := JobTaskDimension."Dimension Value Code";
                TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                TempDimSetEntry.INSERT(TRUE);
            UNTIL JobTaskDimension.NEXT = 0;
            NewDimSetID := GetDimensionSetID(TempDimSetEntry);
            UpdateGlobalDimFromDimSetID(NewDimSetID, GlobalDimVal1, GlobalDimVal2);
        END;
    end;

    procedure UpdateGenJnlLineDim(var GenJnlLine: Record 81; DimSetID: Integer)
    begin
        GenJnlLine."Dimension Set ID" := DimSetID;
        UpdateGlobalDimFromDimSetID(
          GenJnlLine."Dimension Set ID",
          GenJnlLine."Shortcut Dimension 1 Code", GenJnlLine."Shortcut Dimension 2 Code");
    end;

    procedure UpdateGenJnlLineDimFromCustLedgEntry(var GenJnlLine: Record 81; DtldCustLedgEntry: Record 379)
    var
        CustLedgEntry: Record 21;
    begin
        IF DtldCustLedgEntry."Cust. Ledger Entry No." <> 0 THEN BEGIN
            CustLedgEntry.GET(DtldCustLedgEntry."Cust. Ledger Entry No.");
            UpdateGenJnlLineDim(GenJnlLine, CustLedgEntry."Dimension Set ID");
        END;
    end;

    procedure UpdateGenJnlLineDimFromVendLedgEntry(var GenJnlLine: Record 81; DtldVendLedgEntry: Record 380)
    var
        VendLedgEntry: Record 25;
    begin
        IF DtldVendLedgEntry."Vendor Ledger Entry No." <> 0 THEN BEGIN
            VendLedgEntry.GET(DtldVendLedgEntry."Vendor Ledger Entry No.");
            UpdateGenJnlLineDim(GenJnlLine, VendLedgEntry."Dimension Set ID");
        END;
    end;

    procedure GetDimSetEntryDefaultDim(var DimSetEntry2: Record 480)
    var
        DimValue: Record 349;
    begin
        IF NOT DimSetEntry2.ISEMPTY THEN
            DimSetEntry2.DELETEALL;
        IF TempDimBuf2.FINDSET THEN
            REPEAT
                DimValue.GET(TempDimBuf2."Dimension Code", TempDimBuf2."Dimension Value Code");
                DimSetEntry2."Dimension Code" := TempDimBuf2."Dimension Code";
                DimSetEntry2."Dimension Value Code" := TempDimBuf2."Dimension Value Code";
                DimSetEntry2."Dimension Value ID" := DimValue."Dimension Value ID";
                DimSetEntry2.INSERT;
            UNTIL TempDimBuf2.NEXT = 0;
        TempDimBuf2.RESET;
        TempDimBuf2.DELETEALL;
    end;

    local procedure InsertObject(var TempAllObjWithCaption: Record 2000000058 temporary; TableID: Integer)
    var
        AllObjWithCaption: Record 2000000058;
    begin
        AllObjWithCaption.SETRANGE("Object Type", AllObjWithCaption."Object Type"::Table);
        AllObjWithCaption.SETRANGE("Object ID", TableID);
        IF AllObjWithCaption.FINDFIRST THEN BEGIN
            TempAllObjWithCaption := AllObjWithCaption;
            TempAllObjWithCaption.INSERT;
        END;
    end;

    procedure GetConsolidatedDimFilterByDimFilter(var Dimension: Record 348; DimFilter: Text) ConsolidatedDimFilter: Text
    begin
        Dimension.SETFILTER("Consolidation Code", DimFilter);
        ConsolidatedDimFilter += DimFilter;
        IF Dimension.FINDSET THEN
            REPEAT
                ConsolidatedDimFilter += '|' + Dimension.Code;
            UNTIL Dimension.NEXT = 0;
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterSetupObjectNoList(var TempAllObjWithCaption: Record 2000000058 temporary)
    begin
    end;
}

