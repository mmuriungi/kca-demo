page 54262 "FLT-Vehicle Card"
{
    PageType = Card;
    SourceTable = "FLT-Vehicle Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    TableRelation = "Fixed Asset"."FA Class Code";

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin

                    end;

                }
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }

                field("Driver Number"; Rec."Responsible Driver")

                {
                    TableRelation = "FLT-Driver";
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Emp.Get(Rec."Responsible Driver") then begin

                            Rec."Driver Name" := Emp."First Name" + '' + Emp."Middle Name" + '' + Emp."Last Name";

                        end;
                    end;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;

                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vehicle Capacity"; Rec.Capacity)
                {
                    ApplicationArea = all;
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
                    Visible = false;
                    ApplicationArea = All;
                }

                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
            group("Vehicle Details")
            {
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
            group("Drive train")
            {
                field("Horse Power"; Rec."Horse Power")
                {
                    ApplicationArea = All;
                }
                field(Cylinders; Rec.Cylinders)
                {
                    ApplicationArea = All;
                }
                field("Tire Size Rear"; Rec."Tire Size Rear")
                {
                    ApplicationArea = All;
                }
                field("Tire Size Front"; Rec."Tire Size Front")
                {
                    ApplicationArea = All;
                }
            }

            group(Posting)
            {
                field("FA Class Code"; Rec."FA Class Code")
                {
                    ApplicationArea = All;
                }
                field("FA Subclass Code"; Rec."FA Subclass Code")
                {
                    ApplicationArea = All;
                }
                field("FA Location Code"; Rec."FA Location Code")
                {
                    ApplicationArea = All;
                }
                field("Budgeted Asset"; Rec."Budgeted Asset")
                {
                    ApplicationArea = All;
                }
            }
            group("Important Dates")
            {
                field("Inspection Start Date"; Rec."Inspection Start Date")
                {
                    ApplicationArea = All;
                }
                field("Inspection End Date"; rec."Inspection End Date")
                {
                    ApplicationArea = All;
                }
                field("Insurance Start Date"; rec."Insurance Start Date")
                {
                    ApplicationArea = All;
                }
                field("Insurance End Date"; rec."Insurance End Date")
                {
                    ApplicationArea = All;
                }
                field("Speed Governor Start Date"; rec."Speed Governor Start Date")
                {
                    ApplicationArea = All;
                }
                field("Speed Governor End Date"; rec."Speed Governor End Date")
                {
                    ApplicationArea = All;
                }
                field("Road service Lic start Date"; rec."Road service Lic start Date")
                {
                    ApplicationArea = All;
                }
                field("Road service Licence End Date"; rec."Road service Licence End Date")
                {
                    ApplicationArea = All;
                }


            }
            group(Maintenance)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Maintenance Vendor No."; Rec."Maintenance Vendor No.")
                {
                    ApplicationArea = All;
                }


                field("Last serviced mileage"; Rec."Last serviced mileage")
                {
                    ApplicationArea = All;
                }
                field("Next Service Mileage"; rec."Next Service Mileage")
                {
                    ApplicationArea = All;
                }
                field("Service Interval"; Rec."Service Interval")
                {
                    ApplicationArea = All;

                }
                field("Service Interval Value"; Rec."Service Interval Value")
                {
                    ApplicationArea = All;

                }
                field("Next Service Date"; Rec."Next Service Date")
                {
                    ApplicationArea = All;
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    ApplicationArea = All;
                }
                field(Insured; Rec.Insured)
                {
                    ApplicationArea = All;
                }
                field("Under Maintenance"; Rec."Under Maintenance")
                {
                    ApplicationArea = All;
                }
            }

            group("Mileage/Hrs Worded Details")
            {
                field("Readings Based On"; Rec."Readings Based On")
                {
                    ApplicationArea = All;
                }
                field("Start Reading"; Rec."Start Reading")
                {
                    ApplicationArea = All;
                }
                field("Current Reading"; Rec."Current Reading")
                {
                    ApplicationArea = All;
                }
                field("Fuel Type"; Rec."Fuel Type")
                {
                    ApplicationArea = All;
                }
                field("Fuel Rating"; Rec."Fuel Rating")
                {
                    ApplicationArea = All;
                }
                field("Total Consumption"; Rec."Total Consumption")
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
    var
        Emp: Record "HRM-Employee C";
}

