page 56270 "SMS Campaign Subform"
{
    PageType = ListPart;
    Caption = 'SMS Campaign Lines';
    SourceTable = "SMS Campaign Line";
    DelayedInsert = true;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Recipient Type"; Rec."Recipient Type")
                {
                    ApplicationArea = All;
                }
                field("Recipient No."; Rec."Recipient No.")
                {
                    ApplicationArea = All;
                }
                field("Recipient Name"; Rec."Recipient Name")
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    StyleExpr = PhoneStyleExpr;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyleExpr;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sent DateTime"; Rec."Sent DateTime")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Response Code"; Rec."Response Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetLineStyles();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Selected := true;
        SetLineStyles();
    end;

    var
        StatusStyleExpr: Text;
        PhoneStyleExpr: Text;

    local procedure SetLineStyles()
    begin
        case Rec.Status of
            Rec.Status::Pending:
                StatusStyleExpr := 'Standard';
            Rec.Status::Sent:
                StatusStyleExpr := 'Favorable';
            Rec.Status::Failed:
                StatusStyleExpr := 'Unfavorable';
            Rec.Status::Skipped:
                StatusStyleExpr := 'Subordinate';
        end;
        
        if Rec."Phone Number" = '' then
            PhoneStyleExpr := 'Unfavorable'
        else
            PhoneStyleExpr := 'Standard';
    end;
}