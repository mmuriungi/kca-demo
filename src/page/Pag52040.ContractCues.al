page 52040 "Contract Cues"
{
    ApplicationArea = All;
    Caption = 'Contract Cues';
    PageType = CardPart;
    SourceTable = "Contract Cues";

    layout
    {
        area(Content)
        {
            cuegroup("Contract Management")
            {
                field("Contracts (Open)"; rec."Contracts (Open)")
                {
                    ToolTip = 'Specifies the value of the Contracts (Open) field.';
                    ApplicationArea = All;
                    DrillDownPageId = "Projects List";
                    StyleExpr = 'Favorable';
                }
                field("Contracts (Running)"; Rec."Contracts (Running)")
                {
                    ToolTip = 'Specifies the value of the Contracts (Running) field.';
                    ApplicationArea = All;
                    DrillDownPageId = "Projects Approved";
                    StyleExpr = 'Favorable';
                }
                field("Contracts (Finished)"; Rec."Contracts (Finished)")
                {
                    ToolTip = 'Specifies the value of the Contracts (Finished) field.';
                    ApplicationArea = All;
                    DrillDownPageId = "Projects Finished";
                    StyleExpr = 'Favorable';
                }
                field("Contracts (Suspended)"; Rec."Contracts (Suspended)")
                {
                    ToolTip = 'Specifies the value of the Contracts (Suspended) field.';
                    ApplicationArea = All;
                    DrillDownPageId = "Projects Suspended";
                    StyleExpr = 'Favorable';
                }
                field("Contracts (Pending Verif)"; Rec."Contracts (Pending Verif)")
                {
                    ToolTip = 'Specifies the value of the Contracts (Pending Verification) field.';
                    ApplicationArea = All;
                    DrillDownPageId = "Projects Pending Verification";
                    StyleExpr = 'Favorable';
                }
                field("Contracts (Verified)"; Rec."Contracts (Verified)")
                {
                    ToolTip = 'Specifies the value of the Contracts (Verified) field.';
                    ApplicationArea = All;
                    DrillDownPageId = "Projects Verified";
                    StyleExpr = 'Favorable';
                }
            }
        }
    }
}
