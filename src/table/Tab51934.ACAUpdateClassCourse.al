table 51934 "ACA-Update Class Course"
{

    fields
    {
        field(1; "Student No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF CUST.GET("Student No.") THEN BEGIN
                    CUST."Class Code" := Code;
                    CUST.MODIFY;
                END;
            end;
        }
        field(2; "Code"; Code[20])
        {
        }
        field(3; Description; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Student No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CUST: Record Customer;
        classcode: Record "ACA-Course Classes";
        coreg: Record "ACA-Course Registration";
}

