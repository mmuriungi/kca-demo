table 52025 "ACA-Grants"
{
    Caption = 'ACA-Grants';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No"; Code[20])
        {

        }
        field(2; "Awarding agency"; text[200])
        {

        }
        field(3; "Grant Timeframe(In Months)"; Decimal)
        {

        }
        field(4; "Financial Year"; code[20])
        {
            TableRelation = "ACA-Academic Year";
        }
        field(5; "Store Title"; text[100])
        {

        }
        field(6; "Total Amount Awarded"; Decimal)
        {

        }
        field(7; "Remaining Amount"; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount where("Document No." = field(No)));
            FieldClass = FlowField;
        }
        field(8; Status; Option)
        {
            OptionMembers = New,Active,Posted;
        }
        field(9; "Grant Type"; Option)
        {
            OptionMembers = " ",External,"Vc Grant","Sub Grant";
        }
        field(10; "Document Date"; Date)
        {
            trigger OnValidate()
            begin
                genSetUp.Get();
                genSetUp.TestField("Project Req No");
                Rec.No := noseries.GetNextNo(genSetUp."Grant Nos", TODAY, TRUE);
            end;

        }
        field(11; "Receiving Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(12; "Grants Description"; text[500])
        {

        }
        field(13; Posted; Boolean)
        {

        }
        field(14; Awadee; Code[20])
        {
            TableRelation = "HRM-Employee C";
            trigger OnValidate()
            begin
                hrEmp.Reset();
                hrEmp.SetRange("No.", Rec.Awadee);
                if hrEmp.Find('-') then begin
                    Rec."Awadee Name" := hrEmp."First Name" + ' ' + hrEmp."Middle Name" + ' ' + hrEmp."Last Name";
                end;
            end;
        }
        field(15; "Awadee Name"; Text[200])
        {

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
        hrEmp: Record "HRM-Employee C";
}
