table 54894 "HMS-Treatment Referral"
{
    DrillDownPageId = "HMS-Treatment Form Referral";
    LookupPageId = "HMS-Treatment Form Referral";

    fields
    {
        field(1; "Treatment No."; Code[20])
        {
        }
        field(2; "Hospital No."; Code[100])
        {
            TableRelation = "HMIS-Referal Facilities"."Facility Name";
            trigger OnValidate()
            var
                Hms: Record "HMIS-Referal Facilities";
            begin
                Hms.Get("Hospital No.");
                "Hospital Name" := Hms."Facility Name";

            end;
        }
        field(3; "Hospital Name"; Text[200])
        {

        }
        field(4; "Date Referred"; Date)
        {
        }
        field(5; "Contact person"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Contact WHERE("No." = FIELD("Hospital No.")));
            FieldClass = FlowField;
        }
        field(6; "Referral Reason"; Code[250])
        {
        }
        field(7; "Referral Remarks"; Text[2000])
        {
        }
        field(8; Status; Option)
        {
            CalcFormula = Lookup("HMS-Referral Header".Status WHERE("Treatment no." = FIELD("Treatment No."),
                                                                     "Hospital No." = FIELD("Hospital No.")));
            FieldClass = FlowField;
            OptionMembers = New,Referred,Released;
        }
        field(9; "Phone No."; text[100])
        {

        }
    }

    keys
    {
        key(Key1; "Treatment No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

