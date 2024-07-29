page 54304 "FLT-Cue"
{
    PageType = CardPart;
    SourceTable = "FLT-Cue";
    Caption = 'FLT-Cue';

    layout
    {
        area(content)
        {
            cuegroup("Registration Statistics")
            {
                Caption = 'Registration Statistics';
                field("New Transport Requisitions"; Rec."New Transport Requisitions")
                {
                    Caption = 'New Transport requisitions';
                    DrillDownPageID = "FLT-Transport Req. List";
                    ApplicationArea = All;
                }
                field("Approved Transport Req"; Rec."Approved Transport Req")
                {
                    Caption = 'Approved Transport Requisitions';
                    DrillDownPageID = "FLT-Approved transport Req";
                    ApplicationArea = All;
                }
                field("New Safari Notices"; Rec."New Safari Notices")
                {
                    Caption = 'New Travel Notices';
                    DrillDownPageID = "FLT-Safari Notices List";
                    ApplicationArea = All;
                }
                field(InactiveEmp; Rec."Approved Safari Notices")
                {
                    Caption = 'Approved Travel Notices';
                    DrillDownPageID = "FLT-Posted Safari Notices List";
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

