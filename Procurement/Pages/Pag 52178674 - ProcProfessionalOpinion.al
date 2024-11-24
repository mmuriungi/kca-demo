page 52178674 "Proc Professional Opinion"
{
    CardPageId = "PROC Proff Opinion.Quote";
    Caption = 'Professional Opinion';
    PageType = List;
    SourceTable = "Proc Proffessional Opinion";
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    SourceTableView = where(Status = filter("Pending Approval"));
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.', Comment = '%';
                }
                field("Date Submitted"; Rec."Date Submitted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Submitted field.', Comment = '%';
                }
                field("Procurement Methods"; Rec."Procurement Methods")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement methods field.';
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition No. field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Submitted By"; Rec."Submitted By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Submitted By field.', Comment = '%';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        rec.SetFilter("Accounting Officer", '%1', UserId);
    end;

    trigger OnAfterGetRecord()
    begin
        rec.SetFilter("Accounting Officer", '%1', UserId);
    end;
}
