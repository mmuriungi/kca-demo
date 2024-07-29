page 54940 "HMS-Setup Card"
{
    PageType = Card;
    SourceTable = "HMS-Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Patient Nos"; Rec."Patient Nos")
                {
                    ApplicationArea = All;
                }
                field("Appointment Nos"; Rec."Appointment Nos")
                {
                    ApplicationArea = All;
                }
                field("Observation Nos"; Rec."Observation Nos")
                {
                    ApplicationArea = All;
                }
                field("Visit Nos"; Rec."Visit Nos")
                {
                    ApplicationArea = All;
                }
                field("Lab Test Request Nos"; Rec."Lab Test Request Nos")
                {
                    Caption = 'Laboratory Test Nos';
                    ApplicationArea = All;
                }

                field("Radiology Nos"; Rec."Radiology Nos")
                {
                    ApplicationArea = All;
                }
                field("Pharmacy Nos"; Rec."Pharmacy Nos")
                {
                    ApplicationArea = All;
                }
                field("Admission Request Nos"; Rec."Admission Request Nos")
                {
                    ApplicationArea = All;
                }
                field("Referral Nos"; Rec."Referral Nos")
                {
                    ApplicationArea = All;
                }
                field("Pharmacy Items Nos"; Rec."Pharmacy Items Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pharmacy Items Nos field.';
                }
                field("Pharmacy Stock"; Rec."Pharmacy Stock")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pharmacy Stock field.';
                }
                field("Pharmacy Requisition"; Rec."Pharmacy Requisition")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pharmacy Requisition field.';
                }
            }
            group(Pharmacies)
            {
                Caption = 'Pharmacies';
                field("Pharmacy Item Journal Template"; Rec."Pharmacy Item Journal Template")
                {
                    ApplicationArea = All;
                }
                field("Pharmacy Item Journal Batch"; Rec."Pharmacy Item Journal Batch")
                {
                    ApplicationArea = All;
                }
                field("Pharmacy Location"; Rec."Pharmacy Location")
                {
                    ApplicationArea = All;
                }
                field("Observation Room"; Rec."Observation Room")
                {
                    ApplicationArea = All;
                }
                field("Observation Item Journal Temp"; Rec."Observation Item Journal Temp")
                {
                    ApplicationArea = All;
                }
                field("Observation Item Journal Batch"; Rec."Observation Item Journal Batch")
                {
                    ApplicationArea = All;
                }
                field("Doctor Room"; Rec."Doctor Room")
                {
                    ApplicationArea = All;
                }
                field("Doctor Item Journal Template"; Rec."Doctor Item Journal Template")
                {
                    ApplicationArea = All;
                }
                field("Doctor Item Journal Batch"; Rec."Doctor Item Journal Batch")
                {
                    ApplicationArea = All;
                }
                field("Laboratory Room"; Rec."Laboratory Room")
                {
                    ApplicationArea = All;
                }
                field("Laboratory Item Journal Temp"; Rec."Laboratory Item Journal Temp")
                {
                    ApplicationArea = All;
                }
                field("Laboratory Item Journal Batch"; Rec."Laboratory Item Journal Batch")
                {
                    ApplicationArea = All;
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill Students"; Rec."Bill Students")
                {
                    ApplicationArea = All;
                }
                field("Bill Employees"; Rec."Bill Employees")
                {
                    ApplicationArea = All;
                }
                field("Bill Other Categories"; Rec."Bill Other Categories")
                {
                    ApplicationArea = All;
                }
                field("Limit Of Next Of Kin"; Rec."Limit Of Next Of Kin")
                {
                    ApplicationArea = All;
                }
                field("Limit Age Of Next Of Kin(Yrs)"; Rec."Limit Age Of Next Of Kin(Yrs)")
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

