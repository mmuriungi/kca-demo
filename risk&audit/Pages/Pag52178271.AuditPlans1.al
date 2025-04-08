page 50109 "Audit Plans 1"
{
    PageType = List;
    SourceTable = "Audit Period";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Period; rec.Period)
                {
                }
                field(Description; rec.Description)
                {
                }
                field("Global Dimension 1 Code"; GLSetup."Global Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Global Dimension 1 Code';
                    Editable = false;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
                field("Global Dimension 2 Code"; GLSetup."Global Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Global Dimension 2 Code';
                    Editable = false;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(EditAuditPlan)
            {
                Caption = 'Edit Audit Plan';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    AuditPlan: Page "Audit Plan";
                begin
                    //AuditPlan.SetAuditName(Period);
                    AuditPlan.RUN;
                end;
            }
        }
    }

    var
        GLSetup: Record "General Ledger Setup";
}

