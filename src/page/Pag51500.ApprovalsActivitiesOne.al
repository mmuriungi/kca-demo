page 51500 "Approvals Activities One"
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
                Caption = 'Head of Department/Faculty/Section';


                field("HOD Requests"; Rec."HOD Requests")
                {
                    DrillDownPageId = "FLT-Transport Req. List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HOD Requests field.';
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
        //   Rec.SetRange("Document Type", Rec."Document Type"::"Transport Requisition");
    end;
}