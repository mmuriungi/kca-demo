codeunit 50201 "WP Matrix Management"
{

    trigger OnRun()
    begin
    end;

    var
        Text001: Label 'The previous column set could not be found.';
        Text002: Label 'The period could not be found.';
        Text003: Label 'There are no Calendar entries within the filter.';

    procedure SetPeriodColumnSet(DateFilter: Text[1024]; PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period"; Direction: Option Backward,Forward; var FirstColumn: Date; var LastColumn: Date; NoOfColumns: Integer)
    var
        Period: Record "Date";
        PeriodFormMgt: Codeunit "PeriodFormManagement";
        Steps: Integer;
        TmpFirstColumn: Date;
        TmpLastColumn: Date;
    begin
        Period.SETRANGE("Period Type", PeriodType);
        IF DateFilter = '' THEN BEGIN
            Period."Period Start" := WORKDATE;
            IF PeriodFormMgt.FindDate('<=', Period, PeriodType) THEN
                Steps := 1;
            PeriodFormMgt.NextDate(Steps, Period, PeriodType);
            DateFilter := '>=' + FORMAT(Period."Period Start");
        END ELSE BEGIN
            Period.SETFILTER("Period Start", DateFilter);
            Period.FIND('-');
        END;

        IF (FORMAT(FirstColumn) = '') AND (FORMAT(LastColumn) = '') THEN BEGIN
            FirstColumn := Period."Period Start";
            Period.NEXT(NoOfColumns - 1);
            LastColumn := Period."Period Start";
            EXIT;
        END;

        IF Direction = Direction::Forward THEN BEGIN
            Period.SETFILTER("Period Start", DateFilter);
            IF Period.GET(PeriodType, LastColumn) THEN
                Period.NEXT;
            TmpFirstColumn := Period."Period Start";
            Period.NEXT(NoOfColumns - 1);
            TmpLastColumn := Period."Period Start";
            IF TmpFirstColumn <> LastColumn THEN BEGIN
                FirstColumn := TmpFirstColumn;
                LastColumn := TmpLastColumn;
            END;
            EXIT;
        END;

        IF Direction = Direction::Backward THEN BEGIN
            IF Period.GET(PeriodType, FirstColumn) THEN
                Period.NEXT(-1);
            TmpLastColumn := Period."Period Start";
            Period.NEXT(-NoOfColumns + 1);
            TmpFirstColumn := Period."Period Start";
            IF TmpLastColumn <> FirstColumn THEN BEGIN
                FirstColumn := TmpFirstColumn;
                LastColumn := TmpLastColumn;
            END;
        END;
    end;

    procedure SetDimColumnSet(DimensionCode: Code[20]; DimFilter: Text[1024]; SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn; var PKFirstRecInCurrSet: Text[1024]; var FirstColumn: Text[1024]; var LastColumn: Text[1024]; NoOfColumns: Integer)
    var
        DimVal: Record "Dimension Value";
        TmpFirstColumn: Text[1024];
        TmpLastColumn: Text[1024];
        TmpSteps: Integer;
    begin
        DimVal.SETRANGE("Dimension Code", DimensionCode);
        IF DimFilter <> '' THEN
            DimVal.SETFILTER(Code, DimFilter);

        CASE SetWanted OF
            SetWanted::Initial:
                BEGIN
                    IF DimVal.FIND('-') THEN BEGIN
                        PKFirstRecInCurrSet := DimVal.GETPOSITION;
                        FirstColumn := DimVal.Code;
                        TmpSteps := DimVal.NEXT(NoOfColumns - 1);
                        LastColumn := DimVal.Code;
                    END;
                END;
            SetWanted::Same:
                BEGIN
                    IF PKFirstRecInCurrSet <> '' THEN BEGIN
                        DimVal.SETPOSITION(PKFirstRecInCurrSet);
                        DimVal.FIND('=');
                        FirstColumn := DimVal.Code;
                        TmpSteps := DimVal.NEXT(NoOfColumns - 1);
                        LastColumn := DimVal.Code;
                    END;
                END;
            SetWanted::Next:
                BEGIN
                    IF PKFirstRecInCurrSet <> '' THEN BEGIN
                        DimVal.SETPOSITION(PKFirstRecInCurrSet);
                        DimVal.FIND('=');
                        IF DimVal.NEXT(NoOfColumns) <> 0 THEN BEGIN
                            PKFirstRecInCurrSet := DimVal.GETPOSITION;
                            TmpFirstColumn := DimVal.Code;
                            TmpSteps := DimVal.NEXT(NoOfColumns - 1);
                            TmpLastColumn := DimVal.Code;
                            IF TmpFirstColumn <> LastColumn THEN BEGIN
                                FirstColumn := TmpFirstColumn;
                                LastColumn := TmpLastColumn;
                            END;
                        END ELSE
                            SetDimColumnSet(DimensionCode, DimFilter, SetWanted::Same, PKFirstRecInCurrSet, FirstColumn, LastColumn, NoOfColumns);
                    END;
                END;
            SetWanted::Previous:
                BEGIN
                    IF PKFirstRecInCurrSet <> '' THEN BEGIN
                        DimVal.SETPOSITION(PKFirstRecInCurrSet);
                        DimVal.FIND('=');
                        IF DimVal.NEXT(-1) <> 0 THEN BEGIN
                            TmpLastColumn := DimVal.Code;
                            TmpSteps := DimVal.NEXT(-NoOfColumns + 1);
                            PKFirstRecInCurrSet := DimVal.GETPOSITION;
                            TmpFirstColumn := DimVal.Code;
                            IF TmpLastColumn <> FirstColumn THEN BEGIN
                                FirstColumn := TmpFirstColumn;
                                LastColumn := TmpLastColumn;
                            END;
                        END ELSE
                            SetDimColumnSet(DimensionCode, DimFilter, SetWanted::Same, PKFirstRecInCurrSet, FirstColumn, LastColumn, NoOfColumns);
                    END;
                END;
            SetWanted::NextColumn:
                BEGIN
                    IF PKFirstRecInCurrSet <> '' THEN BEGIN
                        DimVal.SETPOSITION(PKFirstRecInCurrSet);
                        DimVal.FIND('=');
                        IF DimVal.NEXT <> 0 THEN BEGIN
                            PKFirstRecInCurrSet := DimVal.GETPOSITION;
                            TmpFirstColumn := DimVal.Code;
                            TmpSteps := DimVal.NEXT(NoOfColumns - 1);
                            TmpLastColumn := DimVal.Code;
                            IF TmpFirstColumn <> LastColumn THEN BEGIN
                                FirstColumn := TmpFirstColumn;
                                LastColumn := TmpLastColumn;
                            END;
                        END ELSE
                            SetDimColumnSet(DimensionCode, DimFilter, SetWanted::Same, PKFirstRecInCurrSet, FirstColumn, LastColumn, NoOfColumns);
                    END;
                END;
            SetWanted::PreviousColumn:
                BEGIN
                    IF PKFirstRecInCurrSet <> '' THEN BEGIN
                        DimVal.SETPOSITION(PKFirstRecInCurrSet);
                        DimVal.FIND('=');
                        IF DimVal.NEXT(-1) <> 0 THEN BEGIN
                            PKFirstRecInCurrSet := DimVal.GETPOSITION;
                            TmpFirstColumn := DimVal.Code;
                            TmpSteps := DimVal.NEXT(NoOfColumns - 1);
                            TmpLastColumn := DimVal.Code;
                            IF TmpLastColumn <> FirstColumn THEN BEGIN
                                FirstColumn := TmpFirstColumn;
                                LastColumn := TmpLastColumn;
                            END;
                        END ELSE
                            SetDimColumnSet(DimensionCode, DimFilter, SetWanted::Same, PKFirstRecInCurrSet, FirstColumn, LastColumn, NoOfColumns);
                    END;
                END;
        END;

        IF ABS(TmpSteps) <> NoOfColumns THEN
            NoOfColumns := ABS(TmpSteps);
    end;

    procedure DimToCaptions(var CaptionSet: array[32] of Text[1024]; var MatrixRecords: array[32] of Record "Dimension Code Buffer"; DimensionCode: Text[30]; FirstColumn: Text[1024]; LastColumn: Text[1024]; var NumberOfColumns: Integer; ShowColumnName: Boolean; var CaptionRange: Text[1024]; CopyTotaling: Boolean)
    var
        DimensionValue: Record "Dimension Value";
        i: Integer;
    begin
        DimensionValue.SETRANGE("Dimension Code", DimensionCode);
        DimensionValue.SETRANGE(Code, FirstColumn, LastColumn);
        i := 0;
        IF DimensionValue.FINDSET THEN
            REPEAT
                i := i + 1;
                MatrixRecords[i].Code := DimensionValue.Code;
                MatrixRecords[i].Name := DimensionValue.Name;
                IF CopyTotaling THEN
                    MatrixRecords[i].Totaling := DimensionValue.Totaling;
                IF ShowColumnName THEN
                    CaptionSet[i] := DimensionValue.Name
                ELSE
                    CaptionSet[i] := DimensionValue.Code
            UNTIL (i = ARRAYLEN(CaptionSet)) OR (DimensionValue.NEXT = 0);

        NumberOfColumns := i;

        IF NumberOfColumns = 1 THEN
            CaptionRange := CaptionSet[1]
        ELSE
            CaptionRange := CaptionSet[1] + '..' + CaptionSet[NumberOfColumns];
    end;

    procedure FillPeriodColumns(PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period"; var MatrixColumnCaptions: array[32] of Text[1024]; var MatrixRecords: array[32] of Record "Date"; FirstColumn: Date; LastColumn: Date; ShowColumnName: Boolean)
    var
        Period: Record "Date";
        PeriodFormMgt: Codeunit "PeriodFormManagement";
        i: Integer;
    begin
        Period.SETRANGE("Period Start", FirstColumn, LastColumn);
        Period.SETRANGE("Period Type", PeriodType);
        i := 1;
        IF Period.FIND('-') THEN
            REPEAT
                IF ShowColumnName THEN
                    MatrixColumnCaptions[i] := FORMAT(Period."Period Name")
                ELSE
                    MatrixColumnCaptions[i] := PeriodFormMgt.CreatePeriodFormat(PeriodType, Period."Period Start");

                MatrixRecords[i].COPY(Period);
                i := i + 1;
            UNTIL (Period.NEXT = 0) OR (i = ARRAYLEN(MatrixColumnCaptions));
    end;

    procedure CreateCaptionSet(var RecRef: RecordRef; SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn; MaximumNoOfCaptions: Integer; CaptionFieldNo: Integer; var PrimaryKeyFirstCaptionInCurrSe: Text[1024]; var CaptionSet: array[32] of Text[1024]; var CaptionRange: Text[1024]): Integer
    var
        CurrentCaptionOrdinal: Integer;
    begin
        CLEAR(CaptionSet);
        CaptionRange := '';

        CurrentCaptionOrdinal := 0;

        CASE SetWanted OF
            SetWanted::Initial:
                RecRef.FIND('=><')
                ;
            SetWanted::Previous:
                BEGIN
                    RecRef.SETPOSITION(PrimaryKeyFirstCaptionInCurrSe);
                    RecRef.FIND('=');
                    RecRef.NEXT(-MaximumNoOfCaptions);
                END;
            SetWanted::Same:
                BEGIN
                    RecRef.SETPOSITION(PrimaryKeyFirstCaptionInCurrSe);
                    RecRef.FIND('=');
                END;
            SetWanted::Next:
                BEGIN
                    RecRef.SETPOSITION(PrimaryKeyFirstCaptionInCurrSe);
                    RecRef.FIND('=');
                    IF NOT (RecRef.NEXT(MaximumNoOfCaptions) = MaximumNoOfCaptions) THEN BEGIN
                        RecRef.SETPOSITION(PrimaryKeyFirstCaptionInCurrSe);
                        RecRef.FIND('=')
                    END;
                END;
            SetWanted::PreviousColumn:
                BEGIN
                    RecRef.SETPOSITION(PrimaryKeyFirstCaptionInCurrSe);
                    RecRef.FIND('=');
                    RecRef.NEXT(-1);
                END;
            SetWanted::NextColumn:
                BEGIN
                    RecRef.SETPOSITION(PrimaryKeyFirstCaptionInCurrSe);
                    RecRef.FIND('=');
                    IF NOT (RecRef.NEXT = 1) THEN BEGIN
                        RecRef.SETPOSITION(PrimaryKeyFirstCaptionInCurrSe);
                        RecRef.FIND('=')
                    END;
                END;
        END;

        PrimaryKeyFirstCaptionInCurrSe := RecRef.GETPOSITION;

        REPEAT
            CurrentCaptionOrdinal := CurrentCaptionOrdinal + 1;
            CaptionSet[CurrentCaptionOrdinal] := FORMAT(RecRef.FIELD(CaptionFieldNo).VALUE);
        UNTIL (CurrentCaptionOrdinal = MaximumNoOfCaptions) OR (RecRef.NEXT <> 1);

        IF CurrentCaptionOrdinal = 1 THEN
            CaptionRange := CaptionSet[1]
        ELSE
            CaptionRange := CaptionSet[1] + '..' + CaptionSet[CurrentCaptionOrdinal];
    end;

    procedure GenerateMatrixData(var RecRef: RecordRef; SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn; MaximumSetLength: Integer; CaptionFieldNo: Integer; var PKFirstRecInCurrSet: Text[1024]; var CaptionSet: array[32] of Text[1024]; var CaptionRange: Text[1024]; var CurrSetLength: Integer)
    var
        Steps: Integer;
    begin
        CLEAR(CaptionSet);
        CaptionRange := '';
        CurrSetLength := 0;

        IF RecRef.ISEMPTY THEN BEGIN
            PKFirstRecInCurrSet := '';
            EXIT;
        END;

        CASE SetWanted OF
            SetWanted::Initial:
                RecRef.FINDFIRST;
            SetWanted::Previous:
                BEGIN
                    RecRef.SETPOSITION(PKFirstRecInCurrSet);
                    RecRef.GET(RecRef.RECORDID);
                    Steps := RecRef.NEXT(-MaximumSetLength);
                    IF NOT (Steps IN [-MaximumSetLength, 0]) THEN
                        ERROR(Text001);
                END;
            SetWanted::Same:
                BEGIN
                    RecRef.SETPOSITION(PKFirstRecInCurrSet);
                    RecRef.GET(RecRef.RECORDID);
                END;
            SetWanted::Next:
                BEGIN
                    RecRef.SETPOSITION(PKFirstRecInCurrSet);
                    RecRef.GET(RecRef.RECORDID);
                    IF NOT (RecRef.NEXT(MaximumSetLength) = MaximumSetLength) THEN BEGIN
                        RecRef.SETPOSITION(PKFirstRecInCurrSet);
                        RecRef.GET(RecRef.RECORDID);
                    END;
                END;
            SetWanted::PreviousColumn:
                BEGIN
                    RecRef.SETPOSITION(PKFirstRecInCurrSet);
                    RecRef.GET(RecRef.RECORDID);
                    Steps := RecRef.NEXT(-1);
                    IF NOT (Steps IN [-1, 0]) THEN
                        ERROR(Text001);
                END;
            SetWanted::NextColumn:
                BEGIN
                    RecRef.SETPOSITION(PKFirstRecInCurrSet);
                    RecRef.GET(RecRef.RECORDID);
                    IF NOT (RecRef.NEXT(1) = 1) THEN BEGIN
                        RecRef.SETPOSITION(PKFirstRecInCurrSet);
                        RecRef.GET(RecRef.RECORDID);
                    END;
                END;
        END;

        PKFirstRecInCurrSet := RecRef.GETPOSITION;

        REPEAT
            CurrSetLength := CurrSetLength + 1;
            CaptionSet[CurrSetLength] := FORMAT(RecRef.FIELD(CaptionFieldNo).VALUE);
        UNTIL (CurrSetLength = MaximumSetLength) OR (RecRef.NEXT <> 1);

        IF CurrSetLength = 1 THEN
            CaptionRange := CaptionSet[1]
        ELSE
            CaptionRange := CaptionSet[1] + '..' + CaptionSet[CurrSetLength];
    end;

    procedure GeneratePeriodMatrixData(SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn; MaximumSetLength: Integer; UseNameForCaption: Boolean; PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period"; DateFilter: Text[30]; var PKFirstRecInCurrSet: Text[100]; var CaptionSet: array[32] of Text[200]; var CaptionRange: Text[100]; var CurrSetLength: Integer; var PeriodRecords: array[32] of Record "Date" temporary)
    var
        Steps: Integer;
        Calendar: Record "Date";
        PeriodFormMgt: Codeunit "PeriodFormManagement";
    begin
        CLEAR(CaptionSet);
        CaptionRange := '';
        CurrSetLength := 0;
        CLEAR(PeriodRecords);
        CLEAR(Calendar);
        CLEAR(PeriodFormMgt);

        Calendar.SETFILTER("Period Start", DateFilter);
        IF NOT FindDate('-', Calendar, PeriodType, FALSE) THEN BEGIN
            PKFirstRecInCurrSet := '';
            ERROR(Text003);
        END;

        CASE SetWanted OF
            SetWanted::Initial:
                BEGIN
                    IF (PeriodType = PeriodType::"Accounting Period") OR (DateFilter <> '') THEN BEGIN
                        FindDate('-', Calendar, PeriodType, TRUE);
                    END ELSE
                        Calendar."Period Start" := 0D;
                    FindDate('=><', Calendar, PeriodType, TRUE);
                END;
            SetWanted::Previous:
                BEGIN
                    Calendar.SETPOSITION(PKFirstRecInCurrSet);
                    FindDate('=', Calendar, PeriodType, TRUE);
                    Steps := PeriodFormMgt.NextDate(-MaximumSetLength, Calendar, PeriodType);
                    IF NOT (Steps IN [-MaximumSetLength, 0]) THEN
                        ERROR(Text001);
                END;
            SetWanted::PreviousColumn:
                BEGIN
                    Calendar.SETPOSITION(PKFirstRecInCurrSet);
                    FindDate('=', Calendar, PeriodType, TRUE);
                    Steps := PeriodFormMgt.NextDate(-1, Calendar, PeriodType);
                    IF NOT (Steps IN [-1, 0]) THEN
                        ERROR(Text001);
                END;
            SetWanted::NextColumn:
                BEGIN
                    Calendar.SETPOSITION(PKFirstRecInCurrSet);
                    FindDate('=', Calendar, PeriodType, TRUE);
                    IF NOT (PeriodFormMgt.NextDate(1, Calendar, PeriodType) = 1) THEN BEGIN
                        Calendar.SETPOSITION(PKFirstRecInCurrSet);
                        FindDate('=', Calendar, PeriodType, TRUE);
                    END;
                END;
            SetWanted::Same:
                BEGIN
                    Calendar.SETPOSITION(PKFirstRecInCurrSet);
                    FindDate('=', Calendar, PeriodType, TRUE)
                END;
            SetWanted::Next:
                BEGIN
                    Calendar.SETPOSITION(PKFirstRecInCurrSet);
                    FindDate('=', Calendar, PeriodType, TRUE);
                    IF NOT (PeriodFormMgt.NextDate(MaximumSetLength, Calendar, PeriodType) = MaximumSetLength) THEN BEGIN
                        Calendar.SETPOSITION(PKFirstRecInCurrSet);
                        FindDate('=', Calendar, PeriodType, TRUE);
                    END;
                END;
        END;

        PKFirstRecInCurrSet := Calendar.GETPOSITION;

        REPEAT
            CurrSetLength := CurrSetLength + 1;
            IF UseNameForCaption THEN
                CaptionSet[CurrSetLength] := FORMAT(Calendar."Period Name")
            ELSE
                CaptionSet[CurrSetLength] := PeriodFormMgt.CreatePeriodFormat(PeriodType, Calendar."Period Start");
            PeriodRecords[CurrSetLength].COPY(Calendar);
        UNTIL (CurrSetLength = MaximumSetLength) OR (PeriodFormMgt.NextDate(1, Calendar, PeriodType) <> 1);

        IF CurrSetLength = 1 THEN
            CaptionRange := CaptionSet[1]
        ELSE
            CaptionRange := CaptionSet[1] + '..' + CaptionSet[CurrSetLength];
    end;

    procedure CreateTextAmount(Amount: Text[1024]; DecimalPoint: Option Period,Comma) TextAmount: Text[1024]
    var
        FormattedAmount: Text[1024];
        Position: Integer;
        Decimals: Code[10];
    begin
        IF DecimalPoint = DecimalPoint::Comma THEN BEGIN
            Position := 0;
            FormattedAmount := Amount;
            Position := STRPOS(FormattedAmount, ',');
            IF Position > 0 THEN BEGIN
                Decimals := COPYSTR(FormattedAmount, Position, STRLEN(FormattedAmount));
                IF STRLEN(Decimals) > 3 THEN
                    TextAmount := COPYSTR(FormattedAmount, 1, Position - 1) + COPYSTR(Decimals, 1, 3);
                IF STRLEN(Decimals) <= 3 THEN
                    TextAmount := COPYSTR(FormattedAmount, 1, Position - 1) + Decimals;
                IF STRLEN(Decimals) <= 2 THEN
                    TextAmount := COPYSTR(FormattedAmount, 1, Position - 1) + Decimals + '0';
                IF STRLEN(Decimals) <= 1 THEN
                    TextAmount := COPYSTR(FormattedAmount, 1, Position - 1) + '00';
            END ELSE
                TextAmount := FormattedAmount + ',00';
        END ELSE BEGIN
            Position := 0;
            FormattedAmount := Amount;
            Position := STRPOS(FormattedAmount, '.');
            IF Position > 0 THEN BEGIN
                Decimals := COPYSTR(FormattedAmount, Position, STRLEN(FormattedAmount));
                IF STRLEN(Decimals) > 3 THEN
                    TextAmount := COPYSTR(FormattedAmount, 1, Position - 1) + COPYSTR(Decimals, 1, 3);
                IF STRLEN(Decimals) <= 3 THEN
                    TextAmount := COPYSTR(FormattedAmount, 1, Position - 1) + Decimals;
                IF STRLEN(Decimals) <= 2 THEN
                    TextAmount := COPYSTR(FormattedAmount, 1, Position - 1) + Decimals + '0';
                IF STRLEN(Decimals) <= 1 THEN
                    TextAmount := COPYSTR(FormattedAmount, 1, Position - 1) + '00';
            END ELSE
                TextAmount := FormattedAmount + '.00';
        END;
    end;

    local procedure FindDate(SearchString: Text[3]; var Calendar: Record "Date"; PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period"; ErrorWhenNotFound: Boolean): Boolean
    var
        Found: Boolean;
        PeriodFormMgt: Codeunit "PeriodFormManagement";
    begin
        CLEAR(PeriodFormMgt);
        Found := PeriodFormMgt.FindDate(SearchString, Calendar, PeriodType);
        IF ErrorWhenNotFound AND NOT Found THEN
            ERROR(Text002);
        EXIT(Found);
    end;

    procedure SetIndentation(var TextString: Text[1024]; Indentation: Integer)
    var
        Substr: Text[1024];
    begin
        Substr := PADSTR(Substr, Indentation * 2, ' ');
        TextString := Substr + TextString;
    end;
}

