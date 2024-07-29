page 54874 "HMS-Observation Form Proc"
{
    PageType = ListPart;
    SourceTable = "HMS-Observation Form Line Proc";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Process No."; Rec."Process No.")
                {
                    ApplicationArea = All;
                }
                field("Process Name"; Rec."Process Name")
                {
                    ApplicationArea = All;
                }
                field("Process Result"; Rec."Process Result")
                {
                    ApplicationArea = All;
                }
                field("Process Mandatory"; Rec."Process Mandatory")
                {
                    ApplicationArea = All;
                }
                field("Process Remarks"; Rec."Process Remarks")
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

