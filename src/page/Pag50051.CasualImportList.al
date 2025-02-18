page 50051 "Casual Import List"
{
    ApplicationArea = All;
    Caption = 'Casual Import List';
    PageType = List;
    SourceTable = "Import Casual Pay Buffer";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("F. Name"; Rec."F. Name")
                {
                    ToolTip = 'Specifies the value of the F. Name field.', Comment = '%';
                    Caption = 'First Name';
                }
                field("M. Name"; Rec."M. Name")
                {
                    ToolTip = 'Specifies the value of the M. Name field.', Comment = '%';
                    Caption = 'Middle Name';
                }
                field("L. Name"; Rec."L. Name")
                {
                    ToolTip = 'Specifies the value of the L. Name field.', Comment = '%';
                    Caption = 'Last Name';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.', Comment = '%';
                }
                field("A/C No."; Rec."A/C No.")
                {
                    ToolTip = 'Specifies the value of the A/C No. field.', Comment = '%';
                }
                field(Days; Rec.Days)
                {
                    ToolTip = 'Specifies the value of the Days field.', Comment = '%';
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ToolTip = 'Specifies the value of the Daily Rate field.', Comment = '%';
                }
                field("Period Month"; Rec."Period Month")
                {
                    ToolTip = 'Specifies the value of the Period Month field.', Comment = '%';
                }
                field("Period Year"; Rec."Period Year")
                {
                    ToolTip = 'Specifies the value of the Period Year field.', Comment = '%';
                }
                field(Instalment; Rec.Instalment)
                {
                    ToolTip = 'Specifies the value of the Instalment field.', Comment = '%';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.', Comment = '%';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Export Excel")
            {
                Caption = 'Export';
                Image = ExportToExcel;
                trigger OnAction()
                var
                    csv: Codeunit "Csv Generator";
                    recref: RecordRef;
                    FieldRef: array[20] of FieldRef;
                    FileName: Text[250];
                    ExcelBuffer: Record "Excel Buffer" temporary;
                    FieldRefLength: Integer;
                    begin
                        //date,student no,description,amount,transaction code,idno,
                        recref.GetTable(Rec);
                        FieldRef[1] := recref.Field(Rec.FieldNo("F. Name"));
                        FieldRef[2] := recref.Field(Rec.FieldNo("M. Name"));
                        FieldRef[3] := recref.Field(Rec.FieldNo("L. Name"));
                        FieldRef[4] := recref.Field(Rec.FieldNo("No."));
                        FieldRef[5] := recref.Field(Rec.FieldNo("Bank Code"));
                        FieldRef[6] := recref.Field(Rec.FieldNo("A/C No."));
                        FieldRef[7] := recref.Field(Rec.FieldNo(Days));
                        FieldRef[8] := recref.Field(Rec.FieldNo("Daily Rate"));
                        FieldRef[9] := recref.Field(Rec.FieldNo("Period Month"));
                        FieldRef[10] := recref.Field(Rec.FieldNo("Period Year"));
                        FieldRef[11] := recref.Field(Rec.FieldNo(Instalment));
                        FieldRef[12] := recref.Field(Rec.FieldNo("Department Code"));
                        FieldRef[13] := recref.Field(Rec.FieldNo("Branch Code"));
                        FileName := 'Casual List.xlsx';
                        csv.ExportExcelFile(FileName, recref, FieldRef, 7, ExcelBuffer, 'Casual List', 1);
                        csv.downloadFromExelBuffer(ExcelBuffer, FileName);
                    end;
            }
            action("Import Excel")
            {
                Caption = 'Import';
                Image = ImportExcel;
                trigger OnAction()
                var
                    csv: Codeunit "Csv Generator";
                    recref: array[20] of RecordRef;
                    FieldRef: array[20] of FieldRef;
                    FileName: Text[250];
                    ExcelBuffer: Record "Excel Buffer" temporary;
                    Fields: Dictionary of [Integer, List of [Integer]];
                    ArrSheetName: array[20] of Text;
                    fieldlist: List of [Integer];
                    begin
                        recref[1].GetTable(Rec);
                        ArrSheetName[1] := 'Casual List';
                        fieldlist.Add(Rec.FieldNo("F. Name"));
                        fieldlist.Add(Rec.FieldNo("M. Name"));
                        fieldlist.Add(Rec.FieldNo("L. Name"));
                        fieldlist.Add(Rec.FieldNo("No."));
                        fieldlist.Add(Rec.FieldNo("Bank Code"));
                        fieldlist.Add(Rec.FieldNo("A/C No."));
                        fieldlist.Add(Rec.FieldNo(Days));
                        fieldlist.Add(Rec.FieldNo("Daily Rate"));
                        fieldlist.Add(Rec.FieldNo("Period Month"));
                        fieldlist.Add(Rec.FieldNo("Period Year"));
                        fieldlist.Add(Rec.FieldNo(Instalment));
                        fieldlist.Add(Rec.FieldNo("Department Code"));
                        fieldlist.Add(Rec.FieldNo("Branch Code"));
                        Fields.Add(1, fieldlist);
                        csv.importFromExcel(recref, ArrSheetName, 1, Fields, Rec."No.", Rec.FieldNo("No."));
                    end;
            }
        }
    }
}
