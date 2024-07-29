page 54989 "HMS-Triage Recordings Lines"
{
    PageType = ListPart;
    SourceTable = "HMS-Triage Rec. lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Test Code"; Rec."Test Code")
                {
                    ApplicationArea = All;
                }
                field("Test Description"; Rec."Test Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Test Date"; Rec."Test Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Test Time"; Rec."Test Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Test By"; Rec."Test By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Readings; Rec.Readings)
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

