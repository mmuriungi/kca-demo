page 54951 "HMS-Setup Lab Pack Test SF"
{
    PageType = List;
    SourceTable = "HMS-Setup Lab Package Test";

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field(Test; Rec.Test)
                {
                    ApplicationArea = All;
                }
                field("Test Name"; Rec."Test Name")
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

