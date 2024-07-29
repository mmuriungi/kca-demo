page 50948 "REG-Registry Cue"
{
    PageType = CardPart;
    SourceTable = "REG-Registry Cue";

    layout
    {
        area(content)
        {
            cuegroup(Registry)
            {
                Caption = 'Registry';
                field("New Files"; Rec."New Files")
                {
                    Caption = 'New Files';
                    DrillDownPageID = "REG-Registry Files View";
                }
                field("Active Files"; Rec."Active Files")
                {
                    Caption = 'Active Files';
                    DrillDownPageID = "REG-Registry Files View";
                }
                field("Partially Active"; Rec."Partially Active")
                {
                    Caption = 'Partially Active Files';
                    DrillDownPageID = "REG-Registry Files View";
                }
                field(BrimgupFiles; Rec."Bring-up Files")
                {
                    Caption = 'Bring-up Files';
                    DrillDownPageID = "REG-Registry Files View";
                }
                field("Archived Files"; Rec."Archived Files")
                {
                    Caption = 'Archived Files';
                    DrillDownPageID = "REG-Registry Files View";
                }
            }
            cuegroup("Inbound Mails")
            {
                Caption = 'Inbound Mails';
                field(NewInbound; Rec."New Inbound Mails")
                {
                    Caption = 'New (Inbound)';
                    DrillDownPageID = "REG-Mail Register View";
                }
            }
            cuegroup("Outbound Mails")
            {
                Caption = 'Outbound Mails';
                field(OutboundNew; Rec."New Outbound Mails")
                {
                    Caption = 'New (Outbound)';
                    DrillDownPageID = "REG-Mail Register View";
                }
            }
        }
    }

    actions
    {
    }
}

