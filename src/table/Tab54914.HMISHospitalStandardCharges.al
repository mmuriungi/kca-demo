table 54914 "HMIS-Hospital Standard Charges"
{

    fields
    {
        field(1; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Registration,Triage,Consultation,Observation,Laboratory,Theater,External Referal,Internal Referal,Radiology,CCC Clinic,Awaiting Admision,Admitted,Discharged,Pharmacy,Appointment,Operation';
            OptionMembers = Registration,Triage,Consultation,Observation,Laboratory,Theater,"External Referal","Internal Referal",Radiology,"CCC Clinic","Awaiting Admision",Admitted,Discharged,Pharmacy,Appointment,Operation;
        }
        field(2; "Patient Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMIS-Central Setup Values".Code WHERE("Setup Group" = FILTER('PATIENT CATOGORIES'));
        }
        field(3; "Charge Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "HMIS-Charge Codes"."Charge Code";
        }
        field(4; "Charge Description"; Text[150])
        {
            /*  CalcFormula = Lookup("HMIS-Charge Codes"."Charge Description" WHERE (Status=FIELD(Status),
                                                                                  Charge Code=FIELD(Charge Code)));
             FieldClass = FlowField; */
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Applies To"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Both,Outpatient,Inpatient';
            OptionMembers = Both,Outpatient,Inpatient;
        }
    }

    keys
    {
        key(Key1; Status, "Patient Type", "Charge Code")
        {
        }
    }

    fieldgroups
    {
    }
}

