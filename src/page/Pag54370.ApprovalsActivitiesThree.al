page 54370 "Approvals Activities Three"
{
    Caption = 'Transport Requsition';
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
                Caption = 'Registra (Vice-chancellor Office)';

                field("Registra Requests"; Rec."Registra Requests")
                {
                    DrillDownPageId = "FLT-Transport Req. List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registra Requests field.';
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
        // Rec.SetRange("Document Type", Rec."Document Type"::"Transport Requisition");
    end;
}