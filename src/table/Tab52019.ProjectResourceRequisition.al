table 52019 "Project Resource Requisition"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;

        }
        field(2; "Researcher"; Code[20])
        {
            TableRelation = "HRM-Employee C";
            trigger OnValidate()
            begin
                hrEmp.Reset();
                hrEmp.SetRange("No.", Rec.Researcher);
                if hrEmp.Find('-') then begin
                    Rec."Researcher Name" := hrEmp."First Name" + ' ' + hrEmp."Last Name";
                    Rec."Department Code" := hrEmp."Department Code";
                    Rec."School Code" := hrEmp."Faculty Code";
                end;
            end;

        }
        field(3; "Researcher Name"; text[200])
        {

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
        field(7; "Main Project Objective"; Text[200])
        {

        }
        field(8; "Project Req No"; code[20])
        {

        }
        field(9; "Approval Information"; Text[200])
        {

        }
        field(10; Status; Option)
        {
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(11; "Date Requested"; Date)
        {
            trigger OnValidate()
            begin
                genSetUp.Get();
                genSetUp.TestField("Project Req No");
                "Project Req No" := noseries.GetNextNo(genSetUp."Project Req No", TODAY, TRUE);
                //Rec."Batch No." := "No.";
                //Rec.Modify();
            end;
        }
        field(12; "Project Scope"; text[200])
        {

        }
        field(13; "Project Duration"; Decimal)
        {

        }
        field(14; "Start Date"; Date)
        {

        }
        field(15; "End Date"; Date)
        {

        }
    }

    keys
    {
        key(Key1; No, "Project Req No", Researcher)
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
        genSetUp: Record "ACA-General Set-Up";
        noseries: Codeunit NoSeriesManagement;

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