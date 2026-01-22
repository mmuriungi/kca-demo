table 50706 "MOU lists"
{
    Caption = 'MOU lists';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No"; Code[20])
        {

        }
        field(2; "Mou Description"; text[100])
        {

        }
        field(3; Date; Date)
        {
            trigger OnValidate()
            begin
                genSetUp.Get();
                genSetUp.TestField("Project Req No");
                Rec.No := noseries.GetNextNo(genSetUp.mouNos, TODAY, TRUE);
            end;
        }
        field(4; "MOU expiry Date"; Date)
        {

        }
        field(5; Status; Option)
        {
            OptionMembers = " ",Active,Inactive,Expired,Terminated;
        }
        field(6; "Department Code"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
        }
        field(7; "Faculty Code"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('FACULTY'));
        }
        field(8; validity; text[20])
        {

        }
        field(9; Type; Option)
        {
            OptionMembers = MOU,MOA;
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
    var
        genSetUp: Record "ACA-General Set-Up";
        noseries: Codeunit NoSeriesManagement;
}
