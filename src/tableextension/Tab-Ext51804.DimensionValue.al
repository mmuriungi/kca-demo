tableextension 51804 "Dimension Value" extends "Dimension Value"
{
    fields
    {
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

    }
}