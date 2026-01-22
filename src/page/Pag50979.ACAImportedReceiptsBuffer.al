page 50979 "ACA-Imported Receipts Buffer"
{
    DeleteAllowed = true;
    Editable = true;
    PageType = List;
    SourceTable = "ACA-Imp. Receipts Buffer";
    SourceTableView = WHERE(Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(general)
            {
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
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Stud Exist"; Rec."Stud Exist")
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
                    Promoted = true;
                    PromotedIsBig = true;
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

                        XMLPORT.RUN(Xmlport::"Import Student Receipts", TRUE, TRUE);
                    end;
                }
                action("Post Receipts")
                {
                    Caption = 'Post Receipts';
                    Image = PostBatch;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report "Generate Receipts";
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        StudPayments: Record "ACA-Std Payments";
        RcptBuffer: Integer;
        varStyle: Text;

    trigger OnAfterGetRecord()
    begin
        varStyle := 'Favorable';
        Rec.CalcFields("Stud Exist");
        if Rec."Stud Exist" = 0 then
            varStyle := 'Attention';
    end;
}

