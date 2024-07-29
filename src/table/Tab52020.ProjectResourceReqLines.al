table 52020 "Project Resource Req Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Project ReqNo"; Code[20])
        {

        }
        field(2; "Resource Type"; Option)
        {
            OptionMembers = " ","Lab Equipment","Research Facilities",Personel;
        }
        field(3; "Resource No"; code[20])
        {
            TableRelation = IF ("Resource Type" = CONST("Lab Equipment")) "Fixed Asset" else
            if ("Resource Type" = const("Research Facilities")) "Fixed Asset" else
            if ("Resource Type" = const(Personel)) "HRM-Employee C"."No.";
            trigger OnValidate()
            begin
                Description := '';
                if Rec."Resource Type" = Rec."Resource Type"::Personel then begin
                    hrEmp.Reset();
                    hrEmp.SetRange("No.", "Resource No");
                    IF hrEmp.Find('-') then begin
                        Description := hrEmp."First Name" + ' ' + hrEmp."Last Name";
                    end;

                end else
                    FA.Get("Resource No");
                Description := FA.Description;
            end;
        }
        field(4; Description; Text[200])
        {

        }
        field(5; "Resource Cost"; Decimal)
        {

        }
        field(6; Entry; Integer)
        {
            AutoIncrement = true;
        }

    }

    keys
    {
        key(Key1; "Project ReqNo", Entry)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        hrEmp: Record "HRM-Employee C";
        FA: Record "Fixed Asset";

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}