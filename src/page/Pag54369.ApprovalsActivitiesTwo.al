page 54369 "Approvals Activities Two"
{
    Caption = 'Transport Requisition';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Custom Approval CUEU";

    layout
    {
        area(content)
        {
            cuegroup(Approvals)
            {
                Caption = 'Transport Officer';

                field("Transport Officer"; Rec."Transport Officer")
                {
                    DrillDownPageId = "FLT-Transport Req. List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Requests field.';
                }
            }
        }

    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
        Rec.SetRange("User ID Filter", UserId);
        //  Rec.SetRange("Document Type", Rec."Document Type"::"Transport Requisition");
    end;
}