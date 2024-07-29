page 54261 "FLT-Driver Vehicle Card"
{
    PageType = List;
    SourceTable = "FLT-Driver Vehicle";

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
                field("License Number"; Rec."License Number")
                {
                    ApplicationArea = All;
                }
                field("License Expiry"; Rec."License Expiry")
                {
                    ApplicationArea = All;
                }
                field(Vehicle; Rec.Vehicle)
                {
                    ApplicationArea = All;
                }
                field("Vehicle Make"; Rec."Vehicle Make")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Model"; Rec."Vehicle Model")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Registration No."; Rec."Vehicle Registration No.")
                {
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
                field("Rotation No"; Rec."Rotation No")
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

