page 54253 "FLT-Approved Transport Req."
{
    Caption = 'Approved Transport Requisition';
    PageType = List;
    SourceTable = "FLT-Transport Requisition";
    SourceTableView = ORDER(Ascending)
                      WHERE(Status = FILTER(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transport Requisition No"; Rec."Transport Requisition No")
                {
                    ApplicationArea = All;
                }
                field(Commencement; Rec.Commencement)
                {
                    ApplicationArea = All;
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Allocated"; Rec."Vehicle Allocated")
                {
                    ApplicationArea = All;
                }
                field("Driver Allocated"; Rec."Driver Allocated")
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field("Date of Request"; Rec."Date of Request")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Allocated by"; Rec."Vehicle Allocated by")
                {
                    ApplicationArea = All;
                }
                field("Opening Odometer Reading"; Rec."Opening Odometer Reading")
                {
                    ApplicationArea = All;
                }
                field("Purpose of Trip"; Rec."Purpose of Trip")
                {
                    ApplicationArea = All;
                }
                field("Date of Trip"; Rec."Date of Trip")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field("Date Requisition Received"; Rec."Date Requisition Received")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec."Department Code")
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

