page 51160 "ACA-Scholarship Allocation"
{
    Caption = 'Scholarship Allocation Disbursement';
    DeleteAllowed = true;
    Editable = true;
    PageType = ListPart;
    SourceTable = "ACA-Imp. Receipts Buffer";
    // SourceTableView = WHERE(Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(general)
            {
                Editable = (not Rec.posted);
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                    StyleExpr = varStyle;
                }
                field("Student No."; Rec."Student No.")
                {
                    Caption = 'Account No.';
                    ApplicationArea = All;
                    StyleExpr = varStyle;


                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    StyleExpr = varStyle;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    StyleExpr = varStyle;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    StyleExpr = varStyle;
                }
                field("Stud Exist"; Rec."Stud Exist")
                {
                    // Visible = false;
                    ApplicationArea = All;
                    StyleExpr = varStyle;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = All;
                    StyleExpr = varStyle;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    StyleExpr = varStyle;

                }
                field("Receipt No"; Rec."Receipt No")
                {
                    ApplicationArea = All;
                    StyleExpr = varStyle;
                }
                field(IDNo; Rec.IDNo)
                {
                    ApplicationArea = All;
                    StyleExpr = varStyle;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    StyleExpr = varStyle;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = All;
                    StyleExpr = varStyle;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Receipting)
            {
                Caption = 'Receipting';
                action("Import Receipts")
                {
                    Caption = 'Import Receipts';
                    Image = ImportExcel;


                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Arrange your CSV File to have fields in the following order:\' +
                        'Serial\' +
                        'Transaction Code\' +
                        'Cheque No\' +
                        'F Name\' +
                        'M Name\' +
                        'L Name\' +
                        'ID No\' +
                        'Student No.\' +
                        'Amount\' +
                        'Description\' +
                        'Semester\' +
                        '************************************************************\' +
                        'Continue?', TRUE) = FALSE THEN
                            ERROR('Cancelled By User: ' + USERID);

                        XMLPORT.RUN(50152, TRUE, TRUE);
                    end;
                }
                action("Export Excel")
                {
                    Caption = 'Export Batches';
                    Image = ExportToExcel;
                    trigger OnAction()
                    var
                        csv: Codeunit "Csv Handler";
                        recref: RecordRef;
                        FieldRef: array[20] of FieldRef;
                        FileName: Text[250];
                        ExcelBuffer: Record "Excel Buffer" temporary;
                        FieldRefLength: Integer;
                    begin
                        //date,student no,description,amount,transaction code,idno,
                        recref.GetTable(Rec);
                        FieldRef[1] := recref.Field(Rec.FieldNo(Date));
                        FieldRef[2] := recref.Field(Rec.FieldNo("Student No."));
                        FieldRef[3] := recref.Field(Rec.FieldNo(Name));
                        FieldRef[4] := recref.Field(Rec.FieldNo(Description));
                        FieldRef[5] := recref.Field(Rec.FieldNo(Amount));
                        FieldRef[6] := recref.Field(Rec.FieldNo("Cheque No"));
                        FieldRef[7] := recref.Field(Rec.FieldNo(IDNo));
                        FileName := 'Scholarship Allocation.xlsx';
                        csv.ExportExcelFile(FileName, recref, FieldRef, 7, ExcelBuffer, 'Scholarship Allocation', 1);
                        csv.downloadFromExelBuffer(ExcelBuffer, FileName);
                    end;

                }
                action("Import Excel")
                {
                    Caption = 'Import Batches';
                    Image = ImportExcel;
                    trigger OnAction()
                    var
                        csv: Codeunit "Csv Handler";
                        recref: array[20] of RecordRef;
                        FieldRef: array[20] of FieldRef;
                        FileName: Text[250];
                        ExcelBuffer: Record "Excel Buffer" temporary;
                        Fields: Dictionary of [Integer, List of [Integer]];
                        ArrSheetName: array[20] of Text;
                        fieldlist: List of [Integer];
                    begin
                        recref[1].GetTable(Rec);
                        ArrSheetName[1] := 'Scholarship Allocation';
                        fieldlist.Add(Rec.FieldNo(Date));
                        fieldlist.Add(Rec.FieldNo("Student No."));
                        fieldlist.Add(Rec.FieldNo(Name));
                        fieldlist.Add(Rec.FieldNo(Description));
                        fieldlist.Add(Rec.FieldNo(Amount));
                        fieldlist.Add(Rec.FieldNo("Cheque No"));
                        fieldlist.Add(Rec.FieldNo(IDNo));
                        Fields.Add(1, fieldlist);
                        csv.importFromExcel(recref, ArrSheetName, 1, Fields, Rec."Transaction Code", Rec.FieldNo("Transaction Code"));
                    end;

                }
                action("Post Receipts")
                {
                    Caption = 'Post Receipts';
                    Image = PostBatch;


                    RunObject = Report "Generate Receipts";
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        varStyle := 'Favorable';
        Rec.CalcFields("Stud Exist");
        if Rec.Invalid then
            varStyle := 'Attention';
    end;

    var
        StudPayments: Record "ACA-Std Payments";
        RcptBuffer: Integer;
        varStyle: Text[20];
}

