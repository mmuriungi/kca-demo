page 54348 "POS Sales Student Card"
{
    PageType = Card;
    SourceTable = "POS Sales Header";
    RefreshOnActivate = true;
    SourceTableView = where("Customer Type" = filter(Student), Posted = filter(false));
    layout
    {
        area(Content)
        {
            group(general)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Description field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                    DrillDownPageId = "POS Sales Lines";
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }

                field("Current Date Time"; Rec."Current Date Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Date Time field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Type field.';
                    Editable = false;
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Paid field.';
                }
                field(Balance; Rec.Balance)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance field.';
                }
            }
            group(sales)
            {
                ShowCaption = false;
                part(salesLines; "POS Sales Lines")
                {
                    ApplicationArea = All;
                    SubPageLink = "Document No." = field("No."), "Serving Category" = field("Customer Type"), "Posting Date" = field("Posting Date");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Print & Post")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;
                Image = PrintReport;
                ShortcutKey = 'F9';
                trigger OnAction()
                var
                    RecRef: RecordRef;
                begin
                    Rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(Report::"POS PrintOut", true, false, Rec);
                    Rec.PostSale();
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF Rec."No." = '' THEN BEGIN
            PosSetup.GET;
            PosSetup.TESTFIELD("Sales No.");
            NoSeriesMgt.InitSeries(PosSetup."Sales No.", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
            Rec."Posting Description" := 'Student Food sales on ' + format(Today());
            Rec."Posting Date" := Today();
            Rec.Cashier := UserId;
            Rec."Customer Type" := Rec."Customer Type"::Student;
            Rec."Current Date Time" := System.CurrentDateTime();

            Rec."Bank Account" := PosSetup."Students Cashbook";
            Rec."Income Account" := PosSetup."Students Sales Account";
        end;
    end;

    var
        PosSetup: Record "POS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        posLines: record "POS Sales Lines";
        GenJnLine: Record "Gen. Journal Line";
        Batch: Record "Gen. Journal Batch";
        LineNo: Integer;
        itemledger: Record "POS Item Ledger";

}