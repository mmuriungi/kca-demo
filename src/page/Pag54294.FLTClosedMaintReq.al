page 54294 "FLT-Closed Maint. Req."
{
    PageType = Card;
    SourceTable = "FLT-Fuel & Maintenance Req.";
    SourceTableView = WHERE(Status = FILTER(Closed),
                            Type = FILTER(Maintenance));

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
                field("Vehicle Reg No"; Rec."Vehicle Reg No")
                {
                    ApplicationArea = All;
                }
                field("Vendor(Dealer)"; Rec."Vendor(Dealer)")
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
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Date Taken for Fueling"; Rec."Date Taken for Fueling")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Prepared By"; Rec."Prepared By")
                {
                    ApplicationArea = All;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = All;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No"; Rec."Vendor Invoice No")
                {
                    ApplicationArea = All;
                }
                field("Posted Invoice No"; Rec."Posted Invoice No")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Date Taken for Maintenance"; Rec."Date Taken for Maintenance")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Type of Maintenance"; Rec."Type of Maintenance")
                {
                    ApplicationArea = All;
                }
                field(Driver; Rec.Driver)
                {
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                }
                field("Fixed Asset No"; Rec."Fixed Asset No")
                {
                    ApplicationArea = All;
                }
                field("Litres of Oil"; Rec."Litres of Oil")
                {
                    ApplicationArea = All;
                }
                field("Quote No"; Rec."Quote No")
                {
                    ApplicationArea = All;
                }
                field("Price/Litre"; Rec."Price/Litre")
                {
                    ApplicationArea = All;
                }
                field("Type of Fuel"; Rec."Type of Fuel")
                {
                    ApplicationArea = All;
                }
                field(Coolant; Rec.Coolant)
                {
                    ApplicationArea = All;
                }
                field("Battery Water"; Rec."Battery Water")
                {
                    ApplicationArea = All;
                }
                field("Wheel Alignment"; Rec."Wheel Alignment")
                {
                    ApplicationArea = All;
                }
                field("Wheel Balancing"; Rec."Wheel Balancing")
                {
                    ApplicationArea = All;
                }
                field("Car Wash"; Rec."Car Wash")
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

