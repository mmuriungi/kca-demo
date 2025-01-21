table 50695 "Research Projects"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ProjectCode; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Researcher"; Code[20])
        {

        }
        field(3; "Researcher Name"; text[200])
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        field(4; "Department Code"; code[20])
        {

        }
        field(5; "School Code"; code[20])
        {

        }
        field(6; Specialization; code[20])
        {

        }
        field(7; "Main Project Objective"; code[20])
        {

        }
        field(8; "Project Status"; Option)
        {
            OptionMembers = " ",Active,Inactive,Published;
        }
        field(9; "Start Date"; Date)
        {

        }
        field(10; "End Date"; Date)
        {

        }
        field(11; "Project Scope"; text[200])
        {

        }
        field(12; "Research Requisition No"; code[20])
        {
            TableRelation = "Project Resource Requisition";
        }
    }

    keys
    {
        key(Key1; ProjectCode)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
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