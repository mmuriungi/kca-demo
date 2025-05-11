page 52104 "Custom Det cust ledgers"
{

    ApplicationArea = All;
    Caption = 'Custom Det cust ledgers';
    PageType = List;
    SourceTable = "Detailed Cust ledger Custom";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the value of the Entry Type field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowPostingDialog)
            {
                ApplicationArea = All;
                Caption = 'Post Unposted Entries';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Post unposted entries to the general journal and mark them as posted.';

                trigger OnAction()
                var
                    DateFilterDialog: Page "Post Custom Ledger Filter";
                begin
                    // Configure the dialog as a lookup
                    DateFilterDialog.LookupMode(true);

                    // If the user filled the dates and clicked OK
                    if DateFilterDialog.RunModal() = Action::LookupOK then begin
                        // Let the page process the records
                        DateFilterDialog.ProcessRecords();
                    end;
                end;
            }
        }
    }
}