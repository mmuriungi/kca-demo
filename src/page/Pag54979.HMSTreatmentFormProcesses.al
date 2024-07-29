page 54979 "HMS-Treatment Form Processes"
{
    PageType = ListPart;
    SourceTable = "HMS-Treatment Form Process";

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
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                }
                field(Performed; Rec.Performed)
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

