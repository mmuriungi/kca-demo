page 54250 "fLT-Fuel Card"
{
    PageType = List;
    SourceTable = "FLT-Fuel Consumption";
    Caption = 'FLT-Fuel Card';

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field(Driver; Rec.Driver)
                {
                    ApplicationArea = All;
                }
                field("Ticket No."; Rec."Ticket No.")
                {
                    ApplicationArea = All;
                }
                field("Place of Travel"; Rec."Place of Travel")
                {
                    ApplicationArea = All;
                }
                field("Odometer Reading"; Rec."Odometer Reading")
                {
                    ApplicationArea = All;
                }
                field("Litres  Consumed"; Rec."Litres  Consumed")
                {
                    ApplicationArea = All;
                }
                field("Amount Per Litres"; Rec."Amount Per Litres")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Fueling Station"; Rec."Fueling Station")
                {
                    ApplicationArea = All;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = All;
                }
                field("Previous ODO Reading"; Rec."Previous ODO Reading")
                {
                    ApplicationArea = All;
                }
                field("Fuel Type"; Rec."Fuel Type")
                {
                    ApplicationArea = All;
                }
                field("Service No."; Rec."Service No.")
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

