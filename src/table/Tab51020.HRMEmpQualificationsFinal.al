table 51020 "HRM-Emp. Qualifications Final"
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        field(2; Type; Option)
        {
            OptionCaption = ' ,Internal,External,Others';
            OptionMembers = " ",Internal,External,Others;
        }
        field(3; "From Date"; Date)
        {
        }
        field(4; "To Date"; Date)
        {
        }
        field(5; Institution; Code[30])
        {
            TableRelation = "HRM-Institutions"."Institution Code";
        }
        field(6; Description; Text[150])
        {
        }
        field(7; Qualification; Option)
        {
            OptionCaption = ' ,Certificate,Diploma,Undergraduate,Masters,PHD,Higher Diploma';
            OptionMembers = " ",Certificate,Diploma,Undergraduate,Masters,PHD,"Higher Diploma";
        }
        field(8; "Institution Name"; Text[250])
        {
            CalcFormula = Lookup("HRM-Institutions"."Institution Name" WHERE("Institution Code" = FIELD(Institution)));
            FieldClass = FlowField;
        }
        field(9; "Highest Qualification"; Boolean)
        {

            trigger OnValidate()
            begin
                if ("Highest Qualification" = true) then begin
                    qual.Reset;
                    qual.SetRange(qual."Employee No.", "Employee No.");
                    qual.SetRange(qual."Highest Qualification", true);
                    if qual.Find('-') then begin
                        if qual.Count > 0 then Error('You cannot have more than one highest qualifications for' + Format(qual."Employee No."));
                    end;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Employee No.", Qualification, Type)
        {
        }
    }

    fieldgroups
    {
    }

    var
        qual: Record "HRM-Emp. Qualifications Final";
}

