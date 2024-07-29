page 52021 "ACA-Lessons"
{
    PageType = CardPart;
    SourceTable = "ACA-Lessons";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Descrition; Rec.Descrition)
                {
                    ApplicationArea = All;
                }
                field("Full Time/Part Time"; Rec."Full Time/Part Time")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                }
                field("No Of Hours"; Rec."No Of Hours")
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

