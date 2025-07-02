page 51470 "POS Sales Header Card Legacy"
{
    PageType = Card;
    SourceTable = "POS Sales Header Legacy";
    RefreshOnActivate = true;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(general)
            {
                Editable = not Rec.Posted;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Description field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "POS Sales Lines";
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }

                field("Current Date Time"; Rec."Current Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Date Time field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Type field.';
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Account field.';
                }
                field("Income Account"; Rec."Income Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Income Account field.';
                }
                // field("Institute Code"; Rec."Institute Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }

            }
            part(salesLines; "POS Sales Lines")
            {
                Editable = not Rec.Posted;
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."), "Serving Category" = field("Customer Type"), "Posting Date" = field("Posting Date");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Post & Print")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;
                Image = "Invoicing-Document";
                Enabled = not Rec.Posted;

                trigger OnAction()
                begin
                    if Rec."Amount Paid" = 0 then
                        Error('Amount Paid Must Have a value');
                    CommonMgnt.PostSale(Rec."No.");
                    rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    if rec.find('-') then begin
                        Report.Run(Report::"POS PrintOutTwo", false, true, Rec);
                        CurrPage.Close();

                    end;



                end;
            }
            action("Print Report")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;
                Image = Report;
                Visible = false;

                trigger OnAction()
                begin
                    // CommonMgnt.PostSale(Rec."No.");
                    Rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    Rec.TestField("Amount Paid");
                    Report.Run(Report::"POS PrintOut", true, false, Rec);
                    /* Rec.SetRange("No.", Rec."No.");
                    Report.Run(Report::"POS PrintOutTwo", True, false, Rec);
                    CurrPage.Close(); */
                end;
            }
        }
    }
    trigger OnClosePage()
    var
        ConfirmMsg: Label 'Do you wish to close this page?';
        CancelledErr: Label 'Closed cancelled!';
    begin
        if not Confirm(ConfirmMsg) then
            Message(CancelledErr);
    end;


    var
        CommonMgnt: Codeunit "Common Management";

}