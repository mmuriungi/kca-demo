page 52149 "Journal Voucher List"
{
    ApplicationArea = All;
    Caption = 'Journal Voucher List';
    CardPageId = "Journal Voicher Card";
    PageType = List;
    DeleteAllowed = false;

    SourceTable = "Journal Voucher Headder";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Posted "; Rec."Posted ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = all;
                Image = Post;
                trigger OnAction()
                begin

                end;

            }
            action(SendApproval)
            {
                ApplicationArea = all;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                trigger OnAction()
                begin


                end;

            }
        }
    }
    var
        GenLine: Record 81;
        Journaline: Record "Journal Voucher Lines";

    procedure commitbudget()
    begin

    end;

    procedure cancelcommitbudget()
    begin

    end;

    procedure Expensetbudget()
    begin

    end;




}
