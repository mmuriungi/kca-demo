page 52135 "Sales Card (Students)"
{
    Caption = 'Sales Card (Students)';
    PageType = Card;
    SourceTable = "POS Sales Header";
    SourceTableView = where("Customer Type" = filter(Student), Posted = filter(false));
    DeleteAllowed = false;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the document number.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the cashier for this transaction.';
                }
                field("Posting date"; Rec."Posting date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the posting date.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the total amount.';
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount paid.';
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the payment method.';
                }
                field("Till Number"; Rec."Till Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the till number.';
                }
                field("M-Pesa Transaction Number"; Rec."M-Pesa Transaction Number")
                {
                    ApplicationArea = All;
                    Caption = 'Transaction Code';
                    ToolTip = 'Specifies the M-Pesa transaction number.';
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the balance.';
                }
            }
            group(Lines)
            {
                Caption = 'Lines';

                part(SalesLines; "POS Sales Lines")
                {
                    ApplicationArea = All;
                    SubPageLink = "Document No." = field("No."),
                                  "Serving Category" = field("Customer Type"),
                                  "Posting date" = field("Posting date");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Print)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Image = PrintAcknowledgement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ToolTip = 'Print the sales receipt.';

                trigger OnAction()
                var
                    SalesHeader: Record "POS Sales Header";
                    POSStudentsPrintOut: Report "POS Students PrintOut";
                begin
                    Rec.PostSale();
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    Report.Run(Report::"POS Students PrintOut", false, true, SalesHeader);
                    CurrPage.Close();
                end;
            }
        }
    }

    trigger OnInit()
    begin
        InitializeRecord();
    end;

    trigger OnOpenPage()
    begin
        InitializeRecord();
    end;

    trigger OnAfterGetRecord()
    begin
        InitializeRecord();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        InitializeRecord();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        InitializeRecord();
        exit(true);
    end;

    var
        PosSetup: Record "POS Setup";

    local procedure InitializeRecord()
    begin
        if Rec."No." = '' then begin
            Rec.SetFilter("Customer Type", '=%1', Rec."Customer Type"::Student);
            PosSetup.Get();
            PosSetup.TestField("Students Sales Account");
            Rec."Posting Description" := 'Student Food sales on ' + Format(Today());
            Rec."Posting date" := Today();
            Rec.Cashier := UserId();
            Rec."Customer Type" := Rec."Customer Type"::Student;
            Rec."Current Date Time" := CurrentDateTime;
            Rec."Cash Account" := PosSetup."Cash Account";
            Rec."Income Account" := PosSetup."Students Sales Account";
            Rec.Validate("Income Account");
        end;
    end;
}