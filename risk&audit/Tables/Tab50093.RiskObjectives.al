table 51319 "Risk Objectives"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Objective Code"; code[190])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Objective Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Status; Option)
        {
            OptionMembers = "",Active,Inactive;
        }
        field(4; "Function Code"; Code[90])
        {
            Caption = 'Function Code';
            TableRelation = Function;
            trigger OnValidate()
            var
                ObjFunction: Record Function;
            begin
                ObjFunction.Reset();
                ObjFunction.SetRange(ObjFunction."Function Code", "Function Code");
                if ObjFunction.FindFirst() then begin
                    "Function Description" := ObjFunction."Function Description";
                end
            end;
        }
        field(5; "Function Description"; Text[250])
        {
            Caption = 'Function Description';
            editable = false;
        }
        field(6; "Objective Average"; Decimal)
        {

        }
        field(7; Type; Option)
        {
            OptionMembers = ,Operational,Strategic;
        }


    }

    keys
    {
        key(Key1; "Objective Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Objective Code", "Objective Description")
        {
        }
    }

    var
        myInt: Integer;

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