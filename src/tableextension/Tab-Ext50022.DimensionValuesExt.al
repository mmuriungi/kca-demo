tableextension 50022 "Dimension Values Ext" extends "Dimension Value"
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
        field(13; "Senate Classification Based on"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Year of Study,Academic Year';
            OptionMembers = " ","Year of Study","Academic Year";
        }
        field(50000; Picture; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50001; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Semesters".Code;
        }
        field(50002; Signature; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50003; "HOD Names"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Titles; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Faculty Name"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(296704; Lost; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(56601; Category; Text[100])
        {
            Caption = 'Category';
            DataClassification = ToBeClassified;
        }
    }
}