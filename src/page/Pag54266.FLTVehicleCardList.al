page 54266 "FLT-Vehicle Card List"
{
    CardPageID = "FLT-Vehicle Card";
    PageType = List;
    SourceTable = "FLT-Vehicle Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field(Capacity; rec.Capacity)
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field(Inactive; Rec.Inactive)
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Last Service Date"; Rec."Last serviced mileage")
                {
                    ApplicationArea = All;
                }
                field("Service Interval"; Rec."Service Interval")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Maintenance Vendor No."; Rec."Maintenance Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field("Year Of Manufacture"; Rec."Year Of Manufacture")
                {
                    ApplicationArea = All;
                }
                field("Country Of Origin"; Rec."Country Of Origin")
                {
                    ApplicationArea = All;
                }
                field(Ownership; Rec.Ownership)
                {
                    ApplicationArea = All;
                }
                field("Body Color"; Rec."Body Color")
                {
                    ApplicationArea = All;
                }
                field("Interior Color"; Rec."Interior Color")
                {
                    ApplicationArea = All;
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Chassis Serial No."; Rec."Chassis Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Engine Serial No."; Rec."Engine Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Ignition Key Code"; Rec."Ignition Key Code")
                {
                    ApplicationArea = All;
                }
                field("Door Key Code"; Rec."Door Key Code")
                {
                    ApplicationArea = All;
                }
                field("Tare Weight"; Rec."Tare Weight")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Open_Travel)
            {
                Caption = 'Open Travel Requests';
                Image = ResourceSetup;
                Promoted = true;
                RunObject = Page "FLT-Approved Transport Req.";
                RunPageLink = "Vehicle Allocated" = FIELD("Registration No.");
                ApplicationArea = All;
            }
            action(Open_Maint)
            {
                Caption = 'Open Maintenance/Fuel Requests';
                Image = History;
                Promoted = true;
                RunObject = Page "FLT-Fuel and Maint. List";
                RunPageLink = "Vehicle Reg No" = FIELD("Registration No.");
                ApplicationArea = All;
            }
        }
    }
}

