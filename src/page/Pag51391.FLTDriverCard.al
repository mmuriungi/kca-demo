page 51391 "FLT-Driver Card"
{
    PageType = Card;
    InsertAllowed = true;
    SourceTable = "FLT-Driver";

    layout
    {
        area(content)
        {
            group(General)
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
                    Editable = true;
                }
                field("License Class"; Rec."License Class")
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
                field("Driver Grade"; Rec."Driver Grade")
                {
                    ApplicationArea = All;
                }
                field("PSV License Number"; Rec."PSV License Number")
                {
                    ApplicationArea = All;
                }
                field("PSV License Expiry"; Rec."PSV License Expiry")
                {
                    ApplicationArea = All;
                }
                field("Year Of Experience"; Rec."Year Of Experience")
                {
                    ApplicationArea = All;
                }
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

