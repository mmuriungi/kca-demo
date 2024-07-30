page 54290 "FLT-Maint. Req."
{
    PageType = Card;
    SourceTable = "FLT-Fuel & Maintenance Req.";
    SourceTableView = WHERE(Status = CONST(Open));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                }
                field("Requesting officer"; rec."Requesting officer")
                {
                    ApplicationArea = All;
                }
                field("Requester Name"; rec."Requester Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("requester Contact number"; rec."requester Contact number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Department; Rec.Department)
                {
                    Caption = 'designation';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Vehicle Reg No"; Rec."Vehicle Reg No")
                {
                    ApplicationArea = All;
                }
                field("Date of Service"; rec."Date of Service")
                {

                }
                field("Maintanance Type"; rec."Maintanance Type")
                {
                    ApplicationArea = all;
                }
            }
            group("Service Request")
            {

                field("mileage at request of services"; rec."mileage at request of services")
                {
                    ApplicationArea = All;
                }
                field("mileage at service"; Rec."mileage at service")
                {
                    ApplicationArea = All;

                }
                field("Price/Litre"; rec."Price/Litre")
                {
                    ApplicationArea = All;
                }
                field("Quantity of Fuel(Litres)"; Rec."Quantity of Fuel(Litres)")
                {
                    ApplicationArea = All;
                }
                field("Total Price of Fuel"; Rec."Total Price of Fuel")
                {
                    ApplicationArea = All;
                }
                field("Odometer Reading"; Rec."Odometer Reading")
                {
                    ApplicationArea = All;
                }
                field("Prepared By"; Rec."Prepared By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    // actions
    // {
    // }
}

