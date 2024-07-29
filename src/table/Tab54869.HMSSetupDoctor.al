table 54869 "HMS-Setup Doctor"
{
    LookupPageID = "HMS-Setup Doctor Lists";

    fields
    {
        field(1; "User ID"; Code[20])
        {
            Description = 'Stores the reference to the user in the database';
            TableRelation = "User Setup"."User ID";
            NotBlank = true;
            trigger OnValidate()
            begin

                "Doctor's Name" := user."Full Name";
            end;
        }
        field(2; "Doctor's Name"; Text[30])
        {
            Description = 'Stores the reference to the doctor''s name in the database';
            FieldClass = Normal;
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }
    var
        user: Record user;
}

