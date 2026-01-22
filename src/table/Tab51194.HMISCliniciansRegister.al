table 51194 "HMIS-Clinicians Register"
{

    fields
    {
        field(1; "Angagement Terms"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(2; "ID No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Rec."Angagement Terms" = Rec."Angagement Terms"::Internal THEN BEGIN
                    HRMEmployeeC.RESET;
                    HRMEmployeeC.SETRANGE("ID Number", Rec."ID No");
                    IF NOT (HRMEmployeeC.FIND('-')) THEN ERROR('Invalid ID Number!');
                    "PF. No" := HRMEmployeeC."No.";
                    "Full Names" := HRMEmployeeC."First Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name";
                END;
            end;
        }
        field(3; "PF. No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Full Names"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "User Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "User Setup"."User ID";
        }
        field(6; "Active Login"; Boolean)
        {
            CalcFormula = Exist("Active Session" WHERE("User ID" = FIELD("User Name")));
            FieldClass = FlowField;
        }
        field(7; "Current Room"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Patients on Queue"; Integer)
        {
            /* CalcFormula = Count(HMIS-Visits/Registrations WHERE ("Batch Date"=FIELD("Current Date"),
                                                                 "Clinician ID"=FIELD("User Name"),
                                                                 Status=FILTER(Consultation)));
            FieldClass = FlowField; */
        }
        field(9; "Current Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Is Active"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Angagement Terms", "ID No", "User Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Current Date" := TODAY;
    end;

    var
        HRMEmployeeC: Record "HRM-Employee C";
}

