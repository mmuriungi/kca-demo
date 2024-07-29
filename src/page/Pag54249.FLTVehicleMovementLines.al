page 54249 "FLT-Vehicle Movement Lines"
{
    PageType = Listpart;
    SourceTable = "FLT-Vehicle Movement Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Driver No"; Rec."Driver No")
                {
                    ApplicationArea = All;
                }
                field("Hirers Name"; Rec."Hirers Name")
                {
                    ApplicationArea = All;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = All;
                }
                field("Starting Odometer"; Rec."Starting Odometer")
                {
                    ApplicationArea = All;
                }
                field("Ending Odometer"; Rec."Ending Odometer")
                {
                    ApplicationArea = All;
                }
                field(Mileage; Rec.Mileage)
                {
                    ApplicationArea = All;
                }
                field("In Time"; Rec."In Time")
                {
                    ApplicationArea = All;
                }
                field("Out Time"; Rec."Out Time")
                {
                    ApplicationArea = All;
                }
                field("Contract Hrs"; Rec."Contract Hrs")
                {
                    ApplicationArea = All;
                }
                field("Exceeded Hrs"; Rec."Exceeded Hrs")
                {
                    ApplicationArea = All;
                }
                field("Ticket No"; Rec."Ticket No")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                }
                field(Dispatched; Rec.Dispatched)
                {
                    ApplicationArea = All;
                }
                field("No of Approvals"; Rec."No of Approvals")
                {
                    ApplicationArea = All;
                }
                field(Received; Rec.Received)
                {
                    ApplicationArea = All;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = All;
                }
                field("Received Date"; Rec."Received Date")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
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

