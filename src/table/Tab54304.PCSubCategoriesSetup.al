table 54304 "PC SubCategories Setup"
{
    Caption = 'PC SubCategories Setup';
    DataClassification = ToBeClassified;
    LookupPageId = "PC SubCategories List";
    DrillDownPageId = "PC SubCategories List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Category Code"; Code[20])
        {
            TableRelation = "PC WorkPlans Setup";
            Caption = 'Category Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PCWorkPlansSetup: Record "PC WorkPlans Setup";
            begin
                if PCWorkPlansSetup.Get("Category Code") then begin
                    "Category Description" := PCWorkPlansSetup."Performance Criteria";
                end;
            end;
        }
        field(4; "Category Description"; Text[250])
        {
            Caption = 'Category Description';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; "Document No."; Code[20])
        {
        }
    }
    keys
    {
        key(PK; "Code", "Document No.")
        {
            Clustered = true;
        }
    }
}
