page 54463 "Mail Actors"
{
    Caption = 'Mail Actors';
    PageType = ListPart;
    SourceTable = "Mail Actor";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Actor ID"; Rec."Actor ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actor ID field.';
                }
                field("Actor Name"; Rec."Actor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actor Name field.';
                }
                field(EMail; Rec.EMail)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EMail field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field(Acted; Rec.Acted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Acted field.';
                }
            }
        }
    }

}
