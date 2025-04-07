codeunit 50015 "Csv Generator"
{
    procedure ExportCsvFile(FileName: Text[250]; RecRef: RecordRef; arrFieldRef: array[20] of FieldRef; FieldRefLength: Integer);
    var
        txtvalue: Text;
        CsvBuffer: Record "CSV Buffer" temporary;
        LineNo: Integer;
        index: Integer;
        xFieldRef: FieldRef;
        ToFileTxt: Text;
        filemgmt: Codeunit "File Management";
        FACard: page "Fixed Asset Card";
    begin
        FileName := DelChr(FileName, '=', '/');
        FileName := 'C:\' + FileName + '.csv';
        if exists(FileName) then
            Erase(FileName);
        for index := 1 to FieldRefLength do begin
            LineNo := 1;
            CsvBuffer.InsertEntry(LineNo, index, arrFieldRef[index].Caption);
        end;
        if not RecRef.IsEmpty and not RecRef.IsDirty then begin
            if RecRef.FindSet() then begin
                repeat
                    Clear(index);
                    LineNo += 1;
                    for index := 1 to FieldRefLength do begin
                        xFieldRef := RecRef.Field(arrFieldRef[index].Number);
                        txtvalue := FormatFieldValue(xFieldRef);

                        CsvBuffer.InsertEntry(LineNo, index, txtvalue);
                    end;
                until RecRef.Next() = 0;
            end;
        end;
        CsvBuffer.SaveData(filename, ',');
        if Exists(filename) then begin
            ToFileTxt := CopyStr(FileName, 4, StrLen(filemgmt.GetFileNameWithoutExtension(FileName)));
            Download(filename, 'Save Valuation as', 'C:\', '*.csv', ToFileTxt);
        end;
    end;

    procedure ExportExcelFile(FileName: Text[250]; RecRef: RecordRef; arrFieldRef: array[20] of FieldRef; FieldRefLength: Integer; var ExcelBuffer: Record "Excel Buffer" temporary; SheetName: Text; SheetSequence: Integer)
    var
        LineNo: Integer;
        index: Integer;
        xFieldRef: FieldRef;
        ToFileTxt: Text;
        FileMgmt: Codeunit "File Management";
        FormulaReferenceSheetName: Text;
    begin
        if SheetSequence = 1 then begin
            ExcelBuffer.Reset();
            ExcelBuffer.DeleteAll();
        end else begin
            ExcelBuffer.DeleteAll();
            ExcelBuffer.SetCurrent(0, 0);
            ExcelBuffer.SelectOrAddSheet(SheetName);
        end;
        // Hapa tuweke headers
        ExcelBuffer.NewRow();
        for index := 1 to FieldRefLength do begin
            ExcelBuffer.AddColumn(arrFieldRef[index].Caption, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        end;
        // Tuweke data sasa
        //if not RecRef.IsEmpty and not RecRef.IsDirty then begin
        if RecRef.FindSet() then begin
            repeat
                ExcelBuffer.NewRow();
                for index := 1 to FieldRefLength do begin
                    xFieldRef := RecRef.Field(arrFieldRef[index].Number);
                    ExcelBuffer.AddColumn(FormatFieldValue(xFieldRef), false, '', false, false, false, '', GetExcelCellType(xFieldRef));
                end;
            until RecRef.Next() = 0;
        end
        else begin
            ExcelBuffer.NewRow();
            //generate default data
        end;
        //end;
        if SheetSequence = 1 then begin
            ExcelBuffer.CreateNewBook(SheetName);

            ExcelBuffer.WriteSheet(SheetName, 'Company Name', 'User Id');
        end else
            ExcelBuffer.WriteSheet(SheetName, CompanyName, UserId);
    end;

    procedure downloadFromExelBuffer(var ExcelBuffer: Record "Excel Buffer" temporary; friendlyFileName: Text[250])
    begin
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(friendlyFileName);
        ExcelBuffer.OpenExcel();
    end;

    local procedure GetExcelCellType(FieldRef: FieldRef): Integer
    var
        ExlBuffer: Record "Excel Buffer" temporary;
    begin
        case FieldRef.Type of
            FieldType::Integer,
            FieldType::Decimal:
                exit(ExlBuffer."Cell Type"::Number);
            FieldType::Date:
                exit(ExlBuffer."Cell Type"::Date);
            FieldType::Time:
                exit(ExlBuffer."Cell Type"::Time);
            else
                exit(ExlBuffer."Cell Type"::Text);
        end;
    end;

    procedure importFromExcel(ArrRecref: array[20] of RecordRef; ArrSheetName: array[20] of Text;
    arraylength: Integer; FieldsDict: Dictionary of [Integer, List of [Integer]]; KeyCode: Code[25]; KeyIndex: Integer)
    var
        i: Integer;
        RcptBuffer: Record "Import Casual Pay Buffer";
        ExcelBuffer: Record "Excel Buffer" temporary;
        FileMgt: Codeunit "File Management";
        FileName: Text;
        UploadResult: Boolean;
        FileInStream: InStream;
        FieldsList: List of [Integer];
    begin
        UploadResult := UploadIntoStream('Select Excel File', '', '', FileName, FileInStream);

        if not UploadResult then
            exit;
        for i := 1 to arraylength do begin
            ExcelBuffer.Reset();
            ExcelBuffer.DeleteAll();
            ExcelBuffer.OpenBookStream(FileInStream, ArrSheetName[i]);
            ExcelBuffer.ReadSheet();
            FieldsList := FieldsDict.Get(i);
            ImportRecordRef(ArrRecref[i], ExcelBuffer, FieldsList, KeyCode, KeyIndex);
            ;
        end;
    end;

    procedure ImportRecordRef(var RecRef: RecordRef; var ExcelBuffer: Record "Excel Buffer" temporary;
    fields: List of [Integer]; KeyCode: Code[25]; KeyIndex: Integer)
    var
        field: Integer;
        RowNo: Integer;
        MaxRowNo: Integer;
        fieldref: FieldRef;
        intvalue: Integer;
        fieldValue: Text;
        col: Integer;
        boolValue: Boolean;
        DateValue: Date;
        DecimalValue: Decimal;
        Student: Record Customer;
        InvalidStudents: Text;
        SkipRow: Boolean;
        ReceiptBuffer: Record "Import Casual Pay Buffer";
    begin
        Clear(InvalidStudents);
        MaxRowNo := GetLastRowNo(ExcelBuffer);
        for RowNo := 2 to MaxRowNo do begin
            Clear(SkipRow);
            foreach field in fields do begin
                col := fields.IndexOf(field);
                fieldref := RecRef.Field(field);
                fieldValue := GetExcelCellValue(ExcelBuffer, RowNo, col);
                if field = KeyIndex then
                    fieldValue := KeyCode;
                case
                    fieldref.Type of
                    fieldref.type::Integer:
                        begin
                            Evaluate(intvalue, fieldValue);
                            fieldref.Validate(intvalue);
                        end;
                    // fieldref.Type::Option:
                    //     begin
                    //         if fieldref.Caption = 'Question Type' then
                    //             fieldref.Validate(QuizType.Ordinals.Get(QuizType.Names.IndexOf(fieldValue)))
                    //         else
                    //             if fieldref.Caption = 'Question Category' then
                    //                 fieldref.Validate(QuizCate.Ordinals.Get(QuizCate.Names.IndexOf(fieldValue)));
                    //     end;
                    fieldref.Type::Boolean:
                        begin
                            Evaluate(boolValue, fieldValue);
                            fieldref.Validate(boolValue);
                        end;
                    fieldref.Type::Date:
                        begin
                            Evaluate(DateValue, fieldValue);
                            fieldref.Validate(DateValue);
                        end;
                    fieldref.Type::Decimal:
                        begin
                            Evaluate(DecimalValue, fieldValue);
                            fieldref.Validate(DecimalValue);
                        end;
                    else begin
                        fieldValue := DelChr(fieldValue, '<>', '"');
                        fieldref.Validate(fieldValue);

                    end;
                end;
            end;
        end;
        if not RecRef.Modify(true) then
            RecRef.Insert(true);
    end;

    // procedure getQuizEnumByCName(EnumName: Text): Enum "Question Answer Type"
    // var
    //     QuizEnum: Enum"Question Answer Type";
    // begin
    //     QuizEnum := Enum::"Investment Category".FromInteger(QuizEnum.Ordinals.Get(QuizEnum.Names.IndexOf(EnumName)));
    //     exit(InvestmentCategoryEnum);
    // end;

    local procedure GetExcelCellValue(var ExcelBuffer: Record "Excel Buffer" temporary; RowNo: Integer; ColNo: Integer): Text
    begin
        ExcelBuffer.Reset();
        ExcelBuffer.SetRange("Row No.", RowNo);
        ExcelBuffer.SetRange("Column No.", ColNo);
        if ExcelBuffer.FindFirst() then
            exit(ExcelBuffer."Cell Value as Text");
        exit('');
    end;

    local procedure GetLastRowNo(var ExcelBuffer: Record "Excel Buffer" temporary): Integer
    begin
        ExcelBuffer.SetRange("Row No.", 1, 1000000);
        if ExcelBuffer.FindLast() then
            exit(ExcelBuffer."Row No.");
        exit(0);
    end;

    procedure ImportCsvFile(FileName: Text[250]; RecRef: RecordRef; arrFieldRef: array[20] of FieldRef; FieldRefLength: Integer);
    var
        CsvBuffer: Record "CSV Buffer" temporary;
        LineNo: Integer;
        i: Integer;
        xFieldRef: FieldRef;
        FromFileTxt: Text;
        filemgmt: Codeunit "File Management";
    begin
        FileName := filemgmt.UploadFile('Upload Csv file to Import', '*.csv');
        if FileName <> '' then begin
            CsvBuffer.LoadData(FileName, ',');
            if CsvBuffer.FindSet() then begin
                repeat
                    if CsvBuffer."Line No." > 1 then begin
                        if CsvBuffer."Field No." = 1 then
                            RecRef.Init();
                        for i := 1 to FieldRefLength do begin
                            xFieldRef := RecRef.field(arrFieldRef[i].Number);
                            if CsvBuffer.Value <> '' then
                                xFieldRef.Value := CsvBuffer."Value";
                        end;
                        if not RecRef.Insert(true) then
                            RecRef.Modify(true);
                    end;
                until CsvBuffer.Next() = 0;
            end;
        end;
    end;

    local procedure FormatFieldValue(FieldRef: FieldRef): Text
    var
        Value: Text;
    begin
        case FieldRef.TYPE of
            FieldRef.Type::Text,
            FieldRef.Type::Code:
                begin
                    Value := Format(FieldRef.Value);
                    if Value.Contains(',') then
                        Value := '"' + Value.Replace('"', '""') + '"';
                end;
            FieldRef.Type::Date:
                Value := Format(FieldRef.Value, 0, '<Year4>-<Month,2>-<Day,2>');
            FieldRef.Type::DateTime:
                Value := Format(FieldRef.Value, 0, '<Year4>-<Month,2>-<Day,2> <Hours24,2>:<Minutes,2>:<Seconds,2>');
            FieldRef.Type::Decimal:
                Value := Format(FieldRef.Value, 0, '<Precision,2:2><Standard Format,0>');
            else
                Value := Format(FieldRef.Value);
        end;
        exit(Value);
    end;

}
