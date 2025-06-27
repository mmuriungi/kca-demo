tableextension 50043 "Workflow UserGroup Ext" extends "Workflow User Group"
{
    fields
    {
        field(50000; "Department Code"; Code[25])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            trigger OnValidate()
            var
                DimValue: Record "Dimension Value";
            begin
                DimValue.Reset();
                DimValue.SetRange("Global Dimension No.", 2);
                DimValue.SetRange(Code, "Department Code");
                if DimValue.FindFirst() then begin
                    "Department Name" := DimValue.Name;
                end;
            end;
        }
        field(50001; "Department Name"; Text[250])
        {
            Caption = 'Department Name';
            DataClassification = ToBeClassified;
        }
    }
}
