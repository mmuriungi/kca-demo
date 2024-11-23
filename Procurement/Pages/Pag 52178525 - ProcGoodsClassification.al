page 52178525 "Proc-Goods Classification"
{
    Caption = 'Proc-Goods Classification';
    PageType = List;
    SourceTable = "Proc-Goods Clasiffication";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Requirements")
            {
                ApplicationArea = all;
                Image = Reconcile;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Requirements: Record "Proc Classification Requiremnt";
                begin
                    Requirements.Reset();
                    Requirements.SetRange(Code, rec.Code);
                    ///if Requirements.Find('-') then
                    page.Run(page::"Proc Classifctn Requirements", Requirements, rec.Code);
                end;
            }
        }
    }
}
