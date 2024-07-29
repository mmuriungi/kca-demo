tableextension 50850 "Dimension Values Ext" extends "Dimension Value"
{
    fields
    {
        field(9001; "G/L Account No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
            trigger OnValidate()
            var
                gl: Record "G/L Account";
            begin
                gl.Reset();
                gl.SetRange("No.", "G/L Account No.");
                if gl.Find('-') then
                    "G/L Name" := gl.Name;
            end;
        }
        field(9002; "G/L Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5000000; "Falls Under"; Code[20])
        {
            Caption = 'Falls Under';
            DataClassification = ToBeClassified;
        }

    }
}