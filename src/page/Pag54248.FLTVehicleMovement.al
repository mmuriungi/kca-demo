page 54248 "FLT-Vehicle Movement"
{
    PageType = Card;
    SourceTable = "FLT-Vehicle Movement";
    Caption = 'FLT-Vehicle Movement';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Vehicle Reg No."; Rec."Vehicle Reg No.")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ApplicationArea = All;
                }
                field("Ticket No"; Rec."Ticket No")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Station Code"; Rec."Station Code")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Location"; Rec."Vehicle Location")
                {
                    ApplicationArea = All;
                }
                field("Dispatched By"; Rec."Dispatched By")
                {
                    ApplicationArea = All;
                }
                field("Dispatch Date"; Rec."Dispatch Date")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("Closed On"; Rec."Closed On")
                {
                    ApplicationArea = All;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = All;
                }
                field("Dispatch Type"; Rec."Dispatch Type")
                {
                    ApplicationArea = All;
                }
                field("Current ODO Reading"; Rec."Current ODO Reading")
                {
                    ApplicationArea = All;
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = All;
                }
                part(Control1102755007; "FLT-Vehicle Movement Lines")
                {
                    SubPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

