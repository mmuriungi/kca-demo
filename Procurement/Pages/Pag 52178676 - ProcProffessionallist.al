page 52178676 "Proc Proffessional list"
{
    CardPageId = "PROC Proff Opinion.Quote";
    Caption = 'Proc Proffessional list';
    PageType = List;
    SourceTable = "Proc Proffessional Opinion";
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTableView = where(Status = filter("Pending Approval"));
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Submitted"; Rec."Date Submitted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Submitted field.', Comment = '%';
                }

                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition No. field.';
                }
                field("Procurement methods"; Rec."Procurement methods")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement methods field.';
                }
            }
        }
    }


    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Accounting Officer", true);
        if UserSetup.Find('-') then begin

        end else
            Error('You are not an accounting officer');
        //rec.SetFilter(rec."Accounting Officer", '%1', UserId);
    end;

    var
        UserSetup: Record "User Setup";
}
