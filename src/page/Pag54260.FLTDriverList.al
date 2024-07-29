page 54260 "FLT-Driver List"
{
    CardPageID = "FLT-Driver Card";
    PageType = List;
    SourceTable = "FLT-Driver";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Driver; Rec.Driver)
                {
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                }
                field("Driver License Number"; Rec."Driver License Number")
                {
                    ApplicationArea = All;
                }
                field("Last License Renewal"; Rec."Last License Renewal")
                {
                    ApplicationArea = All;
                }
                field("Renewal Interval"; Rec."Renewal Interval")
                {
                    ApplicationArea = All;
                }
                field("Renewal Interval Value"; Rec."Renewal Interval Value")
                {
                    ApplicationArea = All;
                }
                field("Next License Renewal"; Rec."Next License Renewal")
                {
                    ApplicationArea = All;
                }
                field("Year Of Experience"; Rec."Year Of Experience")
                {
                    ApplicationArea = All;
                }
                // field(Grade; Rec.Grade)
                // {
                //     ApplicationArea = All;
                // }
                field(Active; Rec.Active)
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

