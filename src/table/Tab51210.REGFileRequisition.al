table 51210 "REG-File Requisition"
{

    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Requesting Officer"; Code[20])
        {
            TableRelation = "HRM-Employee C";

            trigger OnValidate()
            begin
                IF HREMP.GET("Requesting Officer") THEN BEGIN
                    Name := HREMP."First Name" + ' ' + HREMP."Middle Name" + ' ' + HREMP."Last Name";
                    Designation := HREMP."Job Title";
                END;
            end;
        }
        field(4; Name; Text[100])
        {
        }
        field(5; Designation; Code[20])
        {
        }
        field(6; "Collecting Officer"; Text[50])
        {
        }
        field(7; Purpose; Code[50])
        {
            TableRelation = "REG-File Request Reasons".Code;
        }
        field(8; "File No"; Code[20])
        {
            TableRelation = "REG-Registry Files"."File No." WHERE("File Status" = CONST(Active));

            trigger OnValidate()
            begin
                IF FileReq.GET("File No") THEN BEGIN
                    "File Name" := FileReq."File Subject/Description";
                END;
            end;
        }
        field(9; "File Name"; Text[100])
        {
        }
        field(10; "Authorized By"; Code[20])
        {
        }
        field(11; "Served By"; Code[50])
        {
        }
        field(12; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREMP: Record "HRM-Employee C";
        FileReq: Record "REG-Registry Files";
}

