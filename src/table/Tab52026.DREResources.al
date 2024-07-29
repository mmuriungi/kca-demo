table 52026 "DRE-Resources"
{
    Caption = 'DRE-Resources';
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Resource Type"; Option)
        {
            OptionMembers = " ","Lab Equipment","Research Facilities",Personel;
        }
        field(2; "Resource No"; code[20])
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
        field(9; Description; Text[200])
        {

        }
        field(4; "Resource Cost"; Decimal)
        {

        }
        field(5; Entry; Integer)
        {
            AutoIncrement = true;
        }
        field(6; Status; Option)
        {
            OptionMembers = Active,Inactive;
        }
        field(7; "Specialization"; text[100])
        {

        }
        field(8; "Date of Intallation"; date)
        {

        }
        field(10; "Active Projects"; Integer)
        {
            CalcFormula = count("Project Resource Req Lines" where("Resource No" = field("Resource No")));
            FieldClass = FlowField;
        }

    }
    keys
    {
        key(PK; "Resource No")
        {
            Clustered = true;
        }
    }
    var
        hrEmp: Record "HRM-Employee C";
        FA: Record "Fixed Asset";
}
