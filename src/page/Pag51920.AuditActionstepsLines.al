page 51920 "Audit Action steps Lines"
{
    PageType = List;
    SourceTable = "Audit-Risk Treatment Act. Step";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Risk Code"; Rec."Risk Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(TreatmentCode; Rec.TreatmentCode)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Risk Treatment Action"; Rec."Risk Treatment Action")
                {
                    ApplicationArea = All;
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = All;
                }
                field(Verified; Rec.Verified)
                {
                    ApplicationArea = All;
                }
                field("Verified Date"; Rec."Verified Date")
                {
                    ApplicationArea = All;
                }
                field("Verified By"; Rec."Verified By")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

